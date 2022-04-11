# Summary

Consul is "is a distributed, highly available, and data center aware solution to connect and configure applications
across dynamic, distributed infrastructure."

Specifically, this repo takes advantage of a consul feature that allows us to run a service mesh in Kubernetes.
[Consul connect](https://www.consul.io/docs/k8s/connect) injects [Envoy](https://www.envoyproxy.io) sidecars into
Kubernetes pods and registers pods with consul, thus enabling service discovery as well as service-to-service
authorization and connection encryption.

## Helpful notes

[Consul k8s quickstart](https://learn.hashicorp.com/tutorials/consul/service-mesh-deploy)
[Consul API gateway](https://learn.hashicorp.com/tutorials/consul/kubernetes-api-gateway)
