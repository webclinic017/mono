package resolvinator

import (
	"time"

	"github.com/hashicorp/consul/api"
	"google.golang.org/grpc/resolver"
)

type ConsulResolverBuilder struct {
	WatchInterval      time.Duration
	ConsulClientConfig *api.Config
}

func (builder *ConsulResolverBuilder) Build(
	target resolver.Target, clientConn resolver.ClientConn, opts resolver.BuildOptions) (resolver.Resolver, error) {
	consul, err := api.NewClient(builder.ConsulClientConfig)
	if err != nil {
		return nil, err
	}

	consulResolver := ConsulResolver{
		target:        target,
		clientConn:    clientConn,
		consul:        consul,
		state:         make(chan resolver.State, 1),
		done:          make(chan struct{}, 1),
		watchInterval: builder.WatchInterval,
	}

	go consulResolver.updater()
	go consulResolver.watcher()
	consulResolver.resolve()

	return &consulResolver, nil
}

func (builder *ConsulResolverBuilder) Scheme() string {
	return Scheme
}
