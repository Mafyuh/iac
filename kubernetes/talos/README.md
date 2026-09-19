# Talos configuration (talstomize)

Source of truth: `talstomize.yaml` + `patches/`, secrets in `talsecret.sops.yaml`.
Rendered per-node configs go to `clusterconfig/` (gitignored).

```bash
# Render
task talos:build

# Preview drift vs live (read-only) — always run before applying
task talos:diff-node-6          # one node
task talos:diff                 # all nodes

# Apply to ONE node at a time (renders first)
task talos:apply-node-6
```

There is deliberately no apply-to-all-nodes task. Apply per node and verify
health between nodes.
