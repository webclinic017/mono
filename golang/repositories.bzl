"""
Dependencies that are needed for golang tests and tools.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def go_deps():
    """
    Fetches all required dependencies for proto tests and tools.
    """
    RULES_GO_SHA = "099a9fb96a376ccbbb7d291ed4ecbdfd42f6bc822ab77ae6f1b5cb9e914e94fa"
    RULES_GO_VERSION = "0.35.0"

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

    BAZEL_GAZELLE_SHA = "501deb3d5695ab658e82f6f6f549ba681ea3ca2a5fb7911154b5aa45596183fa"
    BAZEL_GAZELLE_VERSION = "0.26.0"

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

    GRPC_GATEWAY_V2_SHA = "6b180623ed23e545d66b05bd0e32d87623048c5d37dcda4f6aaab21b84170d46"
    GRPC_GATEWAY_V2_VERSION = "2.11.3"

    http_archive(
        name = "com_github_grpc_ecosystem_grpc_gateway_v2",
        sha256 = GRPC_GATEWAY_V2_SHA,
        strip_prefix = "grpc-gateway-%s" % GRPC_GATEWAY_V2_VERSION,
        urls = [
            "https://github.com/grpc-ecosystem/grpc-gateway/archive/v%s.tar.gz" % GRPC_GATEWAY_V2_VERSION
        ],
    )
