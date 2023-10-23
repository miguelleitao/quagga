# quagga
Building tools for Kathara images based on Quagga.
All images are build for amd64 and arm64 platforms.

## Included Quagga images for ISEP lab works
### quagga-isep
Tunned and improved standard Quagga router. Includes RIP, OSPF and BGP daemons. 

### dhcp-isep
Based on quagga-isep.
Adds Router Advertisement (for IPv6) and DHCP (IPv4 and IPv6) services.

### host-isep
Based on quagga-isep.
Disables forwading and accepts RA prefix.


## Use global targets

```
make login
make builderx		# install buildx container
make all		# build all images
make _image_		# build single image
```

## Rebuild single image

```
cd _image_
[edit and tune Dockerfile]
[edit and tune other used scripts]
make			# build new image and push it to Docker Hub
make pull		# optionaly, pull new image from Docker Hub to local repo
```


