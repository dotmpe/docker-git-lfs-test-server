.PHONY: default build

default: build

build:
	docker build -t dotmpe/docker-lfs-test:latest .

HOSTNAME ?= $(shell hostname -s)
PORT ?= 8016

run:
	test -n "$$DCKR_VOL"
	docker run --name $(HOSTNAME)-lfs-server -d \
    --env 'LFS_HOST=$(HOSTNAME):$(PORT)' \
    --publish $(PORT):8080 \
    --env 'LFS_ADMINUSER=admin' \
		--env 'LFS_ADMINPASS=admin' \
    --volume $$DCKR_VOL/$(HOSTNAME)-lfs-server/data:/data \
		dotmpe/docker-lfs-test:latest

destroy:
	docker rm -f $(HOSTNAME)-lfs-server

