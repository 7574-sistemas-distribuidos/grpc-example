package main

import (
	"fmt"
	"log"
	"net"
	"os"
	"os/signal"
	"syscall"

	pb "github.com/7574-sistemas-distribuidos/grpc-example/simple-rpc/server/calculator"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

const (
	port = ":50051"
)

// server is used to implement helloworld.GreeterServer.
type server struct {
	pb.UnimplementedOperationsServer
}

func (s *server) Sum(ctx context.Context, in *pb.Operands) (*pb.OperationResult, error) {
	log.Printf("[SERVER] Executing Sum Operation")
	return &pb.OperationResult{
		Result: in.Param1 + in.Param2,
	}, nil
}

func (s *server) Diff(ctx context.Context, in *pb.Operands) (*pb.OperationResult, error) {
	log.Printf("[SERVER] Executing Diff Operation")
	return &pb.OperationResult{
		Result: in.Param1 - in.Param2,
	}, nil
}

func (s *server) Mult(ctx context.Context, in *pb.Operands) (*pb.OperationResult, error) {
	log.Printf("[SERVER] Executing Mult Operation")
	return &pb.OperationResult{
		Result: in.Param1 * in.Param2,
	}, nil
}

func (s *server) Div(ctx context.Context, in *pb.Operands) (*pb.OperationResult, error) {
	log.Printf("[SERVER] Executing Div Operation")
	if in.Param2 == 0 {
		return nil, fmt.Errorf("Division by zero")
	}

	return &pb.OperationResult{
		Result: in.Param1 / in.Param2,
	}, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	s := grpc.NewServer()
	pb.RegisterOperationsServer(s, &server{})
	// Register reflection service on gRPC server.
	reflection.Register(s)

	// Stop the gRPC server when the SIGINT signal arrives
	handleSigintSignal(s)

	log.Printf("[SERVER] Starting gRPC Server")
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
	log.Printf("[SERVER] gRPC server has been stopped")
}

func handleSigintSignal(server *grpc.Server) {
	c := make(chan os.Signal, syscall.SIGINT)
	signal.Notify(c, os.Interrupt)
	go func() {
		// Block until we receive the SIGINT signal
		<-c
		log.Printf("[SERVER] SIGNIT arrived. Stopping gRPC Server")
		server.Stop()
	}()
}
