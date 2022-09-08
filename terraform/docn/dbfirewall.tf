resource "digitalocean_database_firewall" "mono-dbfirewall" {
    cluster_id = digitalocean_database_cluster.mono-dbcluster.id

    rule {
        type  = "k8s"
        value = digitalocean_kubernetes_cluster.mono-doks.id
    }
}
