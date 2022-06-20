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

## Helpful notes

[Bazel gazelle docs](https://github.com/bazelbuild/bazel-gazelle/blob/master/repository.rst)

[Bazel go docs](https://github.com/bazelbuild/rules_go)

[Bazel go + protobuf docs](https://github.com/bazelbuild/rules_go/blob/master/proto/core.rst)

[gRPC gateway docs](https://github.com/grpc-ecosystem/grpc-gateway)
