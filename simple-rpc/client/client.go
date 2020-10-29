//go:generate protoc -I ../helloworld --go_out=plugins=grpc:../helloworld ../helloworld/helloworld.proto

package main

import (
	"log"
	"time"

	pb "github.com/7574-sistemas-distribuidos/grpc-example/environment/calculator"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
)

const (
	address = "server:50051"
)

func main() {
	// Set up a connection to the server.
	conn, err := grpc.Dial(address, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()
	c := pb.NewOperationsClient(conn)

	for _, operation := range operations {
		ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()

		operands := &pb.Operands{
			Param1: 2,
			Param2: 3,
		}

		// Sum
		log.Printf("Executing operation sum")
		sumResult, err := c.Sum(ctx, operands)
		log.Printf("Sum result: %v", result)
		if err != nil {
			log.Fatalf("could not execute operation sum: %v", err)
		}

		// Diff
		log.Printf("Executing operation diff")
		sumResult, err := c.Sum(ctx, operands)
		log.Printf("Diff result: %v", result)
		if err != nil {
			log.Fatalf("could not execute operation sum: %v", err)
		}

		// Mult
		log.Printf("Executing operation mult")
		sumResult, err := c.Sum(ctx, operands)
		log.Printf("Mult result: %v", result)
		if err != nil {
			log.Fatalf("could not execute operation mult: %v", err)
		}

		// Div
		log.Printf("Executing operation div")
		sumResult, err := c.Sum(ctx, operands)
		log.Printf("Div result: %v", result)
		if err != nil {
			log.Fatalf("could not execute operation div: %v", err)
		}

		time.Sleep(5 * time.Second)
	}

}
