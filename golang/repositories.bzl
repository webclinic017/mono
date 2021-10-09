"""
`go_deps` loads all the relevant Go dependencies for gRPC and grpc-gateway
"""
load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_deps():
    """
    `go_deps` loads all the relevant Go dependencies for gRPC and grpc-gateway
    """
    ## Begin gRPC dependecies - 05/13 ##

    GRPC_SUM = "h1:f+PlOh7QV4iIJkPrx5NQ7qaNGFQ3OTse67yaDHfju4E="
    GRPC_VERSION = "v1.41.0"

    go_repository(
        name = "org_golang_google_grpc",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/grpc",
        sum = "%s" % GRPC_SUM,
        version = "%s" % GRPC_VERSION,
    )

    NET_SUM = "h1:1scJEYZBaF48BaG6tYbtxmLcXqwYGSfGcMoStTqkkIw="
    NET_VERSION = "v0.0.0-20211008194852-3b03d305991f"

    go_repository(
        name = "org_golang_x_net",
        importpath = "golang.org/x/net",
        sum = "%s" % NET_SUM,
        version = "%s" % NET_VERSION,
    )

    ## End gRPC dependencies ##

    ## Begin grpc-gateway dependencies - 05/13 ##

    ORG_PROTOBUF_SUM = "h1:9q0QmTI4eRPtz6boOQmLYwt+qCgq0jsYwAQnmE0givc="
    ORG_PROTOBUF_VERSION = "v1.27.1"

    go_repository(
        name = "org_golang_google_protobuf",
        importpath = "google.golang.org/protobuf",
        sum = "%s" % ORG_PROTOBUF_SUM,
        version = "%s" % ORG_PROTOBUF_VERSION,
    )

    ## End grpc-gateway dependencies ##
