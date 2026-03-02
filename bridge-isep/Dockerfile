# Dockerfile para nó repetidor Ethernet L2
#FROM alpine:latest
FROM kathara/base

# Instala pacotes mínimos: bash (ou sh) e brctl
#RUN apk add --no-cache bash bridge-utils
#RUN apk add --no-cache ebtables tcpdump bash

RUN apt-get update && \
    apt-get install -y --no-install-recommends bridge-utils iproute2 tcpdump && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copia o script init.sh para dentro do container
COPY bridge-init.sh /bridge-init.sh
RUN chmod +x /bridge-init.sh

COPY down /usr/local/bin/down
RUN chmod +x /usr/local/bin/down

COPY up /usr/local/bin/up
RUN chmod +x /usr/local/bin/up

# Comando padrão do container: executa init.sh
CMD ["/bridge-init.sh"]

