"""
Dependencies that are needed for proto tests and tools.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def proto_deps():
    """
    Fetches all required dependencies for proto tests and tools.
    """
    COM_GOOGLE_PROTOBUF_SHA = "3bd7828aa5af4b13b99c191e8b1e884ebfa9ad371b0ce264605d347f135d2568"
    COM_GOOGLE_PROTOBUF_VERSION = "3.19.4"

    maybe(
        http_archive,
        name = "com_google_protobuf",
        sha256 = COM_GOOGLE_PROTOBUF_SHA,
        strip_prefix = "protobuf-%s" % COM_GOOGLE_PROTOBUF_VERSION,
        urls = [
            "https://github.com/protocolbuffers/protobuf/archive/v%s.tar.gz" % COM_GOOGLE_PROTOBUF_VERSION
        ],
    )

    RULES_PROTO_SHA = "9850fcf6ad40fa348e6f13b2cfef4bb4639762f804794f2bf61d988f4ba0dae9"
    RULES_PROTO_VERSION = "4.0.0-3.19.2-2"

    maybe(
        http_archive,
        name = "rules_proto",
        sha256 = RULES_PROTO_SHA,
        strip_prefix = "rules_proto-%s" % RULES_PROTO_VERSION,
        urls = [
            "https://github.com/bazelbuild/rules_proto/archive/refs/tags/%s.tar.gz" % RULES_PROTO_VERSION,
        ],
    )
