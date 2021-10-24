package main

import (
	"context"
	"fmt"
	"net"
	"net/http"
	"os"
	"strings"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"github.com/veganafro/mono/golang/internal/logwrapper"
	pb "github.com/veganafro/mono/golang/pkg/dummy/v1"
	"google.golang.org/protobuf/types/known/emptypb"

	"google.golang.org/grpc"

	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

const (
	host        = "localhost"
	serviceName = "dummy"
)

var (
	standardLogger = logwrapper.NewLogger()
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
		standardLogger.PortMissing(serviceName)
	}

	standardLogger.ServiceStarting(serviceName)

	grpcServer := grpc.NewServer()
	pb.RegisterDummyServiceServer(grpcServer, &dummyServer{})

	dialOpts := []grpc.DialOption{grpc.WithInsecure()}

	ctx := context.Background()
	gatewayMux := runtime.NewServeMux()
	error := pb.RegisterDummyServiceHandlerFromEndpoint(ctx, gatewayMux, fmt.Sprintf("%s:%s", host, port), dialOpts)
	if error != nil {
		standardLogger.ServiceHandlerRegisterFailed(serviceName, error.Error())
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
		standardLogger.TcpConnectionStartFailed(serviceName, error.Error())
	}

	error = http1Server.Serve(conn)
	if error != nil {
		standardLogger.HttpOneStartFailed(serviceName, error.Error())
	}
}
