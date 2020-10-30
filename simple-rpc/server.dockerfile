FROM grpc-golang-base:0.0.2
ENV PATH "$PATH:/opt/protoc-3.13.0/bin"

# Copy the server code
COPY server /go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/server
COPY calculator /go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/server/calculator

# Code compilation
RUN protoc --proto_path=/go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/server/calculator --go-grpc_out=/go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/server/calculator --go_out=/go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/server/calculator /go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/server/calculator/calculator.proto
RUN cd /go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/server && go build github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/server
CMD bin/server