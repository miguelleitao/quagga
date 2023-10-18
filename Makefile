#
# Makefile for quagga-isep docker image
#
# Miguel Leitao, 2022
# José Oliveira, 2023
#

# 
# install qemu emulators 
# docker run -it --rm --privileged tonistiigi/binfmt --install all
# 


BUILDX=docker buildx build --platform linux/amd64,linux/arm64

# IMG_QUAGGA-ISEP=miguelleitao/quagga-isep
# IMG_HOST-ISEP=miguelleitao/host-isep
# IMG_DHCP-ISEP=miguelleitao/dhcp-isep

IMG_QUAGGA-ISEP=jcboliveira/quagga-isep1
IMG_HOST-ISEP=jcboliveira/host-isep1
IMG_DHCP-ISEP=jcboliveira/dhcp-isep1

IMG:=${IMG_QUAGGA-ISEP}:$(shell date +'%Y%m%d%H%M')

login:
	docker login

build-multi-host-isep: build-multi-quagga-isep
	$(BUILDX) -t ${IMG_HOST-ISEP} --push host-isep

build-multi-dhcp-isep: build-multi-quagga-isep
	$(BUILDX) -t ${IMG_DHCP-ISEP} --push dhcp-isep

build-multi-quagga-isep:
	$(BUILDX) -t ${IMG_QUAGGA-ISEP} --push quagga-isep

builderx:
	docker buildx create --name builderx --use
	docker buildx inspect --bootstrap

delete-builderx:
	docker buildx rm builderx		
