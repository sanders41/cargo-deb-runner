FROM rust:1.76-slim-bookworm as builder

RUN cargo install cargo-deb

FROM ubuntu:22.04

ENV \
  CARGO_HOME=/usr/local/cargo \
  RUSTUP_HOME=/usr/local/rustup

WORKDIR /builder

COPY --from=builder /usr/local/cargo /usr/local/cargo
COPY --from=builder /usr/local/rustup /usr/local/rustup

RUN : \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  libssl-dev \
  pkg-config \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENTRYPOINT ["/usr/local/cargo/bin/cargo", "deb"]
