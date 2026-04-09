#!/usr/bin/env bash
set -euo pipefail

GOBIN_DIR="$(go env GOPATH)/bin"
PATH="$GOBIN_DIR:$PATH"

if ! command -v protoc-gen-go >/dev/null 2>&1; then
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
fi

if ! command -v protoc-gen-go-grpc >/dev/null 2>&1; then
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
fi

protoc \
	--proto_path=./calculator \
	--go_opt=paths=source_relative \
	--go-grpc_opt=paths=source_relative \
	--go-grpc_out=./calculator \
	--go_out=./calculator \
	./calculator/calculator.proto