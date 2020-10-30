FROM grpc-golang-base:0.0.2
ENV PATH "$PATH:/opt/protoc-3.13.0/bin"

# Copy the server code
COPY client /client
COPY calculator /client/calculator

# Code compilation
RUN protoc --proto_path=/client/calculator --go-grpc_out=/client/calculator --go_out=/client/calculator /client/calculator/calculator.proto
RUN cd /client && go build -o bin/client github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/client
CMD bin/client