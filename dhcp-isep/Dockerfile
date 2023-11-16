ARG BASE
FROM $BASE
ADD ./init.version /init.version
RUN mkdir -p opt; cd opt; git clone https://gitlab.isc.org/isc-projects/dhcp.git; \
	cd dhcp; ./configure; make; make install; cd ..; rm -rf dhcp
RUN cd /etc/init.d; ln -s dhcpd dhcpd6

