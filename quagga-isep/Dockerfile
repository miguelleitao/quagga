FROM kathara/quagga
RUN apt-get update
ADD ./init-isep.sh /usr/local/sbin/init-isep.sh
ADD ./init-isep.service /etc/systemd/system/init-isep.service
ADD ./init-isep.sh /etc/profile.d/init-isep.sh
ADD ./init.version /init.version
ADD ./apache2ctl /usr/sbin/apache2ctl
RUN systemctl enable init-isep.service
RUN rm /sbin/init; ln -s /usr/local/sbin/init-isep.sh /sbin/init
RUN ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/
RUN ln -s /var/state/quagga /var/run
RUN sed -i 's/--oknodo\s--exec\s"$D_PATH\/$1"/--oknodo --name "$1"/' /etc/init.d/quagga
ENTRYPOINT bash -l
