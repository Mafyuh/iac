FROM ghcr.io/actions/actions-runner:2.331.0

USER root

RUN apt-get -qq update && \
    apt-get -qq install -y --no-install-recommends --no-install-suggests \
        ca-certificates \
        jo \
        moreutils \
        wget \
        zstd \
        ansible && \
    rm -rf /var/lib/apt/lists/*

# Install Ansible collections
RUN ansible-galaxy collection install --force \
    community.general \
    community.docker \
    netbox.netbox \
    oracle.oci

# Install Bitwarden Secrets CLI
ARG BWS_VERSION=1.0.0
RUN wget -q "https://github.com/bitwarden/sdk-sm/releases/download/bws-v${BWS_VERSION}/bws-x86_64-unknown-linux-gnu-${BWS_VERSION}.zip" && \
    unzip "bws-x86_64-unknown-linux-gnu-${BWS_VERSION}.zip" && \
    chmod +x bws && \
    mv bws /usr/local/bin/ && \
    rm "bws-x86_64-unknown-linux-gnu-${BWS_VERSION}.zip"

# Install kubectl
RUN curl -sSL "https://dl.k8s.io/release/$(curl -sSL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o kubectl && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm -f kubectl

USER runner
