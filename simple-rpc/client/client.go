package main

import (
	"log"
	"time"

	pb "github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/client/calculator"

	"golang.org/x/net/context"
	"google.golang.org/grpc"
)

const (
	address = "server:50051"
)

func main() {
	// Set up a connection to the gRPC server
	conn, err := grpc.Dial(address, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()

	// Create gRPC stub
	c := pb.NewOperationsClient(conn)

	// Golang context pattern used to handle timeouts against the server.
	// Defined with a 5 seconds timeout but not used in the example
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	// Define the operands that are going to be used to do the basic calculator
	// operations. Move them to config parameters to let the user test different
	// parameters combinations (e.g division by zero)
	operands := &pb.Operands{
		Param1: 2,
		Param2: 3,
	}

	// Execute operations available one by one to show how to interact
	// with server via the stub

	// Sum
	log.Printf("Executing operation sum")
	result, err := c.Sum(ctx, operands)
	log.Printf("Sum result: %v", result)
	if err != nil {
		log.Fatalf("could not execute operation sum: %v", err)
	}
	time.Sleep(1 * time.Second)

	// Diff
	log.Printf("Executing operation diff")
	result, err = c.Sum(ctx, operands)
	log.Printf("Diff result: %v", result)
	if err != nil {
		log.Fatalf("could not execute operation sum: %v", err)
	}
	time.Sleep(1 * time.Second)

	// Mult
	log.Printf("Executing operation mult")
	result, err = c.Sum(ctx, operands)
	log.Printf("Mult result: %v", result)
	if err != nil {
		log.Fatalf("could not execute operation mult: %v", err)
	}
	time.Sleep(1 * time.Second)

	// Div
	log.Printf("Executing operation div")
	result, err = c.Sum(ctx, operands)
	log.Printf("Div result: %v", result)
	if err != nil {
		log.Fatalf("could not execute operation div: %v", err)
	}
}
