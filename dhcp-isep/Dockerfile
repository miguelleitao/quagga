# syntax=docker/dockerfile:1
ARG BASE
# ============================================================
# Fase de compilação
# ============================================================
FROM ${BASE} AS builder
# ARG precisa de ser novamente declarado se for usado
# em instruções posteriores desta fase.
ARG BASE
 
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        git \
        ca-certificates \
        autoconf \
        automake \
        libtool \
        pkg-config \
    && rm -rf /var/lib/apt/lists/*
 
WORKDIR /opt
 
RUN git clone --depth 1 \
        https://gitlab.isc.org/isc-projects/dhcp.git && \
    cd dhcp && \
    ./configure --prefix=/usr/local && \
    make -j"$(nproc)" && \
    make install DESTDIR=/stage
 
# ============================================================
# Imagem final
# ============================================================
FROM ${BASE}
 
COPY init.version /init.version
 
COPY --from=builder /stage/ /
 
COPY dhcpd.init /etc/init.d/dhcpd
 
RUN chmod 0755 /etc/init.d/dhcpd && \
    ln -s dhcpd /etc/init.d/dhcpd6
