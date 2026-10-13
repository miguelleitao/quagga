#!/bin/sh
export LD_LIBRARY_PATH=/usr/local/lib
/usr/lib/frr/zebra --limit-fds 1000 -d
/usr/lib/frr/ripngd --limit-fds 1000 -d
# -f /etc/frr/ripngd.conf &

