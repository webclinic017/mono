package main

import (
	"context"
	empty "github.com/golang/protobuf/ptypes/empty"
	"google.golang.org/grpc"
	"log"
	"net"
	pb "github.com/veganafro/mono/pkg/dummy_gen"
)

type dummyServer struct {
	pb.UnimplementedDummyServiceServer
}

func (server *dummyServer) GetEmpty(ctx context.Context, request *empty.Empty) (*pb.DummyResponse, error){
	return &pb.DummyResponse{ Rsp: "Hello world" }, nil
}

func main() {
	conn, error := net.Listen("tcp", "localhost:3001")
	if error != nil {
		log.Fatal("Failed to start http server", error)
	}

	var opts []grpc.ServerOption
	grpcServer := grpc.NewServer(opts...)
	pb.RegisterDummyServiceServer(grpcServer, &dummyServer{})

	_ = grpcServer.Serve(conn)
}

