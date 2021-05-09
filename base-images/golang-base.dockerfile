FROM golang:1.16

ENV PATH "$PATH:/opt/protoc-3.16.0/bin"

# Install minimal dependencies
RUN echo "alias ll=\"ls -lF\"" >> ~/.bashrc && \
    apt-get update && apt-get install tar vim wget unzip git -y && \
    # Install Protobuf3
    wget --no-check-certificate https://github.com/protocolbuffers/protobuf/releases/download/v3.16.0/protoc-3.16.0-linux-x86_64.zip && \
    unzip protoc-3.16.0-linux-x86_64.zip && \
    mkdir -p /opt/protoc-3.16.0 && \
    mv bin include /opt/protoc-3.16.0 && \
    rm -rf protoc-3.16.0-linux-x86_64.zip readme.txt && \
    # Install grpc plugins to generate Golang code from proto files
    go get -u google.golang.org/grpc@v1.37.0 && \
    go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1.0 && \
    go get -u google.golang.org/protobuf/cmd/protoc-gen-go@v1.26.0
