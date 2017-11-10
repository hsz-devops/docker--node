
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