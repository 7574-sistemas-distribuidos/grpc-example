#!/usr/bin/env bash
python3 -m grpc_tools.protoc --proto_path=./calculator --python_out=./client --grpc_python_out=./client ./calculator/calculator.proto