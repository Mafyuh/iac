FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

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
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /usr/lib/python3.12/EXTERNALLY-MANAGED

RUN pip install --no-cache-dir bitwarden-sdk

RUN ansible-galaxy collection install community.general

RUN ansible-galaxy collection install community.docker
# Download bws binary
RUN wget https://github.com/bitwarden/sdk-sm/releases/download/bws-v1.0.0/bws-x86_64-unknown-linux-gnu-1.0.0.zip \
    && unzip bws-x86_64-unknown-linux-gnu-1.0.0.zip \
    && chmod +x bws \
    && mv bws /usr/local/bin/ \
    && rm bws-x86_64-unknown-linux-gnu-1.0.0.zip

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm -f kubectl

ENV PATH="/usr/local/bin:${PATH}"
ENV PYTHONPATH="/usr/local/lib/python3.12/dist-packages"

WORKDIR /ansible

CMD ["ansible-playbook", "--version"]
