#
# Makefile for dhcp-isep docker image
#
# Miguel Leitao, 2022
#


IMG_BASE=miguelleitao/quagga-isep:latest
IMG_NEW=miguelleitao/dhcp-isep
IMG:=${IMG_NEW}:$(shell date +'%Y%m%d%H%M')
build:
	echo ${IMG} >init.version
	docker build -t ${IMG} .

push:	build
	docker tag ${IMG} ${IMG_NEW}:latest
	docker push ${IMG_NEW}:latest

login:
	docker login
