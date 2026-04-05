import sys

def read_name(data, offset):
    labels = []
    jumped = False
    original_offset = offset

    while True:
        length = data[offset]

        # pointer (compression)
        if length & 0xC0 == 0xC0:
            if not jumped:
                original_offset = offset + 2
            pointer = ((length & 0x3F) << 8) | data[offset + 1]
            offset = pointer
            jumped = True
            continue

        if length == 0:
            offset += 1
            break

        offset += 1
        labels.append(data[offset:offset+length].decode())
        offset += length

    if not jumped:
        return ".".join(labels), offset
    else:
        return ".".join(labels), original_offset


def parse_dns_response(data):
    # Header
    qdcount = int.from_bytes(data[4:6], 'big')
    ancount = int.from_bytes(data[6:8], 'big')

    offset = 12

    # Skip questions
    for _ in range(qdcount):
        _, offset = read_name(data, offset)
        offset += 4  # QTYPE + QCLASS

    # Parse answers
    results = []

    for _ in range(ancount):
        name, offset = read_name(data, offset)

        rtype = int.from_bytes(data[offset:offset+2], 'big')
        rclass = int.from_bytes(data[offset+2:offset+4], 'big')
        ttl = int.from_bytes(data[offset+4:offset+8], 'big')
        rdlength = int.from_bytes(data[offset+8:offset+10], 'big')
        offset += 10

        rdata = data[offset:offset+rdlength]
        offset += rdlength

        if rtype == 1:  # A record
            ip = ".".join(str(b) for b in rdata)
            results.append(ip)

    return results


if __name__ == "__main__":
    with open(sys.argv[1], "rb") as f:
        data = f.read()

    ips = parse_dns_response(data)

    for ip in ips:
        print(ip)

