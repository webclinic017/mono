# SEE: https://github.com/bazelbuild/rules_go/issues/2603
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

# Create a central external repo, @my_deps, that contains Bazel targets for all the
# third-party packages specified in the requirements.txt file.
load("@rules_python//python:pip.bzl", "pip_install")
pip_install(
    name = "py_deps",
    requirements = "//python:requirements.txt",
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
go_register_toolchains(version = "1.18")

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
    # 'tag' is also supported, but digest is encouraged for reproducibility.
    # SEE: https://console.cloud.google.com/gcr/images/distroless/GLOBAL/static
    digest = "sha256:11a4c488b4dbf450bf5e1552e0209c9dce09c99cd5fac8fb7eb0c451c5bc6eed",
    registry = "gcr.io",
    repository = "distroless/static",
)

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")
k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s_go_deps.bzl", k8s_go_deps = "deps")
# Call k8s_go_deps with an empty string so go_register_toolchains isn't called again
k8s_go_deps("")

## End extra ##

## Begin Android rules ##

load("//android:repositories.bzl", "android_deps", "maven_deps")
android_deps()

load("@build_bazel_rules_android//android:rules.bzl", "android_ndk_repository", "android_sdk_repository")

android_sdk_repository(
    name = "androidsdk",
    api_level = 30,
    build_tools_version = "30.0.3",
)

android_ndk_repository(
    name = "androidndk",
)

load("@io_bazel_rules_kotlin//kotlin:repositories.bzl", "kotlin_repositories")
kotlin_repositories()

load("@io_bazel_rules_kotlin//kotlin:core.bzl", "kt_register_toolchains")
kt_register_toolchains()

load("@robolectric//bazel:robolectric.bzl", "robolectric_repositories")
robolectric_repositories()

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")
rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")
rules_jvm_external_setup()

maven_deps()

## End Android rules ##
