ARG BASE
FROM $BASE
ADD ./init.version /init.version
ADD ./99-sysctl.conf /etc/sysctl.d/99-sysctl.conf
ADD ./init-host.sh /etc/profile.d/init-host.sh
RUN apt-get update
RUN apt-get -y install nmap
RUN adduser --disabled-password --gecos "" test ; echo "test:test" |chpasswd
