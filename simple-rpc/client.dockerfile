FROM grpc-golang-base:0.0.2
ENV PATH "$PATH:/opt/protoc-3.13.0/bin"

# Copy the server code
COPY client /go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/client
COPY calculator /go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/client/calculator

# Code compilation
RUN protoc --proto_path=/go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/client/calculator --go_out=. /go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/client/calculator/calculator.proto
RUN cd /go/src/github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/ && go build -o bin/client github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/client
CMD bin/client