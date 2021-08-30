# SEE: https://github.com/bazelbuild/rules_go/issues/2603
# gazelle:repository go_repository name=org_golang_x_sys importpath=golang.org/x/sys
# gazelle:repository go_repository name=com_github_google_go_containerregistry importpath=github.com/vdemeester/k8s-pkg-credentialprovider
# gazelle:reposiroty go_repository name=com_github_google_go_containerregistry importpath=k8s.io/client-go/kubernetes

workspace(
    name = "veganafro_mono",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

## Begin df ##

DF_COMMIT = "42bedcba494c8d46b9fbc6aaf40c0202d217f29e"
DF_SHALLOW_SINCE = "1619103159 +0100"

git_repository(
    name = "df",
    commit = DF_COMMIT,
    remote = "https://github.com/dataform-co/dataform.git",
    shallow_since = DF_SHALLOW_SINCE,
)

load("@df//tools/helm:repository_rules.bzl", "helm_tool", "helm_chart")

HEML_TOOL_VERSION = "v3.6.2"

helm_tool(
    name = "helm_tool",
    version = HEML_TOOL_VERSION,
)

CONSUL_CHART_VERSION = "0.33.0"

helm_chart(
    name = "hashicorp",
    chartname = "consul",
    repo_url = "https://helm.releases.hashicorp.com",
    version = CONSUL_CHART_VERSION,
)

## End df ##

# SEE: https://github.com/bazelbuild/rules_python/issues/437
## Begin rules_python - 05/13 ##

RULES_PYTHON_SHA = "b6d46438523a3ec0f3cead544190ee13223a52f6a6765a29eae7b7cc24cc83a0"
RULES_PYTHON_VERSION = "0.1.0"

http_archive(
    name = "rules_python",
    sha256 = RULES_PYTHON_SHA,
    urls = [
        "https://github.com/bazelbuild/rules_python/releases/download/{}/rules_python-{}.tar.gz".format(
            RULES_PYTHON_VERSION, RULES_PYTHON_VERSION
        )
    ],
)

## End rules_python - 05/13 ##

## Begin com_google_protobuf - 05/13 ##

COM_GOOGLE_PROTOBUF_SHA = "eaba1dd133ac5167e8b08bc3268b2d33c6e9f2dcb14ec0f97f3d3eed9b395863"
COM_GOOGLE_PROTOBUF_VERSION = "3.17.0"

http_archive(
    name = "com_google_protobuf",
    sha256 = COM_GOOGLE_PROTOBUF_SHA,
    strip_prefix = "protobuf-%s" % COM_GOOGLE_PROTOBUF_VERSION,
    urls = [
        "https://github.com/protocolbuffers/protobuf/archive/v%s.tar.gz" % COM_GOOGLE_PROTOBUF_VERSION
    ],
)

## End com_google_protobuf ##

## Begin rules_proto - 05/13 ##

RULES_PROTO_SHA = "9fc210a34f0f9e7cc31598d109b5d069ef44911a82f507d5a88716db171615a8"
RULES_PROTO_TAG = "f7a30f6f80006b591fa7c437fe5a951eb10bcbcf"

http_archive(
    name = "rules_proto",
    sha256 = RULES_PROTO_SHA,
    strip_prefix = "rules_proto-%s" % RULES_PROTO_TAG,
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/%s.tar.gz" % RULES_PROTO_TAG,
        "https://github.com/bazelbuild/rules_proto/archive/%s.tar.gz" % RULES_PROTO_TAG,
    ],
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()
rules_proto_toolchains()

## End rules_proto ##

## Begin io_bazel_rules_go - 05/13 ##

RULES_GO_SHA = "8e968b5fcea1d2d64071872b12737bbb5514524ee5f0a4f54f5920266c261acb"
RULES_GO_VERSION = "0.28.0"

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

## End io_bazel_rules_go ##

## Begin bazel_gazelle - 05/13 ##

BAZEL_GAZELLE_SHA = "222e49f034ca7a1d1231422cdb67066b885819885c356673cb1f72f748a3c9d4"
BAZEL_GAZELLE_VERSION = "0.22.3"

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

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()
go_register_toolchains(version = "1.16")

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

load("//golang:repositories.bzl", "go_deps")

go_deps()

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

## End bazel_gazelle ##

## Begin grpc-gateway - 05/13 ##

GRPC_GATEWAY_V2_COMMIT = "74ecd1deffacf97bcbee90e81c631ef6a3c275f2"
GRPC_GATEWAY_V2_SHA = "6c98b5b72512a5ff232c76503a74243469cb2772d486fe38629c13878ce7cf8a"

http_archive(
    name = "com_github_grpc_ecosystem_grpc_gateway_v2",
    sha256 = GRPC_GATEWAY_V2_SHA,
    strip_prefix = "grpc-gateway-%s" % GRPC_GATEWAY_V2_COMMIT,
    urls = [
        "https://github.com/grpc-ecosystem/grpc-gateway/archive/%s.tar.gz" % GRPC_GATEWAY_V2_COMMIT
    ],
)

## End grpc-gateway ##

## Begin rules_docker ##

RULES_DOCKER_SHA = "59d5b42ac315e7eadffa944e86e90c2990110a1c8075f1cd145f487e999d22b3"
RULES_DOCKER_VERSION = "0.17.0"

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = RULES_DOCKER_SHA,
    strip_prefix = "rules_docker-%s" % RULES_DOCKER_VERSION,
    urls = [
        "https://github.com/bazelbuild/rules_docker/releases/download/v{}/rules_docker-v{}.tar.gz".format(
            RULES_DOCKER_VERSION, RULES_DOCKER_VERSION
        )
    ],
)

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

container_pull(
    name = "bazel_4_2_0",
    # 'tag' is also supported, but digest is encouraged for reproducibility.
    digest = "sha256:c30c0bad867cb2f99ca6b27808e9b6a6148b64dc84c5daca3d24c0d8d6fc1b28",
    registry = "gcr.io",
    repository = "cloud-builders/bazel",
)

## End rules_docker ##

## Begin rules_k8s - 07/01 ##

RULES_K8S_SHA = "773aa45f2421a66c8aa651b8cecb8ea51db91799a405bd7b913d77052ac7261a"
RULES_K8S_VERSION = "v0.5"

http_archive(
    name = "io_bazel_rules_k8s",
    strip_prefix = "rules_k8s-0.5",
    urls = [
        "https://github.com/bazelbuild/rules_k8s/archive/{}.tar.gz".format(
            RULES_K8S_VERSION
        )
    ],
    sha256 = RULES_K8S_SHA,
)

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")

k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s_go_deps.bzl", k8s_go_deps = "deps")

k8s_go_deps()

## End rules_k8s 07/01 ##

## Begin rules_pkg ##

RULES_PKG_SHA = "038f1caa773a7e35b3663865ffb003169c6a71dc995e39bf4815792f385d837d"
RULES_PKG_VERSION = "0.4.0"

http_archive(
    name = "rules_pkg",
    sha256 = RULES_PKG_SHA,
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/{}/rules_pkg-{}.tar.gz".format(
            RULES_PKG_VERSION, RULES_PKG_VERSION
        ),
        "https://github.com/bazelbuild/rules_pkg/releases/download/{}/rules_pkg-{}.tar.gz".format(
            RULES_PKG_VERSION, RULES_PKG_VERSION
        ),
    ],
)

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

## End rules_pkg ##
