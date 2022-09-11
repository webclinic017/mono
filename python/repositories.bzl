"""
Dependencies that are needed for python tests and tools.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def python_deps():
    """
    Fetches all required dependencies for python tests and tools.
    """

    RULES_PYTHON_SHA = "b593d13bb43c94ce94b483c2858e53a9b811f6f10e1e0eedc61073bd90e58d9c"
    RULES_PYTHON_VERSION = "0.12.0"

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
