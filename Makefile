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

OWNER = miguelleitao
IMG_NAME=$(shell basename `pwd`)
IMG_REPO=${OWNER}/${IMG_NAME}
IMG_TAG:=${IMG_REPO}:$(shell date +'%Y%m%d%H%M')
IMG_BASE?=kathara/quagga

#IMG_QUAGGA-ISEP=${OWNER}/quagga-isep
#IMG_HOST-ISEP=${OWNER}/host-isep
#IMG_DHCP-ISEP=${OWNER}/dhcp-isep

IMG_TARGETS=quagga-isep host-isep dhcp-isep

.PHONY:$(IMG_TARGETS)

all: $(IMG_TARGETS)

$(IMG_TARGETS):
	make -C $@ 

login:
	docker login

build-multi-host-isep: build-multi-quagga-isep
	$(BUILDX) -t ${IMG_HOST-ISEP}:latest --push --build-arg BASE=${IMG_QUAGGA-ISEP} host-isep 

build-multi-dhcp-isep: build-multi-quagga-isep
	$(BUILDX) -t ${IMG_DHCP-ISEP}:latest --push --build-arg BASE=${IMG_QUAGGA-ISEP} dhcp-isep 

build-multi-quagga-isep:
	$(BUILDX) -t ${IMG_QUAGGA-ISEP}:latest --push quagga-isep

build:
	@echo "Multiplatform building ${IMG}"
	@echo ${IMG} >init.version
	$(BUILDX) -t ${IMG_REPO}:latest --push --build-arg BASE=${IMG_BASE} .
	@echo "Done."


builderx:
	docker buildx create --name builderx --bootstrap --use

delete-builderx:
	docker buildx rm builderx		
