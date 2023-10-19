ARG BASE
FROM $BASE
ADD ./init.version /init.version
RUN mkdir -p opt; cd opt; git clone https://github.com/miguelleitao/ratools.git; \
	cd ratools/src; make ; make install-sysv ; cd ../..; rm -rf ratools
RUN mkdir -p opt; cd opt; git clone https://gitlab.isc.org/isc-projects/dhcp.git; \
	cd dhcp; ./configure; make; make install; cd ..; rm -rf dhcp
ADD ./dhcpd.init /etc/init.d/dhcpd
RUN cd /etc/init.d; ln -s dhcpd dhcpd6


