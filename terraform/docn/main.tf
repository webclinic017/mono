terraform {
    required_providers {
        digitalocean = {
            source = "digitalocean/digitalocean"
            version = "~> 2.0"
        }
    }

    cloud {
        organization = "fjarm"
        workspaces {
            name = "mono-docn"
        }
    }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {
    sensitive = true
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
    token = var.do_token
}
