# Summary

Terraform resources needed to provision cloud (DigitalOcean) infrastructure including:
1. VPC
1. K8s cluster
1. K8s node pool
1. PostgreSQL cluster
1. PostgreSQL firewall
1. PostgreSQL database 

## Set up

```shell
$ brew install terraform
$ cd terraform/docn
$ terraform login
$ terraform init
$ terraform plan
$ terraform apply -auto-approve
```
