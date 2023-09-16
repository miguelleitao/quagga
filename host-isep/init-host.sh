#!/usr/bin/env bash
if [ "`whoami`" == "root" ] ; then
mount -o remount,rw proc /proc/sys
sysctl -w net.ipv6.conf.all.forwarding=0
sysctl -w net.ipv6.conf.all.router_solicitations=50
sysctl -w net.ipv6.conf.all.router_solicitation_interval=1
sysctl -w net.ipv6.conf.all.router_solicitation_delay=1
fi


