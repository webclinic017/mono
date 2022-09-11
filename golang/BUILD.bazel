load("@bazel_gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/veganafro/mono/golang
# gazelle:go_grpc_compilers @com_github_grpc_ecosystem_grpc_gateway_v2//protoc-gen-grpc-gateway:go_gen_grpc_gateway, @io_bazel_rules_go//proto:go_grpc

gazelle(name = "gazelle")

gazelle(
    name = "gazelle-update-repos",
    args = [
        "-from_file=golang/go.mod",
        "-to_macro=golang/repositories_go.bzl%go_repository_deps",
        "-prune",
    ],
    command = "update-repos",
)
