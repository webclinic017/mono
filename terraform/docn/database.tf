resource "digitalocean_database_db" "mono-database" {
    cluster_id = digitalocean_database_cluster.mono-dbcluster.id
    name       = "mono-database-nyc3"
}
