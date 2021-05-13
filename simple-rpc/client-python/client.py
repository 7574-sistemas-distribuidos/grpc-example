import logging
import time

import grpc

import calculator_pb2
import calculator_pb2_grpc

ADDRESS='server:50051'

def main():
	logging.basicConfig(
		format='%(asctime)s %(message)s',
		level=logging.INFO,
		datefmt='%Y-%m-%d %H:%M:%S',
	)

	# Connect to the gRPC server
	channel = grpc.insecure_channel(ADDRESS)

	# Create a gRPC stub
	stub = calculator_pb2_grpc.OperationsStub(channel)

	# Define the operands that are going to be used to do the basic calculator
	# operations. Move them to config parameters to let the user test different
	# parameters combinations (e.g division by zero)
	operands = calculator_pb2.Operands(param1=5,param2=1)

	# Sum
	logging.info("Executing operation sum")
	response = stub.Sum(operands)
	logging.info("Sum result: {}".format(response.result))
	time.sleep(1)

	# Diff
	logging.info("Executing operation diff")
	response = stub.Diff(operands)
	logging.info("Diff result: {}".format(response.result))
	time.sleep(1)

	# Mult
	logging.info("Executing operation mult")
	response = stub.Mult(operands)
	logging.info("Mult result: {}".format(response.result))
	time.sleep(1)

	# Div
	logging.info("Executing operation div")
	response = stub.Div(operands)
	logging.info("Div result: {}".format(response.result))
	time.sleep(1)

if __name__ == '__main__':
	main()
