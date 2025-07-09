
I used Docker exclusively for many years before learning Kubernetes, and I still rely on it regularly, especially for testing new images, since it's simple to get things running.

When a containerized service proves useful and becomes part of my routine, I migrate it to Kubernetes—*if* it’s feasible to do so.

That said, some services like **Jellyfin** will likely remain on Docker permanently, as it uses a dedicated GPU on a standalone host that isn’t practical to add to the Kubernetes cluster. Additionally, some complex multi-container applications like **Kasm** or **Wazuh** are either unstable on Kubernetes or lack proper support, making Docker the better option for those.

## 📁 Folder Structure

- Each subfolder contains a `docker-compose.yml` or `compose.yaml` file for a specific service or stack.
- Custom Dockerfiles for CI/CD and utility images are in [`Dockerfiles/`](Dockerfiles/README.md).
- Secrets and environment variable mappings are managed in [`secret-mappings.yml`](secret-mappings.yml).

## 🔐 Secrets Management

Secrets are referenced via environment variables and mapped using [`secret-mappings.yml`](secret-mappings.yml), with actual secret values managed externally via Bitwarden Secrets.

This maps the secrets to the correct stack's `.env` file on [Docker CD workflow](../.github/workflows/CD.yml) runs when the [`deploy-docker.yml`](../ansible/playbooks/deploy-docker.yml) playbook is executed using BWS CLI to retrieve the secret values.

I do this so I don't have to SSH into these hosts for .env updates and can just manage all of them in one file, which is Git-safe as the values you see in [`secret-mappings.yml`](secret-mappings.yml) are just UUID's for secrets which require my `BWS_ACCESS_TOKEN` to lookup.

