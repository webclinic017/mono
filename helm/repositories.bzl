"""
Dependencies that are needed for helm tests and tools.
"""

load("//tools/starlark/helm:repository_rules.bzl", "helm_tool", "helm_chart")

def helm_deps():
    """
    Fetches all required dependencies for helm tests and tools.
    """
    HEML_TOOL_VERSION = "v3.6.2"

    helm_tool(
        name = "helm_tool",
        version = HEML_TOOL_VERSION,
    )

    CONSUL_CHART_VERSION = "0.47.1"

    helm_chart(
        name = "consul",
        reponame = "hashicorp",
        chartname = "consul",
        repo_url = "https://helm.releases.hashicorp.com",
        version = CONSUL_CHART_VERSION,
    )

    VAULT_CHART_VERSION = "0.19.0"

    helm_chart(
        name = "vault",
        reponame = "hashicorp",
        chartname = "vault",
        repo_url = "https://helm.releases.hashicorp.com",
        version = VAULT_CHART_VERSION,
    )

    CERT_MANAGER_VERSION = "v1.9.1"

    helm_chart(
        name = "cert-manager",
        reponame = "jetstack",
        chartname = "cert-manager",
        repo_url = "https://charts.jetstack.io",
        version = CERT_MANAGER_VERSION,
    )

    NGINX_INGRESS_VERSION = "v4.2.3"

    helm_chart(
        name = "nginx-ingress",
        reponame = "ingress-nginx",
        chartname = "ingress-nginx",
        repo_url = "https://kubernetes.github.io/ingress-nginx",
        version = NGINX_INGRESS_VERSION,
    )
