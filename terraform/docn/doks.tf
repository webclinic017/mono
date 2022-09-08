resource "digitalocean_kubernetes_cluster" "mono-doks" {
    name          = "mono-doks-nyc3"
    auto_upgrade  = true
    region        = "nyc3"
    surge_upgrade = true
    tags          = [ "doks", "mono-nyc3", "prod" ]
    version       = "1.24.4-do.0"
    vpc_uuid      = digitalocean_vpc.mono-vpc.id

    maintenance_policy {
        start_time  = "02:00"
        day         = "saturday"
    }

    node_pool {
        name       = "mono-nodepool-nyc3"
        size       = "s-2vcpu-4gb"
        auto_scale = true
        min_nodes  = 2
        max_nodes  = 2
        tags       = [ "nodepool", "mono-nyc3", "prod" ]
    }
}
