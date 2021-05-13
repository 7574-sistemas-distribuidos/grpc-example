FROM python:3.9
ENV PATH "$PATH:/opt/protoc-3.16.0/bin"

# Copy the client python code
COPY simple-rpc/client-python /client
COPY simple-rpc/calculator /client/calculator

RUN pip3 install grpcio-tools && \
	python3 -m grpc_tools.protoc --proto_path=/client/calculator --python_out=/client --grpc_python_out=/client /client/calculator/calculator.proto

CMD python3 -u /client/client.py