# Summary

Resources related to Jupyter research notebooks and other python resources can be found here.

## Getting started

To develop python and Jupyter related sources, start by installing [`pyenv`](https://github.com/pyenv/pyenv) so that we
can install and manage python versions.

```
$ brew install pyenv@1.2.21
```
Now add the following line to `.bash_profile`:

```
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
```
Also install `ta-lib`:

```
$ brew install ta-lib
```

Finally, set the python versions and packages we want with:

```
$ pyenv install 3.9.0
$ pyenv install 2.7.18
$ pyenv global 3.9.0 2.7.18
```

Assuming python has been installed as instructed above, `pip` install `virtualenv` like so:

```
$ pip install virtualenv
```
Navigate to the [`python`](.) directory and create a virtual environment:

```
$ virtualenv venv
```

From that same directory, activate the virutal environment and install the relevant `pip` dependencies:

```
$ source ./venv/bin/activate
$ pip install -r requirements.in
```

## Interacting with notebooks

Now that Bazel rules are available to start and directly edit Jupyter notebooks, simply load those rules (found in the
`//tools/starlark/jupyter` package), then create a `jupyter_py_binary` target with whatever `pip` or local dependencies
are needed. Running that target will start a Jupyter session in the browser with the new notebook.

Alternatively, run an existing `jupyter_py_binary` target to make saveable changes to an old notebook. Edit and save the
notebook using a standard workflow, and when complete, log out of the Jupyter session.

Don't forget to deactivate the virtual environment:

```
$ deactivate
```

## Helpful notes

[Jupyter via bazel](https://github.com/bazelbuild/rules_python/issues/63)
