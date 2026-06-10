FROM python:3.14-slim-trixie AS gmssl-builder
WORKDIR /app
ARG GMSSL_VERSION=3.1.1
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        cmake \
        make \
        gcc \
        g++ \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN set -ex \
    && git clone --branch v${GMSSL_VERSION} https://github.com/guanzhi/GmSSL.git \
    && cd GmSSL \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make -j"$(nproc)" \
    && make install