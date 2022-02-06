# Summary

Resources related to Jupyter research notebooks and other python resources can be found here.

## Getting started

Now that Bazel rules are available in the project to start and directly edit Jupyter notebooks, simply load those rules
(found in the `//tools/starlark/jupyter` package) and create a `jupyter_py_binary` target. Running that target will
start a Jupyter session in the browser with the specified notebook.

### Setup

Assuming python has been installed as instructed in the top level [README](../README.md), `pip`
install `virtualenv` like so:

```
$ pip install virtualenv
```
Navigate to the `python` directory and create a virtual environment:

```
$ virtualenv venv
```

Activate the virutal environment and install the relevant `pip` dependencies:

```
$ source ./venv/bin/activate
$ pip install -r requirements.in
```

### Interacting with notebooks

From there, run an existing `jupyter_py_binary` target or create a new one with whatever `pip` or local dependencies are
needed. Edit and save the notebook using a standard workflow, and when complete, log out of the Jupyter session.

Don't forget to deactivate the virtual environment:

```
$ deactivate
```

## Helpful notes

[Jupyter via bazel](https://github.com/bazelbuild/rules_python/issues/63)
