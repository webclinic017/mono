package resolvinator

import (
	"fmt"
	"strconv"
	"strings"
	"sync"
	"time"

	"github.com/hashicorp/consul/api"
	"google.golang.org/grpc/resolver"
)

const (
	Scheme = "consul"

	svc = "service"
	qry = "query"
)

type ConsulResolver struct {
	lock          sync.RWMutex
	target        resolver.Target
	clientConn    resolver.ClientConn
	consul        *api.Client
	state         chan resolver.State
	done          chan struct{}
	watchInterval time.Duration
}

func (consulResolver *ConsulResolver) Close() {
	close(consulResolver.done)
}

func (consulResolver *ConsulResolver) ResolveNow(resolver.ResolveNowOptions) {
	consulResolver.resolve()
}

func (consulResolver *ConsulResolver) resolve() {
	consulResolver.lock.Lock()
	defer consulResolver.lock.Unlock()

	state := resolver.State{}

	switch consulResolver.target.Authority {
	case svc:
		parts := strings.SplitN(consulResolver.target.Endpoint, "/", 2)

		var tag string
		if len(parts) == 2 {
			tag = parts[1]
		}

		services, _, err := consulResolver.consul.Catalog().Service(parts[0], tag, nil)
		if err != nil {
			return
		}

		addresses := make([]resolver.Address, 0, len(services))

		for _, s := range services {
			address := s.ServiceAddress
			port := s.ServicePort

			if address == "" {
				address = s.Address
			}

			addresses = append(addresses, resolver.Address{
				Addr:       fmt.Sprintf("%s:%s", address, strconv.Itoa(port)),
				ServerName: consulResolver.target.Endpoint,
			})
		}

		state.Addresses = addresses
	default:
		return
	}

	consulResolver.state <- state
}

func (consulResolver *ConsulResolver) updater() {
	for {
		select {
		case state := <-consulResolver.state:
			consulResolver.clientConn.UpdateState(state)
		case <-consulResolver.done:
			return
		}
	}
}

func (consulResolver *ConsulResolver) watcher() {
	ticker := time.NewTicker(consulResolver.watchInterval)
	defer ticker.Stop()

	for {
		select {
		case <-ticker.C:
			consulResolver.resolve()
		case <-consulResolver.done:
			return
		}
	}
}
