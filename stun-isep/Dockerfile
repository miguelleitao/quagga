FROM miguelleitao/quagga-isep
COPY init.version /init.version
COPY init-host.sh /etc/profile.d/init-host.sh
RUN apt-get update && \
    apt-get -y install coturn python3-pip python3-aiortc && \
    rm -rf /var/lib/apt/lists/*
