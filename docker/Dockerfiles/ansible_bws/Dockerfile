FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    PATH="/usr/local/bin:${PATH}" \
    PYTHONPATH="/usr/local/lib/python3.12/dist-packages"

# Install packages and clean up
RUN apt-get update && apt-get install -y --no-install-recommends \
    ansible \
    python3 \
    python3-pip \
    curl \
    unzip \
    git \
    jq \
    nodejs \
    ca-certificates \
    libssl3 \
    build-essential \
    wget \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /usr/lib/python3.12/EXTERNALLY-MANAGED

# Install Python packages
RUN pip install --no-cache-dir \
    bitwarden-sdk \
    oci

# Install Ansible collections
RUN ansible-galaxy collection install --force --upgrade \
    community.general \
    community.docker \
    netbox.netbox \
    oracle.oci

# Install Bitwarden bws CLI
RUN wget -q https://github.com/bitwarden/sdk-sm/releases/download/bws-v1.0.0/bws-x86_64-unknown-linux-gnu-1.0.0.zip \
 && unzip bws-x86_64-unknown-linux-gnu-1.0.0.zip \
 && chmod +x bws \
 && mv bws /usr/local/bin/ \
 && rm bws-x86_64-unknown-linux-gnu-1.0.0.zip

# Install kubectl
RUN curl -sSL "https://dl.k8s.io/release/$(curl -sSL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o kubectl \
 && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
 && rm -f kubectl

WORKDIR /ansible

CMD ["ansible-playbook", "--version"]
