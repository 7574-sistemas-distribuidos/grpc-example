FROM ubuntu:18.04
WORKDIR /tmp
ENV PATH "$PATH:/opt/protoc-3.11.4/bin"

# Install minimal dependencies
RUN echo "alias ll=\"ls -lF\"" >> ~/.bashrc && \
    apt-get update && apt-get install tar vim wget unzip git -y && \
# Install Protobuf3
    wget --no-check-certificate https://github.com/protocolbuffers/protobuf/releases/download/v3.11.4/protoc-3.11.4-linux-x86_64.zip && \
    unzip protoc-3.11.4-linux-x86_64.zip && \
    mkdir -p /opt/protoc-3.11.4 && \
    mv bin include /opt/protoc-3.11.4 && \
    rm -rf protoc-3.11.4-linux-x86_64.zip readme.txt
