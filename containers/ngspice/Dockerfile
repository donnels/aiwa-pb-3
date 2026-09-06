FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install --no-install-recommends -y ngspice \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["ngspice"]
