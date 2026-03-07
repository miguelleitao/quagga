FROM kathara/quagga AS build
RUN apt-get update && \
    apt-get purge -y quagga && \
    apt-get install -y git autoconf automake libtool make \
                           libprotobuf-c-dev protobuf-c-compiler build-essential \
                           python3-dev python3-pytest python3-sphinx libjson-c-dev \
                           libelf-dev libreadline-dev cmake libcap-dev bison flex \
                           pkg-config texinfo gdb libgrpc-dev python3-grpc-tools \
                           libpcre2-dev && \
   rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/CESNET/libyang.git ;\
   cd libyang &&\
   git checkout v3.13.6 &&\
   mkdir build; cd build ;\
   cmake --install-prefix /usr -D CMAKE_BUILD_TYPE:String="Release" .. &&\
   make -j$(nproc) &&\
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
   make -j$(nproc) && make install-strip &&\
   cd .. && rm -rf frr
FROM kathara/base
RUN addgroup --system --gid 92 frr && \
  addgroup --system --gid 85 frrvty && \
  adduser --system --ingroup frr --home /var/opt/frr/ \
          --gecos "FRR suite" --shell /bin/false frr && \
  usermod -a -G frrvty frr
RUN mkdir -p /usr/lib/frr /etc/frr /var/log/frr &&\
    chown frr:frr /var/log/frr 
COPY --from=build /usr/lib/frr /usr/lib/frr
COPY --from=build /usr/lib/libfrr.so* /usr/lib/
#    ln -s /usr/lib/frr/frrinit.sh /usr/bin/frrinit.sh &&\
#    ln -s /usr/local/lib/libfrr.so.0 /usr/lib/libfrr.so.0
# Overwrite adapted frrinit.sh
COPY --chown=frr:frr frrinit.sh /usr/lib/frr/frrinit.sh
COPY --chown=frr:frr daemons /etc/frr/
COPY --chown=frr:frr vtysh.conf /etc/frr/
COPY --chown=frr:frr staticd.conf /etc/frr/
COPY --chown=frr:frr mgmtd.conf /etc/frr/
#
COPY init-isep.sh /usr/local/sbin/init-isep.sh
COPY init-isep.service /etc/systemd/system/init-isep.service
COPY init-isep.sh /etc/profile.d/init-isep.sh
COPY init.version /init.version
COPY apache2ctl /usr/sbin/apache2ctl
RUN cd /etc/init.d && rm -f quagga ripd zebra ospfd bgpd ripng ospf6d
#RUN systemctl enable init-isep.service
RUN rm /sbin/init; ln -s /usr/local/sbin/init-isep.sh /sbin/init
RUN ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/ ;\
    ln -s /var/state/quagga /var/run
ENTRYPOINT bash -l
