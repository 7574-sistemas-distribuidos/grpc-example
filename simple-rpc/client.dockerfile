FROM grpc-golang-base:0.0.1
ARG GOPATH="/root/go"

# Set the workir inside the Go code which must be on the gopath/src directory
WORKDIR $GOPATH/src/github.com/7574-sistemas-distribuidos/grpc-example/environment

# Copy the server code
COPY calculator $GOPATH/src/github.com/7574-sistemas-distribuidos/grpc-example/environment/calculator
COPY client $GOPATH/src/github.com/7574-sistemas-distribuidos/grpc-example/environment/client

# Code compilation
RUN protoc -Icalculator --go_out=plugins=grpc:calculator calculator/calculator.proto
RUN cd $GOPATH/src/github.com/7574-sistemas-distribuidos/grpc-example/environment/client && GO111MODULE=on go build client.go

CMD $GOPATH/bin/client
