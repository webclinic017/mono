#!/usr/bin/env bash

# https://research.google.com/colaboratory/local-runtimes.html

bazel run //python/notebooks:start_local_runtime -- \
  --NotebookApp.allow_origin='https://colab.research.google.com' \
  --port=8888 \
  --NotebookApp.port_retires=0
