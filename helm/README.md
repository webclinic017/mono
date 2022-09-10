# Summary

Resources related to helm charts for the mono backend.

## Setup

The order of operations is as follows:

```shell
$ bazel run //helm/consul/{dev,prod}:consul-all.apply
$ bazel run //helm/cert-manager/{dev,prod}:cert-manager-all.apply
$ bazel run //helm/cert-manager/{dev,prod}:cert-manager-acme-clusterissuer.apply
$ bazel run //helm/nginx-ingress/{dev,prod}:nginx-ingress-all.apply
$ bazel run //helm/consul/{dev,prod}/intentions:intentions-all.apply
```

## Dependencies

### Helm

| Name | Version | Notes |
|------|---------|-------|
| [consul](https://github.com/hashicorp/consul-k8s) | [0.47.1](https://github.com/hashicorp/consul-k8s/releases/tag/v0.47.1) | N/A |
| [vault](https://github.com/hashicorp/vault-helm) | [0.19.0](https://github.com/hashicorp/vault-helm/releases/tag/v0.19.0) | N/A |
| [cert-manager](https://github.com/cert-manager/cert-manager) | [1.9.1](https://github.com/cert-manager/cert-manager/releases/tag/v1.9.1) | N/A |
| [ingress-nginx](https://github.com/kubernetes/ingress-nginx) | [4.2.3](https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx/4.2.3) | N/A |
