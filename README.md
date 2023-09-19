# quagga
Quagga images

## Included quagga images for ISEP lab works
### quagga-isep
Tunned and improved standard quagga router. Includes RIP, OSPF and BGP daemons. 

### dhcp-isep
Based on quagga-isep.
Adds Router Advertisement (for IPv6) and DHCP (IPv4 and IPv6) services.

### host-isep
Based on quagga-isep.
Disables forwading and accepts RA prefix.

## Rebuild image

```
cd _image_
[edit and tune Dockerfile]
[edit and tune other used scripts]
make
make push
```


