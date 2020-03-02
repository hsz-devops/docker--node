
.PHONY: all
all: build

.PHONY: pull
pull:
	docker-compose pull --parallel

# push disabled as this is supposed to be build on docker hub
# .PHONY: push
# push:
# 	docker-compose push

.PHONY: build-alpine
build-alpine:
	docker-compose build --force-rm --pull node-12-alpine-nop
	docker-compose build --force-rm --pull node-12-alpine-pmx
	docker-compose build --force-rm --pull node-8-alpine-nop
	docker-compose build --force-rm --pull node-8-alpine-pmx

.PHONY: build-deb
build-deb:
	docker-compose build --force-rm --pull node-12-buster-nop

.PHONY: build
build:
	docker-compose build --force-rm --pull

.PHONY: rebuild
rebuild:
	docker-compose build --force-rm --pull --no-cache

.PHONY: purge
purge:
	docker rm  $$(docker ps -a -q)                      || true
	docker rmi $$(docker images -q -f dangling=true)    || true

test_az_pmx:
	docker run --rm -it ez123/node:12-alpine-pmx bash -c "AZ__OPENSSH_SERVER__ENABLE=1 /docker-entrypoint.sh sleep 10"

test_az_nop:
	docker run --rm -it ez123/node:12-alpine-nop bash -c "AZ__OPENSSH_SERVER__ENABLE=1 /docker-entrypoint.sh sleep 10"