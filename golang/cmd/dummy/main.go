package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"strings"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	pb "github.com/veganafro/mono/golang/pkg/dummy/v1"
	"google.golang.org/protobuf/types/known/emptypb"

	"google.golang.org/grpc"

	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

const (
	host = "localhost"
)

type dummyServer struct {
	pb.UnimplementedDummyServiceServer
}

func (server *dummyServer) GetHello(ctx context.Context, request *emptypb.Empty) (*pb.GetHelloResponse, error) {
	return &pb.GetHelloResponse{Rsp: "Hello world"}, nil
}

func main() {
	var port string
	if port = os.Getenv("PORT"); port == "" {
		log.Fatal("Failed to get port from environment")
	}

	log.Println("Starting up dummy service")

	grpcServer := grpc.NewServer()
	pb.RegisterDummyServiceServer(grpcServer, &dummyServer{})

	dialOpts := []grpc.DialOption{grpc.WithInsecure()}

	ctx := context.Background()
	gatewayMux := runtime.NewServeMux()
	error := pb.RegisterDummyServiceHandlerFromEndpoint(ctx, gatewayMux, fmt.Sprintf("%s:%s", host, port), dialOpts)
	if error != nil {
		log.Fatal("Failed to register service handler from endpoint | ", error)
	}

	httpMux := http.NewServeMux()
	httpMux.Handle("/hello", gatewayMux)

	httpHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.ProtoMajor == 2 && strings.Contains(r.Header.Get("Content-Type"), "application/grpc") {
			grpcServer.ServeHTTP(w, r)
		} else {
			httpMux.ServeHTTP(w, r)
		}
	})

	http2Server := &http2.Server{}
	http1Server := &http.Server{
		Addr:    fmt.Sprintf("%s:%s", host, port),
		Handler: h2c.NewHandler(httpHandler, http2Server),
	}

	conn, error := net.Listen("tcp", fmt.Sprintf("%s:%s", host, port))
	if error != nil {
		log.Fatal("Failed to start tcp connection | ", error)
	}

	error = http1Server.Serve(conn)
	if error != nil {
		log.Fatal("Failed to start http server | ", error)
	}
}
