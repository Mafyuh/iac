FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ansible \
    python3 \
    python3-pip \
    curl \
    unzip \
    git \
    nodejs \
    ca-certificates \
    libssl3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /usr/lib/python3.12/EXTERNALLY-MANAGED

RUN pip install --no-cache-dir bitwarden-sdk

RUN ansible-galaxy collection install \
    bitwarden.secrets \
    community.docker \
    community.general

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && export PATH="/root/.cargo/bin:$PATH" \
    && cargo install bws \
    && rm -rf /root/.cargo/registry /root/.cargo/git

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm -f kubectl


ENV PATH="/root/.cargo/bin:${PATH}"
ENV PYTHONPATH="/usr/local/lib/python3.12/dist-packages"

WORKDIR /ansible

CMD ["ansible-playbook", "--version"]
