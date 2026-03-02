#!/usr/bin/env bash
set -e 

date >init.log

# Nome da bridge
BRIDGE=br0
STABLE_ROUNDS=5

echo "[bridge] A aguardar interfaces do Kathara..." >>init.log

last_ifaces=""
stable_count=0

while true; do
    # lista interfaces eth*
    IFACES=$(ls /sys/class/net | grep '^eth[0-9]\+$' | sort | tr '\n' ' ')

    if [ "$IFACES" != "$last_ifaces" ]; then
        echo "  [bridge] Interfaces detetadas: $IFACES" >>init.log
        last_ifaces="$IFACES"
	stable_count=0
        stable_since=$(date +%s.%N)
    else
        stable_count=$((stable_count + 1))
    fi

    if [ "$stable_count" -ge "$STABLE_ROUNDS" ]; then
        break
    fi
    sleep 0.2
done

echo "[REP] Interfaces detetadas: $IFACES" >>init.log

sleep 0.2
# Create bridge 
ip link add name $BRIDGE type bridge stp_state 0

# Liga todas as eth* à bridge
for IF in $IFACES; do
    echo "[REP] Ligando $IF à bridge $BRIDGE" >>init.log
    ip link set "$IF" master "$BRIDGE"
    ip link set "$IF" up
done

ip link set $BRIDGE up

echo "[REP] Bridge $BRIDGE ativa com interfaces: $IFACES" >>init.log

sleep 5
# fecha terminal
exec tail -f /dev/null 
#exit
#exec /bin/bash
