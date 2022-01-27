package v1

import (
	"context"
	"log"
	"net"
	"testing"

	pb "github.com/veganafro/mono/golang/pkg/dummy/v1"

	"google.golang.org/grpc"
	"google.golang.org/grpc/test/bufconn"
	"google.golang.org/protobuf/types/known/emptypb"
)

const (
	bufSize = 1024 * 1024
)

var (
	listener *bufconn.Listener
)

func init() {
	listener = bufconn.Listen(bufSize)
	server := grpc.NewServer()
	pb.RegisterDummyServiceServer(server, &DummyServer{})
	go func() {
		if err := server.Serve(listener); err != nil {
			log.Fatalf("Server exited with with error: %v", err)
		}
	}()
}

func bufDialer(context.Context, string) (net.Conn, error) {
	return listener.Dial()
}

func TestGetHello(t *testing.T) {
	ctx := context.Background()
	conn, err := grpc.DialContext(ctx, "bufnet", grpc.WithContextDialer(bufDialer), grpc.WithInsecure())
	if err != nil {
		t.Fatalf("Failed to dial bufnet: %v", err)
	}
	defer conn.Close()

	client := pb.NewDummyServiceClient(conn)
	response, err := client.GetHello(ctx, &emptypb.Empty{})
	if err != nil {
		t.Fatalf("GetHello failed: %v", err)
	}
	log.Printf("GetHello response: %v", response)
}
