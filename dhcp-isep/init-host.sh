#!/usr/bin/env bash
mount -o remount,rw proc /proc/sys
sysctl -w net.ipv6.conf.all.forwarding=1


