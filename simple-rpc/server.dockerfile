FROM grpc-golang-base:0.0.2
ENV PATH "$PATH:/opt/protoc-3.13.0/bin"

# Copy the server code
COPY server /server
COPY calculator /server/calculator

# Code compilation
RUN protoc --proto_path=/server/calculator --go-grpc_out=/server/calculator --go_out=/server/calculator /server/calculator/calculator.proto
RUN cd /server && go build github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/server
CMD bin/server