
.PHONY: all
all: build

.PHONY: pull
pull:
	docker-compose pull --parallel

.PHONY: build-alpine
build-alpine:
	docker-compose build --force-rm --pull node-8-alpine
	docker-compose build --force-rm --pull node-8-alpine-pmx

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

test_az:
	docker run --rm -it ez123/node:8-alpine-pmx bash -c "AZ__OPENSSH_SERVER__ENABLE=1 /docker-entrypoint.sh sleep 10"