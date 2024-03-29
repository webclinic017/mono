# Summary

Resources related to backend services that support the `mono` iOS and Android clients can be found here.

## Structure

```
golang
├── cmd
│   └── dummy
│       ├── BUILD.bazel
│       └── main.go
├── internal
│   └── dummy
│       └── v1
│           ├── BUILD.bazel
│           ├── dummy_service_test.go
│           └── dummy_service.go
├── pkg
│   └── dummy
│       └── v1
│           ├── BUILD.bazel
│           └── dummy.go
├── BUILD
├── repositories.bzl
├── go.mod
└── go.sum
```

`cmd` contains service entry points/listeners in the `main.go`. Each directory in `cmd` maps to a similarly named
service.

`internal` contains service implementations and other internal modules like loggers. Service implementations should also
come with tests.

`pkg` contains shared and public code. Typically these are generated Protocol Buffer and gRPC stubs. 

In general, bias towards following Golang structure best practices as elaborated on [here](https://github.com/golang-standards/project-layout).

## Getting started

### Running existing services

An existing service can be brought up individually with:

```bash
$ bazel run //golang/cmd/[SERVICE]:[SERVICE]
```

Most services will require a `PORT` environment variable to start.

### Creating new services

Every `golang` service corresponds with a gPRC service defined in the `proto` module.

Start by creating a versioned service definition in the [`proto`](../proto) module.

Once that's done, create a similarly versioned Go implementation of the service under [`pkg`](./pkg) (i.e. `pkg/[SERVICE]/[VERSION]`).
This new module should contain a `BUILD.bazel` file and a Goloang file named after the service whose package is eponymous
to the service.

The `BUILD.bazel` file for the `dummer` service is a good example of a service with both external and local proto
dependencies. The `dummy` service contains an example for a service with no local and some external proto dependencies.

Finally, create a new service entrypoint (`main.go`) and `BUILD.bazel` file in a package named after the service under
`cmd` (i.e. `cmd/[SERVICE]/main.go`). Once service endpoints are implemented, use

```
$ bazel run //golang/cmd/[SERVICE]:[SERVICE]
```
to bring up the service locally. Also, be sure to containerize the service - check out the `dummy` or `dummer` service
entrypoints' `BUILD.bazel` files for examples.

### Automated testing

Coming soon...

### Locally test a single service in a container

```bash
$ bazel run //golang/cmd/{service}:{service}-go-image
$ docker run --rm -it -p{port number}:{port number} bazel/golang/cmd/{service}:{service}-go-image
```

## Dependencies

### Golang

| Name | Version | Notes |
|------|---------|-------|
| [grpc_gateway](https://github.com/grpc-ecosystem/grpc-gateway) | [2.10.3](https://github.com/grpc-ecosystem/grpc-gateway/releases/tag/v2.10.3) | N/A |
| [bazel_gazelle](https://github.com/bazelbuild/bazel-gazelle) | [0.26.0](https://github.com/bazelbuild/bazel-gazelle/releases/tag/v0.26.0) | N/A |
| [io_bazel_rules_go](https://github.com/bazelbuild/rules_go) | [0.35.0](https://github.com/bazelbuild/rules_go/releases/tag/v0.35.0) | N/A |
| [org_golang_google_grpc](https://google.golang.org/grpc) | [1.48.0](https://github.com/grpc/grpc-go/releases/tag/v1.48.0) | N/A |
| [org_golang_x_net](https://golang.org/x/net) | [v0.0.0-20220708220712-1185a9018129](https://pkg.go.dev/golang.org/x/net@vv0.0.0-20220708220712-1185a9018129) | N/A |
| [org_golang_google_protobuf](https://google.golang.org/protobuf) | [1.28.0](https://pkg.go.dev/google.golang.org/protobuf@v1.28.0) | N/A |
| [com_github_hashicorp_consul_api](https://github.com/hashicorp/consul/tree/main/api) | [1.13.1](https://pkg.go.dev/github.com/hashicorp/consul/api@v1.13.1) | Currently unused |

## Helpful notes

[Bazel gazelle docs](https://github.com/bazelbuild/bazel-gazelle/blob/master/repository.rst)

[Bazel go docs](https://github.com/bazelbuild/rules_go)

[Bazel go + protobuf docs](https://github.com/bazelbuild/rules_go/blob/master/proto/core.rst)

[gRPC gateway docs](https://github.com/grpc-ecosystem/grpc-gateway)
