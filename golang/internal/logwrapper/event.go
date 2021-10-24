package logwrapper

import "log"

type Event struct {
	id      int
	message string
}

var (
	portMissing                  = Event{1, "PORT missing for service: %s"}
	serviceStarting              = Event{2, "Starting service: %s"}
	serviceHandlerRegisterFailed = Event{3, "Failed to register %s service handler with error: %s"}
	tcpConnectionStartFailed     = Event{4, "Failed to start %s service tcp connection with error: %s"}
	httpOneStartFailed           = Event{5, "Failed to start %s service http1 server with error: %s"}
	grpcDialFailed               = Event{6, "Failed to dial %s service from %s service with error: %s"}
	grpcRequestFailed            = Event{7, "Failed to request %s service %s RPC from %s service with error: %s"}
)

func (logger *StandardLogger) PortMissing(serviceName string) {
	logger.Fatalf(portMissing.message, serviceName)
}

func (logger *StandardLogger) ServiceStarting(serviceName string) {
	logger.Printf(serviceStarting.message, serviceName)
}

func (logger *StandardLogger) ServiceHandlerRegisterFailed(serviceName string, err string) {
	logger.Fatalf(serviceHandlerRegisterFailed.message, serviceName, err)
}

func (logger *StandardLogger) TcpConnectionStartFailed(serviceName string, err string) {
	logger.Fatalf(tcpConnectionStartFailed.message, serviceName, err)
}

func (logger *StandardLogger) HttpOneStartFailed(serviceName string, err string) {
	logger.Fatalf(httpOneStartFailed.message, serviceName, err)
}

func (logger *StandardLogger) GrpcDialFailed(originName string, destinationName string, err string) {
	log.Printf(grpcDialFailed.message, destinationName, originName, err)
}

func (logger *StandardLogger) GrpcRequestFailed(originName string, destinationName string, rpcName string, err string) {
	log.Printf(grpcDialFailed.message, destinationName, rpcName, originName, err)
}
