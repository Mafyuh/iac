import asyncio
import json
import os
import sys
import urllib.request

from open_webui.models.models import ModelForm, Models

MODELS_URL = os.environ.get("MODELS_URL", "http://ai-proxy.ai.svc.cluster.local:3000/v1/models")
CATALOG_URL = os.environ.get("CATALOG_URL", "https://models.dev/catalog.json")
DRY_RUN = "--dry-run" in sys.argv

LABELS = {"none": "Off", "minimal": "Minimal", "low": "Low", "medium": "Medium", "high": "High", "xhigh": "Extra High", "max": "Max"}
ORDER = list(LABELS)
IGNORES_NONE = {"openai"}
PROVIDER_DEFAULT = {"openai": "medium"}
PROVIDER_ALIASES = {"opencode-zen": "opencode"}
ROUTE_SUFFIXES = ("-free", "-contributor")


def fetch(url):
    req = urllib.request.Request(url, headers={"User-Agent": "open-webui-thinking-sync"})
    with urllib.request.urlopen(req, timeout=60) as r:
        return json.load(r)


def lookup(providers, model_id):
    prefix, _, rest = model_id.partition("/")
    provider = PROVIDER_ALIASES.get(prefix.lower(), prefix.lower())
    models = providers.get(provider, {}).get("models", {})
    entry = models.get(rest)
    for suffix in ROUTE_SUFFIXES:
        if entry is None and rest.endswith(suffix):
            entry = models.get(rest[: -len(suffix)])
    return provider, entry


def build_control(provider, entry, current_default):
    if not entry or entry.get("reasoning") is not True:
        return None
    efforts, toggle = set(), False
    for option in entry.get("reasoning_options") or []:
        if option.get("type") == "effort":
            efforts.update(v for v in option.get("values") or [] if v in LABELS)
        elif option.get("type") == "toggle":
            toggle = True
    if toggle:
        efforts.add("none")
    if provider in IGNORES_NONE:
        efforts.discard("none")
    efforts = sorted(efforts, key=ORDER.index)
    if len(efforts) < 2:
        return None
    for candidate in (current_default, PROVIDER_DEFAULT.get(provider, "high"), "high", "medium"):
        if candidate in efforts:
            default = candidate
            break
    else:
        default = efforts[-1]
    return {
        "label": "Thinking",
        "default": default,
        "options": {e: {"label": LABELS[e], "params": {"reasoning_effort": e}} for e in efforts},
    }


async def main():
    providers = fetch(CATALOG_URL)["providers"]
    gateway_ids = {m["id"] for m in fetch(MODELS_URL)["data"]}
    changed = unchanged = skipped = 0
    for model in await Models.get_all_models():
        if model.id not in gateway_ids:
            continue
        params = model.params.model_dump()
        controls = params.get("model_controls") or {}
        existing = controls.get("thinking")
        provider, entry = lookup(providers, model.id)
        control = build_control(provider, entry, (existing or {}).get("default"))
        if control is None:
            skipped += 1
            continue
        if existing == control:
            unchanged += 1
            continue
        changed += 1
        print(f"{'would update' if DRY_RUN else 'update'} {model.id}: {list(control['options'])} default={control['default']}")
        if DRY_RUN:
            continue
        params["model_controls"] = {**controls, "thinking": control}
        form = ModelForm(
            id=model.id,
            base_model_id=model.base_model_id,
            name=model.name,
            meta=model.meta.model_dump(),
            params=params,
            commit_message="Sync thinking control from models.dev",
        )
        await Models.update_model_by_id(model.id, form)
    print(f"changed={changed} unchanged={unchanged} no_effort_levels={skipped}")


asyncio.run(main())
