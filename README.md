# Summary

Mono is meant to be a monorepo containing all the relevant information and source files needed to build learning
oriented Android and iOS apps. These clients are supported Golang servers that expose HTTP and gRPC endpoints. In both
instances, the client and backend communicate using Protocol Buffers. Dive into each subdirectory to learn more.

## Getting started

### Setting up a dev environment

Start by installing [`brew`](https://brew.sh/) as shown in the linked instructions

With the introduction of the [Bazel](https://bazel.build/) system, getting up and running is fairly simple. The first
requirement is that [`bazelisk`](https://github.com/bazelbuild/bazelisk) be installed like so:

```
$ brew install bazelisk
```
Next, install [`docker`](https://docs.docker.com/docker-for-mac/install/) manually by following the linked steps.

From here, use the editors and IDEs you're most comfortable with to make changes.

## Dependencies

### Bazel

| Name | Version | Notes |
|------|---------|-------|
| [rules_python](https://github.com/bazelbuild/rules_python) | [0.8.1](https://github.com/bazelbuild/rules_python/releases/tag/0.8.1) | N/A |
| [com_google_protobuf](https://github.com/protocolbuffers/protobuf) | [3.19.4](https://github.com/protocolbuffers/protobuf/releases/tag/v3.19.4) | N/A |
| [rules_proto](https://github.com/bazelbuild/rules_proto) | [4.0.0-3.19.2-2](https://github.com/bazelbuild/rules_proto/releases/tag/4.0.0-3.19.2-2) | N/A |
| [io_bazel_rules_go](https://github.com/bazelbuild/rules_go) | [0.30.0](https://github.com/bazelbuild/rules_go/releases/tag/v0.30.0) | N/A |
| [bazel_gazelle](https://github.com/bazelbuild/bazel-gazelle) | [0.24.0](https://github.com/bazelbuild/bazel-gazelle/releases/tag/v0.22.3) | N/A |
| [io_bazel_rules_docker](https://github.com/bazelbuild/rules_docker) | [0.24.0](https://github.com/bazelbuild/rules_docker/releases/tag/v0.24.0)  | N/A |
| [io_bazel_rules_k8s](https://github.com/bazelbuild/rules_k8s) | [0.6](https://github.com/bazelbuild/rules_k8s/releases/tag/v0.6) | N/A |

### Golang

| Name | Version | Notes |
|------|---------|-------|
| [grpc_gateway](https://github.com/grpc-ecosystem/grpc-gateway) | [2.10.0](https://github.com/grpc-ecosystem/grpc-gateway/releases/tag/v2.10.0) | N/A |
| [org_golang_google_grpc](https://google.golang.org/grpc) | [1.44.0](https://github.com/grpc/grpc-go/releases/tag/v1.44.0) | N/A |
| [org_golang_x_net](https://golang.org/x/net) | [0.0.0-20211108170745-6635138e15ea](https://pkg.go.dev/golang.org/x/net@v0.0.0-20211108170745-6635138e15ea) | N/A |
| [org_golang_google_protobuf](https://google.golang.org/protobuf) | [1.27.1](https://pkg.go.dev/google.golang.org/protobuf@v1.27.1) | N/A |
| [com_github_hashicorp_consul_api](https://github.com/hashicorp/consul/tree/main/api) | [1.11.0](https://pkg.go.dev/github.com/hashicorp/consul/api@v1.11.0) | Currently unused |

### Helm

| Name | Version | Notes |
|------|---------|-------|
| [consul](https://github.com/hashicorp/consul-k8s) | [0.41.1](https://github.com/hashicorp/consul-k8s/releases/tag/v0.41.1) | N/A |
| [vault](https://github.com/hashicorp/vault-helm) | [0.19.0](https://github.com/hashicorp/vault-helm/releases/tag/v0.19.0) | N/A |
| [cert-manager](https://github.com/cert-manager/cert-manager) | [1.6.1](https://github.com/cert-manager/cert-manager/releases/tag/v1.6.1) | N/A |
| [ingress-nginx](https://github.com/kubernetes/ingress-nginx) | [4.0.19](https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx/4.0.19) | N/A |

### Python (pip)

| Name | Version | Notes |
|------|---------|-------|
| [vectorbt[full]](https://github.com/polakowo/vectorbt) | [0.22.0](https://pypi.org/project/vectorbt/0.22.0/) | N/A |
| [pillow](https://pypi.org/project/Pillow) | [9.0.1](https://pypi.org/project/Pillow/9.0.1/) | Manually fix a vulnerability for a `vectorbt` dependency |
| [numpy](https://pypi.org/project/numpy) | [1.25.5](https://pypi.org/project/numpy/1.21.5/) | N/A |

### Other

| Name | Version | Notes |
|------|---------|-------|
| [minikube](https://github.com/kubernetes/minikube) | [1.23.2](https://github.com/kubernetes/minikube/releases/tag/v1.23.2) | N/A |
| [kubectl](https://github.com/kubernetes/kubernetes) | [1.22.2](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.2) | N/A |
| [ta-lib](https://ta-lib.org/) | [0.4.0](#) | Required to use the epynomous python module |

## License

Mono is available under the MIT license. See the `LICENSE` file for details.
