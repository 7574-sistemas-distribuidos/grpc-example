FROM golang:1.15

ENV PATH "$PATH:/opt/protoc-3.13.0/bin"

# Install minimal dependencies
RUN echo "alias ll=\"ls -lF\"" >> ~/.bashrc && \
    apt-get update && apt-get install tar vim wget unzip git -y && \
    # Install Protobuf3
    wget --no-check-certificate https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protoc-3.13.0-linux-x86_64.zip && \
    unzip protoc-3.13.0-linux-x86_64.zip && \
    mkdir -p /opt/protoc-3.13.0 && \
    mv bin include /opt/protoc-3.13.0 && \
    rm -rf protoc-3.13.0-linux-x86_64.zip readme.txt && \
    # Install grpc plugins to generate Golang code from proto files
    export GO111MODULE=on && go get -u google.golang.org/protobuf/cmd/protoc-gen-go@v1.25.0 && \
    export GO111MODULE=on && go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.0.1