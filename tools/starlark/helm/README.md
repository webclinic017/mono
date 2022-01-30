# Summary

These Helm bazel tools are borrowed from [dataform](https://github.com/dataform-co/dataform/tree/master/tools/helm) and are intended
to Bazel-ify the installation of Helm charts as recommended and demonstrated [here](https://dev.to/benbirt/the-right-way-to-install-helm-charts-4mjp).
Reproducing them here decreases the number of build dependencies we need to import in the `WORKSPACE` file.
