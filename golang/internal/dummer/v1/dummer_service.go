package v1

import (
	"context"
	"fmt"

	"github.com/veganafro/mono/golang/internal/logwrapper"
	pb "github.com/veganafro/mono/golang/pkg/dummer/v1"
	dummy "github.com/veganafro/mono/golang/pkg/dummy/v1"

	"google.golang.org/grpc"
	"google.golang.org/protobuf/types/known/emptypb"
)

const (
	dummySvc    = "dummy"
	dummyPort   = "8000"
	host        = "0.0.0.0"
	serviceName = "dummer"
)

var (
	standardLogger = logwrapper.NewLogger()
)

type DummerServer struct {
	pb.UnimplementedDummerServiceServer
}

func (server *DummerServer) GetWorld(ctx context.Context, request *dummy.GetHelloRequest) (*dummy.GetHelloResponse, error) {
	conn, err := grpc.DialContext(
		context.Background(), fmt.Sprintf("%s:%s", host, dummyPort), grpc.WithInsecure())
	if err != nil {
		standardLogger.GrpcDialFailed(serviceName, dummySvc, err.Error())
		return nil, err
	}
	defer conn.Close()

	client := dummy.NewDummyServiceClient(conn)
	response, err := client.GetHello(context.Background(), &emptypb.Empty{})
	if err != nil {
		standardLogger.GrpcRequestFailed(serviceName, dummySvc, "GetHello", err.Error())
		return nil, err
	}

	return response, nil
}
