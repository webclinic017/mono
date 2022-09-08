resource "digitalocean_vpc" "mono-vpc" {
    name        = "mono-vpc-nyc3"
    description = "VPC for mono compute and data infrastructure"
    region      = "nyc3"
}
