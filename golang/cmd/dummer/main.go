package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"github.com/veganafro/mono/golang/internal/resolvinator"
	pb "github.com/veganafro/mono/golang/pkg/dummer/v1"
	dummy "github.com/veganafro/mono/golang/pkg/dummy/v1"
	"google.golang.org/protobuf/types/known/emptypb"

	"google.golang.org/grpc"

	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

const (
	dummySvc = "dummy"
	host     = "localhost"
)

type dummerServer struct {
	pb.UnimplementedDummerServiceServer
}

func (server *dummerServer) GetWorld(ctx context.Context, request *dummy.GetHelloRequest) (*dummy.GetHelloResponse, error) {
	conn, error := grpc.DialContext(
		context.Background(), fmt.Sprintf("consul://service/%s", dummySvc), grpc.WithInsecure())
	if error != nil {
		log.Println("Failed to dial dummy service | ", error)
		return nil, error
	}
	defer conn.Close()

	client := dummy.NewDummyServiceClient(conn)
	response, error := client.GetHello(context.Background(), &emptypb.Empty{})
	if error != nil {
		log.Println("Failed to request dummy.GetHello | ", error)
		return nil, error
	}

	return response, nil
}

func main() {
	var port string
	if port = os.Getenv("PORT"); port == "" {
		log.Fatal("Failed to get port from environment")
	}

	log.Println("Starting up dummer service")

	grpcServer := grpc.NewServer()
	pb.RegisterDummerServiceServer(grpcServer, &dummerServer{})

	dialOpts := []grpc.DialOption{grpc.WithInsecure()}

	ctx := context.Background()
	gatewayMux := runtime.NewServeMux()
	error := pb.RegisterDummerServiceHandlerFromEndpoint(ctx, gatewayMux, fmt.Sprintf("%s:%s", host, port), dialOpts)
	if error != nil {
		log.Fatal("Failed to register service handler from endpoint | ", error)
	}

	resolvinator.RegisterDefault(time.Second * 5)

	httpMux := http.NewServeMux()
	httpMux.Handle("/world", gatewayMux)

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
		log.Fatal("Failed to start http1 server | ", error)
	}
}
