FROM kathara/quagga
#RUN apt-get update
COPY init-isep.sh /usr/local/sbin/init-isep.sh
COPY init-isep.service /etc/systemd/system/init-isep.service
COPY init-isep.sh /etc/profile.d/init-isep.sh
COPY init.version /init.version
COPY apache2ctl /usr/sbin/apache2ctl
RUN cd /etc/init.d ; rm -f quagga ripd zebra ospfd bgpd ripng ospf6d
COPY quagga.init /etc/init.d/quagga
COPY ripd.init /etc/init.d/ripd
COPY zebra.init /etc/init.d/zebra
COPY ospfd.init /etc/init.d/ospfd
COPY bgpd.init /etc/init.d/bgpd
COPY ripngd.init /etc/init.d/ripngd
COPY ospf6d.init /etc/init.d/ospf6d
RUN systemctl enable init-isep.service
RUN rm /sbin/init; ln -s /usr/local/sbin/init-isep.sh /sbin/init
RUN ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/
RUN ln -s /var/state/quagga /var/run
#RUN sed -i 's/--oknodo\s--exec\s"$D_PATH\/$1"/--oknodo --name "$1"/' /etc/init.d/quagga
ENTRYPOINT bash -l
