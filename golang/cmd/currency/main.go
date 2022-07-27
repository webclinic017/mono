package main

import (
	"context"
	"fmt"
	"net"
	"net/http"
	"os"
	"strings"

	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"

	"google.golang.org/grpc"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"

	currencySvc "github.com/veganafro/mono/golang/internal/currency/v1"
	"github.com/veganafro/mono/golang/internal/logwrapper"
	pb "github.com/veganafro/mono/golang/pkg/currency/v1"
)

const (
	host = "0.0.0.0"
	serviceName = "currency"
)

var (
	standardLogger = logwrapper.NewLogger()
)

func main() {
	var port string
	if port = os.Getenv("PORT"); port == "" {
		standardLogger.PortMissing(serviceName)
	}

	standardLogger.ServiceStarting(serviceName)

	grpcServer := grpc.NewServer()
	pb.RegisterCurrencyServiceServer(grpcServer, &currencySvc.CurrencyService{})

	dialOpts := []grpc.DialOption{grpc.WithInsecure()}

	ctx := context.Background()
	gatewayMux := runtime.NewServeMux()
	err := pb.RegisterCurrencyServiceHandlerFromEndpoint(ctx, gatewayMux, fmt.Sprintf("%s:%s", host, port), dialOpts)
	if err != nil {
		standardLogger.ServiceHandlerRegisterFailed(serviceName, err.Error())
	}

	httpMux := http.NewServeMux()
	httpMux.Handle("/user_currencies", gatewayMux)
	httpMux.Handle("/buy", gatewayMux)

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

	conn, err := net.Listen("tcp", fmt.Sprintf("%s:%s", host, port))
	if err != nil {
		standardLogger.TcpConnectionStartFailed(serviceName, err.Error())
	}

	err = http1Server.Serve(conn)
	if err != nil {
		standardLogger.HttpOneStartFailed(serviceName, err.Error())
	}
}
