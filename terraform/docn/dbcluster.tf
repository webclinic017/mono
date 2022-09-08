resource "digitalocean_database_cluster" "mono-dbcluster" {
    name                 = "mono-dbcluster-nyc3"
    engine               = "pg"
    node_count           = 1
    private_network_uuid = digitalocean_vpc.mono-vpc.id
    region               = "nyc3"
    size                 = "db-s-1vcpu-2gb"
    version              = "14"
    tags                 = [ "dbcluster", "mono-nyc3", "prod" ]

    maintenance_window {
        hour        = "02:00"
        day         = "saturday"
    }
}
