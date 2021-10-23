# SEE: https://github.com/bazelbuild/rules_go/issues/2603
# gazelle:repository go_repository name=org_golang_x_sys importpath=golang.org/x/sys
# gazelle:repository go_repository name=com_github_google_go_containerregistry importpath=github.com/vdemeester/k8s-pkg-credentialprovider
# gazelle:reposiroty go_repository name=com_github_google_go_containerregistry importpath=k8s.io/client-go/kubernetes
# gazelle:reposiroty go_repository name=com_github_armon_go_metrics importpath=github.com/circonus-labs/circonus-gometrics
# gazelle:repository_macro golang/repositories.bzl%go_deps

workspace(
    name = "veganafro_mono",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

## Begin df ##

DF_VERSION = "1.20.0"
DF_SHA = "527c30e8665b4be20a55610b60da5be28fbda0806d131929e33e3bc2b54aad00"

http_archive(
    name = "df",
    sha256 = DF_SHA,
    strip_prefix = "dataform-%s" % DF_VERSION,
    urls = [
        "https://github.com/dataform-co/dataform/archive/{}.tar.gz".format(
            DF_VERSION
        ),
    ],
)

load("@df//tools/helm:repository_rules.bzl", "helm_tool", "helm_chart")

HEML_TOOL_VERSION = "v3.6.2"

helm_tool(
    name = "helm_tool",
    version = HEML_TOOL_VERSION,
)

CONSUL_CHART_VERSION = "0.34.1"

helm_chart(
    name = "hashicorp",
    chartname = "consul",
    repo_url = "https://helm.releases.hashicorp.com",
    version = CONSUL_CHART_VERSION,
)

## End df ##

# SEE: https://github.com/bazelbuild/rules_python/issues/437
## Begin rules_python - 05/13 ##

RULES_PYTHON_SHA = "934c9ceb552e84577b0faf1e5a2f0450314985b4d8712b2b70717dc679fdc01b"
RULES_PYTHON_VERSION = "0.3.0"

http_archive(
    name = "rules_python",
    sha256 = RULES_PYTHON_SHA,
    urls = [
        "https://github.com/bazelbuild/rules_python/releases/download/{}/rules_python-{}.tar.gz".format(
            RULES_PYTHON_VERSION, RULES_PYTHON_VERSION
        )
    ],
)

load("@rules_python//python:pip.bzl", "pip_install")

# Create a central external repo, @my_deps, that contains Bazel targets for all the
# third-party packages specified in the requirements.txt file.
pip_install(
   name = "py_deps",
   requirements = "//python:requirements.txt",
)

## End rules_python - 05/13 ##

## Begin com_google_protobuf - 05/13 ##

COM_GOOGLE_PROTOBUF_SHA = "14e8042b5da37652c92ef6a2759e7d2979d295f60afd7767825e3de68c856c54"
COM_GOOGLE_PROTOBUF_VERSION = "3.18.0"

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

RULES_PROTO_SHA = "66bfdf8782796239d3875d37e7de19b1d94301e8972b3cbd2446b332429b4df1"
RULES_PROTO_VERSION = "4.0.0"

http_archive(
    name = "rules_proto",
    sha256 = RULES_PROTO_SHA,
    strip_prefix = "rules_proto-%s" % RULES_PROTO_VERSION,
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/refs/tags/%s.tar.gz" % RULES_PROTO_VERSION,
        "https://github.com/bazelbuild/rules_proto/archive/refs/tags/%s.tar.gz" % RULES_PROTO_VERSION,
    ],
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()
rules_proto_toolchains()

## End rules_proto ##

## Begin io_bazel_rules_go - 05/13 ##

RULES_GO_SHA = "2b1641428dff9018f9e85c0384f03ec6c10660d935b750e3fa1492a281a53b0f"
RULES_GO_VERSION = "0.29.0"

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

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()
go_register_toolchains(version = "1.17.1")

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

load("//golang:repositories.bzl", "go_deps")

go_deps()

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

## End bazel_gazelle ##

## Begin grpc-gateway - 05/13 ##

GRPC_GATEWAY_V2_SHA = "4a1a50fcb2dafb0134db0be669d3d8d8dd0d6933f88a3e580fee2727ccf5ebc2"
GRPC_GATEWAY_V2_VERSION = "2.6.0"

http_archive(
    name = "com_github_grpc_ecosystem_grpc_gateway_v2",
    sha256 = GRPC_GATEWAY_V2_SHA,
    strip_prefix = "grpc-gateway-%s" % GRPC_GATEWAY_V2_VERSION,
    urls = [
        "https://github.com/grpc-ecosystem/grpc-gateway/archive/v%s.tar.gz" % GRPC_GATEWAY_V2_VERSION
    ],
)

load("@com_github_grpc_ecosystem_grpc_gateway_v2//:repositories.bzl", "go_repositories")

go_repositories()

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

load("@io_bazel_rules_docker//go:image.bzl", _go_image_repos = "repositories")

_go_image_repos()

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

container_pull(
  name = "debian_base",
  registry = "gcr.io",
  repository = "distroless/static",
  # 'tag' is also supported, but digest is encouraged for reproducibility.
  digest = "sha256:a5635fa9dda1cf81666d8c288130bf3519bdeab1b7ed717db496a73d25d1b35c",
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
