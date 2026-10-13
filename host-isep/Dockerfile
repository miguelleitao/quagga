ARG BASE
FROM $BASE
COPY init.version /init.version
COPY 99-sysctl.conf /etc/sysctl.d/99-sysctl.conf
COPY init-host.sh /etc/profile.d/init-host.sh
COPY apache2ctl /usr/sbin/apache2ctl
RUN apt-get update && \
    apt-get -y install nmap apache2
RUN adduser --disabled-password --gecos "" test && echo "test:test" |chpasswd
RUN ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/

