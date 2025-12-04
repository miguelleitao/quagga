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

OWNER=$(shell  docker info info 2>/dev/null |grep Username |cut -d':' -f2)

IMG_NAME=$(shell basename `pwd`)
IMG_REPO=${OWNER}/${IMG_NAME}
IMG_TAG:=${IMG_REPO}:$(shell date +'%Y%m%d%H%M')
IMG_BASE?=kathara/quagga

IMG_TARGETS=quagga-isep host-isep dhcp-isep

.PHONY:$(IMG_TARGETS)

default: help
	
.PHONY: help
help:
	@echo "Available targets:"
	@LC_ALL=C $(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/(^|\n)# Files(\n|$$)/,/(^|\n)# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | grep -E -v -e '^[^[:alnum:]]' -e '^$@$$'


# Push to GitHub
push:
	@echo "Pushing to GitHub"
	git add .
	git commit -m "update"
	git push

# Build all target images
all: $(IMG_TARGETS)

$(IMG_TARGETS):
	make -C $@ 

show_login:
	@echo $(OWNER)

login:
	docker login

# Deprecated targets
build-multi-host-isep: build-multi-quagga-isep
	$(BUILDX) -t ${IMG_HOST-ISEP}:latest --push --build-arg BASE=${IMG_QUAGGA-ISEP} host-isep 

build-multi-dhcp-isep: build-multi-quagga-isep
	$(BUILDX) -t ${IMG_DHCP-ISEP}:latest --push --build-arg BASE=${IMG_QUAGGA-ISEP} dhcp-isep 

build-multi-quagga-isep:
	$(BUILDX) -t ${IMG_QUAGGA-ISEP}:latest --push quagga-isep

.PHONY: build
build: Dockerfile
	@echo "Multiplatform building ${IMG}"
	@echo ${IMG} >init.version
	$(BUILDX) -t ${IMG_REPO}:latest --push --build-arg BASE=${IMG_BASE} .
	@echo "Done."

.PHONY: builderx
builderx:
	docker buildx create --name builderx --bootstrap --use

.PHONY: delete-builderx
delete-builderx:
	docker buildx rm builderx		


# Pull image from docker hub to local repo
.PHONY: pull
pull: Dockerfile
	docker pull $(IMG_REPO)

