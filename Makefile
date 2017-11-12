
.PHONY: all
all: build

.PHONY: pull
pull:
	docker-compose pull --parallel

.PHONY: build-alpine
build-alpine:
	docker-compose build --force-rm --pull node-8
	docker-compose build --force-rm --pull node-8-pmx

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

