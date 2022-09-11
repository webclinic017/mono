"""
`docker_deps` and `k8s_deps` loads all the relevant extra dependencies like Docker and k8s
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def docker_deps():
    """
    `docker_deps` loads Docker
    """
    RULES_DOCKER_SHA = "b1e80761a8a8243d03ebca8845e9cc1ba6c82ce7c5179ce2b295cd36f7e394bf"
    RULES_DOCKER_VERSION = "0.25.0"

    http_archive(
        name = "io_bazel_rules_docker",
        sha256 = RULES_DOCKER_SHA,
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
    RULES_K8S_SHA = "ce5b9bc0926681e2e7f2147b49096f143e6cbc783e71bc1d4f36ca76b00e6f4a"
    RULES_K8S_VERSION = "0.7"

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
