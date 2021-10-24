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

    YAML_V2_SUM = "h1:clyUAQHOM3G0M3f5vQj7LuJrETvjVot3Z5el9nffUtU="
    YAML_V2_VERSION = "v2.3.0"

    go_repository(
        name = "in_gopkg_yaml_v2",
        importpath = "gopkg.in/yaml.v2",
        sum = "%s" % YAML_V2_SUM,
        version = "%s" % YAML_V2_VERSION,
    )

    PROTOBUF_SUM = "h1:9q0QmTI4eRPtz6boOQmLYwt+qCgq0jsYwAQnmE0givc="
    PROTOBUF_VERSION = "v1.27.1"

    go_repository(
        name = "org_golang_google_protobuf",
        importpath = "google.golang.org/protobuf",
        sum = "%s" % PROTOBUF_SUM,
        version = "%s" % PROTOBUF_VERSION,
    )

    ## End grpc-gateway dependencies ##

    ## Begin consul dependencies ##

    HC_LOG_SUM = "h1:bkKf0BeBXcSYa7f5Fyi9gMuQ8gNsxeiNpZjR6VxNZeo="
    HC_LOG_VERSION = "v1.0.0"

    go_repository(
        name = "com_github_hashicorp_go_hclog",
        importpath = "github.com/hashicorp/go-hclog",
        sum = "%s" % HC_LOG_SUM,
        version = "%s" % HC_LOG_VERSION,
    )

    ROOT_CERTS_SUM = "h1:jzhAVGtqPKbwpyCPELlgNWhE1znq+qwJtW5Oi2viEzc="
    ROOT_CERTS_VERSION = "v1.0.2"

    go_repository(
        name = "com_github_hashicorp_go_rootcerts",
        importpath = "github.com/hashicorp/go-rootcerts",
        sum = "%s" % ROOT_CERTS_SUM,
        version = "%s" % ROOT_CERTS_VERSION,
    )

    CONSUL_SUM = "h1:Hw/G8TtRvOElqxVIhBzXciiSTbapq8hZ2XKZsXk5ZCE="
    CONSUL_VERSION = "v1.11.0"

    go_repository(
        name = "com_github_hashicorp_consul_api",
        importpath = "github.com/hashicorp/consul/api",
        sum = "%s" % CONSUL_SUM,
        version = "%s" % CONSUL_VERSION,
    )

    ## End consul dependencies ##
