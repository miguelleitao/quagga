FROM kathara/frr
LABEL org.opencontainers.image.authors="Miguel Leitão"
LABEL org.opencontainers.image.description="FRR router image"
LABEL org.opencontainers.image.version="1.0"
LABEL org.opencontainers.image.source="https://github.com/miguelleitao/quagga"
RUN apt-get update && \
   apt-get install -y dnsdist knot-dnsutils && \
   rm -rf /var/lib/apt/lists/*
#
COPY --chmod=755 init-isep.sh /usr/local/sbin/init-isep.sh
COPY --chmod=755 init-isep.service /etc/systemd/system/init-isep.service
COPY --chmod=755 init-isep.sh /etc/profile.d/init-isep.sh
COPY init.version /init.version
COPY --chmod=755 frrinit.sh /usr/lib/frr/frrinit.sh
#RUN systemctl enable init-isep.service
RUN rm /sbin/init; ln -s /usr/local/sbin/init-isep.sh /sbin/init
RUN ln -s /usr/lib/frr/frrinit.sh /usr/local/bin/frrinit.sh
ENTRYPOINT bash -l
