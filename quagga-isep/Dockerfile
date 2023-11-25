FROM kathara/quagga
RUN apt-get update
ADD ./init-isep.sh /usr/local/sbin/init-isep.sh
ADD ./init-isep.service /etc/systemd/system/init-isep.service
ADD ./init-isep.sh /etc/profile.d/init-isep.sh
ADD ./init.version /init.version
ADD ./apache2ctl /usr/sbin/apache2ctl
ADD ./quagga.init /etc/init.d/quagga
ADD ./ripd.init /etc/init.d/ripd
ADD ./zebra.init /etc/init.d/zebra
ADD ./ospfd.init /etc/init.d/ospfd
ADD ./bgpd.init /etc/init.d/bgpd
ADD ./ripngd.init /etc/init.d/ripngd
ADD ./ospf6d.init /etc/init.d/ospf6d
RUN systemctl enable init-isep.service
RUN rm /sbin/init; ln -s /usr/local/sbin/init-isep.sh /sbin/init
RUN ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/
RUN ln -s /var/state/quagga /var/run
RUN sed -i 's/--oknodo\s--exec\s"$D_PATH\/$1"/--oknodo --name "$1"/' /etc/init.d/quagga
ENTRYPOINT bash -l
