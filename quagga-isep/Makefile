#
# Makefile for quagga-isep docker image
#
# Miguel Leitao, 2022
#

IMG_BASE=miguelleitao/quagga-isep
IMG:=${IMG_BASE}:$(shell date +'%Y%m%d%H%M')
build:
	echo ${IMG} >init.version
	docker build -t ${IMG} .

push:	build
	docker tag ${IMG} ${IMG_BASE}:latest
	docker push ${IMG_BASE}:latest

login:
	docker login
