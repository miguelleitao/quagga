# Dockerfile para nó repetidor Ethernet L2
FROM alpine:latest

# Instala pacotes mínimos: bash (ou sh) e brctl
RUN apk add --no-cache bash bridge-utils

# Copia o script init.sh para dentro do container
COPY bridge-init.sh /bridge-init.sh
RUN chmod +x /bridge-init.sh

# Comando padrão do container: executa init.sh
CMD ["/bridge-init.sh"]

