#!/usr/bin/env bash
if [ "`whoami`" == "root" ] ; then
echo "Quagga-ISEP init"
chmod 755 /hostlab/*/usr/lib/cgi-bin/* >/dev/null 2>&1 || true
chmod 755 /hostlab/*/usr/sbin/* >/dev/null 2>&1 || true
chmod 755 /hostlab/*/usr/local/bin/* >/dev/null 2>&1 || true
date >/init.log
fi


