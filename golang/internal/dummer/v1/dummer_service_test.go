package v1

import (
	"context"
	"log"
	"net"
	"testing"

	pb "github.com/veganafro/mono/golang/pkg/dummer/v1"
	dummy "github.com/veganafro/mono/golang/pkg/dummy/v1"

	"google.golang.org/grpc"
	"google.golang.org/grpc/test/bufconn"
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
	pb.RegisterDummerServiceServer(server, &DummerServer{})
	go func() {
		if err := server.Serve(listener); err != nil {
			log.Fatalf("Server exited with with error: %v", err)
		}
	}()
}

func bufDialer(context.Context, string) (net.Conn, error) {
	return listener.Dial()
}

func TestGetWorld(t *testing.T) {
	ctx := context.Background()
	conn, err := grpc.DialContext(ctx, "bufnet", grpc.WithContextDialer(bufDialer), grpc.WithInsecure())
	if err != nil {
		t.Fatalf("Failed to dial bufnet: %v", err)
	}
	defer conn.Close()

	client := pb.NewDummerServiceClient(conn)
	response, err := client.GetWorld(ctx, &dummy.GetHelloRequest{})
	if err != nil {
		t.Fatalf("GetWorld failed: %v", err)
	}
	log.Printf("GetWorld response: %v", response)
}
