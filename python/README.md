# Summary

Resources related to Jupyter research notebooks and other python resources can be found here.

## Getting started

Rather than editing Jupyter notebooks directly in the Jupyter GUI, mono takes advantage of
[Google Colaboratory](https://colab.research.google.com/notebooks/intro.ipynb).

In practice, this means starting a Jupyter notebook server on a local machine then uploading a
notebook to Colab where edits can be made and the notebook can be run. When the notebook has
reached a satisfactory state, it can be downloaded to the local machine and moved into the repo
for git tracking.

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

### Creating new notebooks

From there, start a Jupyter notebook server with blaze by calling the `start_local_runtimes.sh`
script. Follow [these](https://research.google.com/colaboratory/local-runtimes.html) instructions to connect Google Colab
to the local runtime.

After editing, download the notebook to the local machine and move it into the `python/notebook`
directory so it can be tracked by git.

Don't forget to deactivate the virtual environment:

```
$ deactivate
```

## Helpful notes

[Jupyter via bazel](https://github.com/bazelbuild/rules_python/issues/63)
