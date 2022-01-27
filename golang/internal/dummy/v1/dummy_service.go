package v1

import (
	"context"

	pb "github.com/veganafro/mono/golang/pkg/dummy/v1"

	"google.golang.org/protobuf/types/known/emptypb"
)

type DummyServer struct {
	pb.UnimplementedDummyServiceServer
}

func (server *DummyServer) GetHello(ctx context.Context, request *emptypb.Empty) (*pb.GetHelloResponse, error) {
	return &pb.GetHelloResponse{Rsp: "Hello world"}, nil
}
