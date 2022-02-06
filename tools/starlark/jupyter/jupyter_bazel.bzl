"""
Create a target to run a Jupyter notebook
"""

load("//tools/starlark/jupyter:generate_file.bzl", "generate_file")
load("@rules_python//python:defs.bzl", "py_binary")

# Generate file, because we wish to bake the file directly in, and not require
# it be passed as an argument.
_JUPYTER_PY_TEMPLATE = """
import argparse
import os
import sys

from jupyter_core.command import main as _jupyter_main

def _jupyter_bazel_notebook_main(cur_dir, notebook_file, argv):
    # This should *ONLY* be called by targets generated via `jupyter_py_*`
    # rules.
    parser = argparse.ArgumentParser()
    args = parser.parse_args(argv)

    # Assume that (hopefully) the notebook neighbors this generated file.
    # Failure mode: If user puts a slash in the `name` which does not match the
    # notebook's location. This should be infrequent.
    notebook_path = os.path.join(cur_dir, notebook_file)
    if not os.path.isfile(notebook_path):
        # `name` may contain a subdirectory. Just use basename of file.
        notebook_path = os.path.join(cur_dir, os.path.basename(notebook_file))

    sys.argv = ["jupyter", "notebook", notebook_path]
    exit(_jupyter_main())

def main():
    cur_dir = os.path.dirname(__file__)
    notebook = {notebook}
    _jupyter_bazel_notebook_main(cur_dir, notebook, sys.argv[1:])

if __name__ == "__main__":
    main()
""".lstrip()

def jupyter_py_binary(
    name,
    notebook = None,
    srcs = None,
    data = [],
    deps = [],
    tags = [],
    **kwargs):
    """
    Creates a target to run a Jupyter notebook.

    Please see https://github.com/RobotLocomotion/drake/tree/master/tools/jupyter/README.md for examples.

    Args:
        name: The name of the target
        notebook: Notebook file to use. Be default, will be `{name}.ipynb`
        srcs: Unused argument
        data: Data files needed by the notebook
        deps: The notebook's dependencies
        tags: Unused argument
        **kwargs: Keyword arguments
    """
    if srcs != None:
        fail("srcs is an invalid argument")
    if notebook == None:
        notebook = name + ".ipynb"
    main = "{}_jupyter_py_main.py".format(name)

    # Do not lint these generated targets.
    jupyter_tags = tags + ["jupyter", "nolint"]
    generate_file(
        name = main,
        content = _JUPYTER_PY_TEMPLATE.format(
            notebook = repr(notebook),
        ),
        is_executable = False,
    )
    py_binary(
        name = name,
        srcs = [main],
        main = main,
        data = data + [notebook],
        deps = deps + [],
        # `generate_file` output is still marked as executable :(
        tags = jupyter_tags,
        **kwargs
    )
