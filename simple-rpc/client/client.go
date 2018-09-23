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

type CalculatorFunc func(ctx context.Context, in *pb.Operands, opts ...grpc.CallOption) (*pb.OperationResult, error)

type CalculatorOperation struct {
	Description string
	Callback    CalculatorFunc
}

func main() {
	// Set up a connection to the server.
	conn, err := grpc.Dial(address, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()
	c := pb.NewOperationsClient(conn)

	operations := []*CalculatorOperation{
		&CalculatorOperation{"Sum", c.Sum},
		&CalculatorOperation{"Diff", c.Diff},
		&CalculatorOperation{"Mult", c.Mult},
		&CalculatorOperation{"Div", c.Div},
	}

	for _, operation := range operations {
		ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()

		log.Printf("Executing operation %s", operation.Description)
		result, err := operation.Callback(ctx, &pb.Operands{Param1: 2, Param2: 3})

		log.Printf("Operation result: %v", result)
		if err != nil {
			log.Fatalf("could not execute operation %v: %v", operation.Description, err)
		}
		time.Sleep(1 * time.Second)
	}

}
