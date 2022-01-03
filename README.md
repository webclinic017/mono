# Summary

Mono is meant to be a monorepo containing all the relevant information and source files needed to build a learning oriented Android and iOS app. These clients are
supported by a gRPC based Go server. The client and backend communicate using Protocol Buffers sent over HTTP. Dive into each subdirectory to learn more.

## Getting started

### Setting up a dev environment

Start by installing [`brew`](https://brew.sh/) as shown in the linked instructions

With the introduction of the [Bazel](https://bazel.build/) system, getting up and running is fairly simple. The first requirement
is that `bazel` be installed like so:

```
$ brew install bazel@4.2.0
```
Be sure to add the following line to `.bash_profile`:

```
source $(brew --prefix)/etc/bash_completion.d/bazel-complete.bash
```
Next, install [`docker`](https://docs.docker.com/docker-for-mac/install/) manually by following the linked steps.

The third step is to install [`pyenv`](https://github.com/pyenv/pyenv) so that we can install and manage `python` versions. This
is needed so that we can `pip install futures`, which is meant to fix [this](https://github.com/bazelbuild/bazel/issues/12741) error. 

```
$ brew install pyenv@1.2.21
```
Now add the following line to `.bash_profile`:

```
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
```
Finally, we can set the python versions and packages we want with

```
$ pyenv install 3.9.0
$ pyenv install 2.7.18
$ pyenv global 3.9.0 2.7.18
$ pip2 install futures
```
From here, use the editors and IDEs you're most comfortable with to make changes.

## Dependencies

### Bazel

| Name | Version | Notes |
|------|---------|-------|
| [rules_python](https://github.com/bazelbuild/rules_python) | [0.3.0](https://github.com/bazelbuild/rules_python/releases/tag/0.3.0) | N/A |
| [com_google_protobuf](https://github.com/protocolbuffers/protobuf) | [3.18.0](https://github.com/protocolbuffers/protobuf/releases/tag/v3.18.0) | N/A |
| [rules_proto](https://github.com/bazelbuild/rules_proto) | [4.0.0](https://github.com/bazelbuild/rules_proto/releases/tag/4.0.0) | N/A |
| [io_bazel_rules_go](https://github.com/bazelbuild/rules_go) | [0.29.0](https://github.com/bazelbuild/rules_go/releases/tag/v0.29.0) | N/A |
| [bazel_gazelle](https://github.com/bazelbuild/bazel-gazelle) | [0.24.0](https://github.com/bazelbuild/bazel-gazelle/releases/tag/v0.22.3) | N/A |
| [io_bazel_rules_docker](https://github.com/bazelbuild/rules_docker) | [0.17.0](https://github.com/bazelbuild/rules_docker/releases/tag/v0.17.0)  | N/A |
| [io_bazel_rules_k8s](https://github.com/bazelbuild/rules_k8s) | [0.5](https://github.com/bazelbuild/rules_k8s/releases/tag/v0.5) | N/A |

### Golang

| Name | Version | Notes |
|------|---------|-------|
| [grpc_gateway](https://github.com/grpc-ecosystem/grpc-gateway) | [2.6.0](https://github.com/grpc-ecosystem/grpc-gateway/releases/tag/v2.6.0) | N/A |
| [org_golang_google_grpc](https://google.golang.org/grpc) | [1.41.0](https://github.com/grpc/grpc-go/releases/tag/v1.41.0) | N/A |
| [org_golang_x_net](https://golang.org/x/net) | [0.0.0-20211108170745-6635138e15ea](https://pkg.go.dev/golang.org/x/net@v0.0.0-20211108170745-6635138e15ea) | N/A |
| [org_golang_google_protobuf](https://google.golang.org/protobuf) | [1.27.1](https://pkg.go.dev/google.golang.org/protobuf@v1.27.1) | N/A |
| [com_github_hashicorp_consul_api](https://github.com/hashicorp/consul/tree/main/api) | [1.11.0](https://pkg.go.dev/github.com/hashicorp/consul/api@v1.11.0) | N/A |

### Helm

| Name | Version | Notes |
|------|---------|-------|
| [consul](https://github.com/hashicorp/consul-k8s) | [0.34.1](https://github.com/hashicorp/consul-k8s/releases/tag/v0.34.1) | N/A |

### Python (pip)

| Name | Version | Notes |
|------|---------|-------|
| [jupyter_http_over_ws](https://github.com/googlecolab/jupyter_http_over_ws) | [0.0.8](https://github.com/googlecolab/jupyter_http_over_ws/releases/tag/v0.0.8) | N/A |

### Other

| Name | Version | Notes |
|------|---------|-------|
| [minikube](https://github.com/kubernetes/minikube) | [1.23.2](https://github.com/kubernetes/minikube/releases/tag/v1.23.2) | N/A |
| [kubectl](https://github.com/kubernetes/kubernetes) | [1.22.2](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.2) | N/A |

## License

Mono is available under the MIT license. See the `LICENSE` file for details.
