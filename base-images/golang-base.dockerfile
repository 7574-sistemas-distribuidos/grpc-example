FROM grpc-base:0.0.1
ENV GOPATH "/root/go"
ENV PATH "$PATH:/opt/go-1.13.3/bin:$GOPATH/bin"

# Install golang
RUN wget --no-check-certificate https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz && \
    tar xzvf go1.13.3.linux-amd64.tar.gz && \
    mv go /opt/go-1.13.3 && \
    rm -rf go1.13.3.linux-amd64.tar.gz && \
# Install grpc 
    go get -u google.golang.org/grpc && \
    go get -u github.com/golang/protobuf/protoc-gen-go

