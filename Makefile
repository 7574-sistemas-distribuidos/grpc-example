SHELL := /bin/bash
PWD := $(shell pwd)

GIT_REMOTE = github.com/7574-sistemas-distribuidos/docker-compose-init

default: build

all:

deps:
	go mod tidy
	go mod vendor

build: deps
	GOOS=linux go build -o bin/client github.com/7574-sistemas-distribuidos/docker-compose-init/client
.PHONY: build

build-base-image:
	docker build -f base-images/golang-base.dockerfile -t grpc-golang-base:0.0.3 .
.PHONY: build

simple-rpc-docker-image:
	docker build -f simple-rpc/client.dockerfile -t "simple-rpc-client:latest" .
	docker build -f simple-rpc/client_python.dockerfile -t "simple-rpc-client-python:latest" .
	docker build -f simple-rpc/server.dockerfile -t "simple-rpc-server:latest" .
.PHONY: simple-rpc-docker-image

simple-rpc-docker-compose-up: simple-rpc-docker-image
	docker-compose -f simple-rpc/docker-compose-dev.yaml up -d --build
.PHONY: simple-rpm-docker-compose-up

simple-rpc-docker-compose-down:
	docker-compose -f simple-rpc/docker-compose-dev.yaml stop -t 1
	docker-compose -f simple-rpc/docker-compose-dev.yaml down
.PHONY: simple-rpm-docker-compose-down

simple-rpc-docker-compose-logs:
	docker-compose -f simple-rpc/docker-compose-dev.yaml logs -f
.PHONY: docker-compose-logs