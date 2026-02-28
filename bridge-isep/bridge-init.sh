#!/bin/sh
# Nome da bridge
BRIDGE=br0
ETH0=eth0
ETH1=eth1

# criar bridge (kernel nativo)
ip link add name $BRIDGE type bridge  # opcional; se não tiver iproute2 pode usar: brctl addbr br0
brctl addbr $BRIDGE

# adicionar interfaces
brctl addif $BRIDGE $ETH0
brctl addif $BRIDGE $ETH1

# ativa bridge e interfaces
brctl stp br0 off          # opcional, desliga spanning tree
echo 1 > /sys/class/net/eth0/flags
echo 1 > /sys/class/net/eth1/flags
echo 1 > /sys/class/net/br0/flags

# mantém container vivo
tail -f /dev/null &

# fecha terminal
exit 0
