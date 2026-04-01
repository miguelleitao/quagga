FROM miguelleitao/host-isep
COPY init.version /init.version
COPY init-host.sh /etc/profile.d/init-host.sh
RUN apt-get update && \
    apt-get -y install coturn socat && \
    rm -rf /var/lib/apt/lists/*
