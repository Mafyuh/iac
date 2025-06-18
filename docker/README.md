
I used Docker exclusively for many years before learning Kubernetes, and I still rely on it regularly, especially for testing new images, since it's simple to get things running.

When a containerized service proves useful and becomes part of my routine, I migrate it to Kubernetes—*if* it’s feasible to do so.

That said, some services like **Jellyfin** will likely remain on Docker permanently, as it uses a dedicated GPU on a standalone host that isn’t practical to add to the Kubernetes cluster. Additionally, some complex multi-container applications like **Kasm** or **Wazuh** are either unstable on Kubernetes or lack proper support, making Docker the better option for those.



