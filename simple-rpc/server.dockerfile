FROM grpc-golang-base:0.0.1
ARG GOPATH="/root/go"

# Set the workir inside the Go code which must be on the gopath/src directory
WORKDIR $GOPATH/src/github.com/7574-sistemas-distribuidos/grpc-example/environment/

# Copy the server code
COPY calculator $GOPATH/src/github.com/7574-sistemas-distribuidos/grpc-example/environment/calculator
COPY server $GOPATH/src/github.com/7574-sistemas-distribuidos/grpc-example/environment/server

# Code compilation
RUN protoc -Icalculator --go_out=plugins=grpc:calculator calculator/calculator.proto && \
    go build $(go list ./...) && go install $(go list ./...)

CMD $GOPATH/bin/server
