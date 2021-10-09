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
| [dataform](https://github.com/dataform-co/dataform) | [42bedcba494c8d46b9fbc6aaf40c0202d217f29e](https://github.com/dataform-co/dataform/tree/42bedcba494c8d46b9fbc6aaf40c0202d217f29e) | Required to enable helm installs via `bazel` <br/> Upgrade to v1.18.0 |
| [rules_python](https://github.com/bazelbuild/rules_python) | [0.3.0](https://github.com/bazelbuild/rules_python/releases/tag/0.3.0) | N/A |
| [com_google_protobuf](https://github.com/protocolbuffers/protobuf) | [3.18.0](https://github.com/protocolbuffers/protobuf/releases/tag/v3.18.0) | N/A |
| [rules_proto](https://github.com/bazelbuild/rules_proto) | [f7a30f6f80006b591fa7c437fe5a951eb10bcbcf](https://github.com/bazelbuild/rules_proto/tree/f7a30f6f80006b591fa7c437fe5a951eb10bcbcf) | Upgrade to v4.0.0 |
| [io_bazel_rules_go](https://github.com/bazelbuild/rules_go) | [0.28.0](https://github.com/bazelbuild/rules_go/releases/tag/v0.28.0) | N/A |
| [bazel_gazelle](https://github.com/bazelbuild/bazel-gazelle) | [0.22.3](https://github.com/bazelbuild/bazel-gazelle/releases/tag/v0.22.3) | N/A |
| [io_bazel_rules_docker](https://github.com/bazelbuild/rules_docker) | [0.17.0](https://github.com/bazelbuild/rules_docker/releases/tag/v0.17.0)  | N/A |
| [io_bazel_rules_k8s](https://github.com/bazelbuild/rules_k8s) | [0.5](https://github.com/bazelbuild/rules_k8s/releases/tag/v0.5) | N/A |

### Golang

| Name | Version | Notes |
|------|---------|-------|
| [grpc_gateway](https://github.com/grpc-ecosystem/grpc-gateway) | [2.4.0](https://github.com/grpc-ecosystem/grpc-gateway/releases/tag/v2.4.0) | Migrate from pinned commit <br/> Upgrade to v2.6.0 |
| [org_golang_google_grpc](google.golang.org/grpc) | [1.36.0](https://github.com/grpc/grpc-go/releases/tag/v1.41.0) | N/A |
| [org_golang_x_net](golang.org/x/net) | [0.0.0-20211008194852-3b03d305991f](https://pkg.go.dev/golang.org/x/net@v0.0.0-20211008194852-3b03d305991f) | N/A |
| [org_golang_google_protobuf](google.golang.org/protobuf) | [1.27.1](https://pkg.go.dev/google.golang.org/protobuf@v1.27.1) | N/A |

### Helm

| Name | Version | Notes |
|------|---------|-------|
| [consul](https://github.com/hashicorp/consul-k8s) | [0.33.0](https://github.com/hashicorp/consul-k8s/releases/tag/v0.33.0) | N/A |

### Python (pip)

| Name | Version | Notes |
|------|---------|-------|
| [jupyter_http_over_ws](https://github.com/googlecolab/jupyter_http_over_ws) | [0.0.8](https://github.com/googlecolab/jupyter_http_over_ws/releases/tag/v0.0.8) | N/A |

## License

Mono is available under the MIT license. See the `LICENSE` file for details.

