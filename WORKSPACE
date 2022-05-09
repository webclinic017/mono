# SEE: https://github.com/bazelbuild/rules_go/issues/2603
# gazelle:repository go_repository name=org_golang_x_sys importpath=golang.org/x/sys
# gazelle:repository go_repository name=com_github_google_go_containerregistry importpath=github.com/vdemeester/k8s-pkg-credentialprovider
# gazelle:reposiroty go_repository name=com_github_google_go_containerregistry importpath=k8s.io/client-go/kubernetes
# gazelle:reposiroty go_repository name=com_github_armon_go_metrics importpath=github.com/circonus-labs/circonus-gometrics
# gazelle:repository_macro golang/repositories_go.bzl%go_repository_deps

workspace(name = "com_github_veganafro_mono")

## Begin helm ##

load("//helm:repositories.bzl", "helm_deps")
helm_deps()

## End helm ##

# SEE: https://github.com/bazelbuild/rules_python/issues/437
## Begin python ##

load("//python:repositories.bzl", "python_deps")
python_deps()

load("@rules_python//python:repositories.bzl", "python_register_toolchains")

# Available versions are listed in @rules_python//python:versions.bzl.
python_register_toolchains(name = "python3_9", python_version = "3.9")
load("@python3_9//:defs.bzl", "interpreter")

# Create a central external repo, @my_deps, that contains Bazel targets for all the
# third-party packages specified in the requirements.txt file.
load("@rules_python//python:pip.bzl", "pip_install")
pip_install(
    name = "py_deps",
    python_interpreter_target = interpreter,
    requirements = "//python:requirements.txt"
)

## End python ##

## Begin proto ##

load("//proto:repositories.bzl", "proto_deps")
proto_deps()

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
protobuf_deps()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")
rules_proto_dependencies()
rules_proto_toolchains()

## End proto ##

## Begin golang ##

load("//golang:repositories.bzl", "go_deps")
go_deps()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
go_rules_dependencies()
go_register_toolchains(version = "1.17.7")

load("//golang:repositories_go.bzl", "go_repository_deps")
go_repository_deps()

load("@com_github_grpc_ecosystem_grpc_gateway_v2//:repositories.bzl", "go_repositories")
go_repositories()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
gazelle_dependencies()

## End golang ##

## Begin extra ##

load("//:repositories_extra.bzl", "docker_deps", "k8s_deps")
docker_deps()
k8s_deps()

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

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")
k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s_go_deps.bzl", k8s_go_deps = "deps")
k8s_go_deps()

## End extra ##
