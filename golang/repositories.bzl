"""
Dependencies that are needed for golang tests and tools.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def go_deps():
    """
    Fetches all required dependencies for proto tests and tools.
    """
    RULES_GO_SHA = "d6b2513456fe2229811da7eb67a444be7785f5323c6708b38d851d2b51e54d83"
    RULES_GO_VERSION = "0.30.0"

    http_archive(
        name = "io_bazel_rules_go",
        sha256 = RULES_GO_SHA,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v{}/rules_go-v{}.zip".format(
                RULES_GO_VERSION, RULES_GO_VERSION
            ),
            "https://github.com/bazelbuild/rules_go/releases/download/v{}/rules_go-v{}.zip".format(
                RULES_GO_VERSION, RULES_GO_VERSION
            ),
        ],
    )

    BAZEL_GAZELLE_SHA = "de69a09dc70417580aabf20a28619bb3ef60d038470c7cf8442fafcf627c21cb"
    BAZEL_GAZELLE_VERSION = "0.24.0"

    http_archive(
        name = "bazel_gazelle",
        sha256 = BAZEL_GAZELLE_SHA,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v{}/bazel-gazelle-v{}.tar.gz".format(
                BAZEL_GAZELLE_VERSION, BAZEL_GAZELLE_VERSION
            ),
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v{}/bazel-gazelle-v{}.tar.gz".format(
                BAZEL_GAZELLE_VERSION, BAZEL_GAZELLE_VERSION
            ),
        ],
    )

    GRPC_GATEWAY_V2_SHA = "d7136b4ced1d8b270144953c610635ebc6cdf017863171829ed5bf8c0e8800d7"
    GRPC_GATEWAY_V2_VERSION = "2.10.0"

    http_archive(
        name = "com_github_grpc_ecosystem_grpc_gateway_v2",
        sha256 = GRPC_GATEWAY_V2_SHA,
        strip_prefix = "grpc-gateway-%s" % GRPC_GATEWAY_V2_VERSION,
        urls = [
            "https://github.com/grpc-ecosystem/grpc-gateway/archive/v%s.tar.gz" % GRPC_GATEWAY_V2_VERSION
        ],
    )
