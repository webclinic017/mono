# Summary

Mono is meant to be a monorepo containing all the relevant information and source files needed to build a learning oriented Android and iOS app. These clients are
supported by a gRPC based Go server. The client and backend communicate using Protocol Buffers sent over HTTP. Dive into each subdirectory to learn more.

## Getting started

### Setting up a dev environment

Start by installing [`brew`](https://brew.sh/) as shown in the linked instructions

With the introduction of the [Bazel](https://bazel.build/) system, getting up and running is fairly simple. The first requirement
is that `bazel` be installed like so:

```
$ brew install bazel@4.2.0
```
Be sure to add the following line to `.bash_profile`:

```
source $(brew --prefix)/etc/bash_completion.d/bazel-complete.bash
```
Next, install [`docker`](https://docs.docker.com/docker-for-mac/install/) manually by following the linked steps.

The third step is to install [`pyenv`](https://github.com/pyenv/pyenv) so that we can install and manage `python` versions. This
is needed so that we can `pip install futures`, which is meant to fix [this](https://github.com/bazelbuild/bazel/issues/12741) error. 

```
$ brew install pyenv@1.2.21
```
Now add the following line to `.bash_profile`:

```
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
```
Finally, we can set the python versions and packages we want with

```
$ pyenv install 3.9.0
$ pyenv install 2.7.18
$ pyenv global 3.9.0 2.7.18
$ pip2 install futures
```
From here, use the editors and IDEs you're most comfortable with to make changes.

## License

Mono is available under the MIT license. See the `LICENSE` file for details.

