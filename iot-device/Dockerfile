FROM kathara/quagga
RUN apt-get update
RUN apt-get purge -y quagga
RUN apt-get install -y git autoconf automake libtool make 
RUN apt-get install -y libprotobuf-c-dev protobuf-c-compiler build-essential 
RUN apt-get install -y python3-dev python3-pytest python3-sphinx libjson-c-dev 
RUN apt-get install -y libelf-dev libreadline-dev cmake libcap-dev bison flex 
RUN apt-get install -y pkg-config texinfo gdb libgrpc-dev python3-grpc-tools
RUN apt-get install -y libpcre2-dev 
RUN git clone https://github.com/CESNET/libyang.git ;\
   cd libyang &&\
   git checkout v3.13.6 &&\
   mkdir build; cd build ;\
   cmake --install-prefix /usr -D CMAKE_BUILD_TYPE:String="Release" .. &&\
   make -j4 &&\
   make install &&\
   cd .. && rm -rf libyang
RUN addgroup --system --gid 92 frr
RUN addgroup --system --gid 85 frrvty
RUN adduser --system --ingroup frr --home /var/opt/frr/ \
   --gecos "FRR suite" --shell /bin/false frr
RUN usermod -a -G frrvty frr
RUN git clone https://github.com/miguelleitao/frr.git frr &&\
   cd frr ;\
   ./bootstrap.sh &&\
   ./configure \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --sbindir=/usr/lib/frr \
    --enable-multipath=64 \
    --enable-user=frr \
    --enable-group=frr \
    --enable-vty-group=frrvty \
    --enable-configfile-mask=0640 \
    --enable-logfile-mask=0640 \
    --enable-fpm \
    --with-pkg-git-version \
    --with-pkg-extra-version=-isep &&\
   make -j4 &&\
   make check &&\
   make install-strip &&\
   mkdir -p /usr/lib/frr /etc/frr /var/log/frr &&\
   chown frr:frr /var/log/frr &&\
   ln -s /usr/lib/frr/frrinit.sh /usr/bin/frrinit.sh &&\
   ln -s /usr/local/lib/libfrr.so.0 /usr/lib/libfrr.so.0 &&\
   cd .. && rm -rf frr
# Overwrite adapted frrinit.sh
COPY --chown=frr:frr frrinit.sh /usr/lib/frr/frrinit.sh
COPY --chown=frr:frr daemons  /etc/frr/
#
COPY ./init-isep.sh /usr/local/sbin/init-isep.sh
ADD ./init-isep.service /etc/systemd/system/init-isep.service
ADD ./init-isep.sh /etc/profile.d/init-isep.sh
ADD ./init.version /init.version
ADD ./apache2ctl /usr/sbin/apache2ctl
RUN cd /etc/init.d && rm -f quagga ripd zebra ospfd bgpd ripng ospf6d
RUN systemctl enable init-isep.service
RUN rm /sbin/init; ln -s /usr/local/sbin/init-isep.sh /sbin/init
RUN ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/
RUN ln -s /var/state/quagga /var/run
#RUN sed -i 's/--oknodo\s--exec\s"$D_PATH\/$1"/--oknodo --name "$1"/' /etc/init.d/quagga
ENTRYPOINT bash -l
