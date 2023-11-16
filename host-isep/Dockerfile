ARG BASE
FROM $BASE
ADD ./init.version /init.version
RUN apt-get update
RUN apt-get -y install nmap
RUN adduser --disabled-password --gecos "" test ; echo "test:test" |chpasswd
