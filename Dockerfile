FROM ubuntu:20.04

WORKDIR /builder

RUN : \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN : \
  && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
  && /root/.cargo/bin/cargo install cargo-deb

ENTRYPOINT ["/root/.cargo/bin/cargo", "deb"]
