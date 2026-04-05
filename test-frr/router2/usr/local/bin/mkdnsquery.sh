#!/bin/bash

# Uso: ./mkdnsquery.sh example.com > query.bin

DOMAIN="$1"

# Header DNS:
# ID=0x1234, flags=0x0100 (standard query, RD=1)
# QDCOUNT=1, ANCOUNT=0, NSCOUNT=0, ARCOUNT=0
printf '\x12\x34\x01\x00\x00\x01\x00\x00\x00\x00\x00\x00'

# Converter domain para formato DNS (labels)
IFS='.' read -ra LABELS <<< "$DOMAIN"

for label in "${LABELS[@]}"; do
    len=${#label}
    printf "\\x%02x" "$len"
    printf "%s" "$label"
done

# terminador do nome
printf '\x00'

# QTYPE = A (1)
printf '\x00\x01'

# QCLASS = IN (1)
printf '\x00\x01'

