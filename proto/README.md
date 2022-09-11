# Summary

Resources related to gRPC service and protocol buffer message definitions used by Mono backends and clients.

## Structure

```
proto
├── dummy
│   └── v1
│       ├── BUILD.bazel
│       ├── dummy.proto
│       └── dummy_service.proto
├── BUILD
└── buf.yaml
```

## Getting started

### Creating and editing definitions

Each directory contains gRPC service and/or protobuf message definitions. In keeping with the [`buf`](https://buf.build/docs/style-guide/#files-and-packages) styleguide,
protobuf messages and services are in versioned packages.

All service and message definitions along with their filepaths should be named after the
service (i.e. `[SERVICE]/[VERSION]/[SERVICE].proto`).

### Testing

Coming soon...

## Dependencies

### Proto

| Name | Version | Notes |
|------|---------|-------|
| [com_google_protobuf](https://github.com/protocolbuffers/protobuf) | [3.21.5](https://github.com/protocolbuffers/protobuf/releases/tag/v3.21.5) | N/A |
| [rules_proto](https://github.com/bazelbuild/rules_proto) | [4.0.0-3.20.0](https://github.com/bazelbuild/rules_proto/releases/tag/4.0.0-3.20.0) | N/A |

## Helpful notes

[Bazel protobuf docs](https://github.com/bazelbuild/rules_proto)

[Buf docs](https://buf.build/docs/introduction)

[gRPC gateway docs](https://github.com/grpc-ecosystem/grpc-gateway)
