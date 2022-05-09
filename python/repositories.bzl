"""
Dependencies that are needed for python tests and tools.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def python_deps():
    """
    Fetches all required dependencies for python tests and tools.
    """

    RULES_PYTHON_SHA = "cdf6b84084aad8f10bf20b46b77cb48d83c319ebe6458a18e9d2cebf57807cdd"
    RULES_PYTHON_VERSION = "0.8.1"

    http_archive(
        name = "rules_python",
        sha256 = RULES_PYTHON_SHA,
        strip_prefix = "rules_python-%s" % RULES_PYTHON_VERSION,
        urls = [
            "https://github.com/bazelbuild/rules_python/archive/refs/tags/{}.tar.gz".format(
                RULES_PYTHON_VERSION
            )
        ],
    )
