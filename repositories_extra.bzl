"""
`docker_deps` and `k8s_deps` loads all the relevant extra dependencies like Docker and k8s
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def docker_deps():
    """
    `docker_deps` loads Docker
    """
    RULES_DOCKER_SHA = "27d53c1d646fc9537a70427ad7b034734d08a9c38924cc6357cc973fed300820"
    RULES_DOCKER_VERSION = "0.24.0"

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

def k8s_deps():
    """
    `k8s_deps` loads Docker
    """
    RULES_K8S_SHA = "51f0977294699cd547e139ceff2396c32588575588678d2054da167691a227ef"
    RULES_K8S_VERSION = "0.6"

    http_archive(
        name = "io_bazel_rules_k8s",
        strip_prefix = "rules_k8s-%s" % RULES_K8S_VERSION,
        urls = [
            "https://github.com/bazelbuild/rules_k8s/archive/v{}.tar.gz".format(
                RULES_K8S_VERSION
            )
        ],
        sha256 = RULES_K8S_SHA,
    )
