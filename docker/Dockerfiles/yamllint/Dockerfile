FROM node:25

RUN apt-get update && \
    apt-get install -y yamllint && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*