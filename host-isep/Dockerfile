ARG BASE
FROM $BASE
COPY init.version /init.version
COPY 99-sysctl.conf /etc/sysctl.d/99-sysctl.conf
COPY init-host.sh /etc/profile.d/init-host.sh
RUN apt-get update && \
    apt-get -y install nmap
RUN adduser --disabled-password --gecos "" test && echo "test:test" |chpasswd
