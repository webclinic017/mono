from diagrams import Cluster, Diagram, Edge
from diagrams.gcp.security import KeyManagementService
from diagrams.generic.device import Mobile
from diagrams.k8s.compute import Deploy
from diagrams.onprem.certificates import CertManager
from diagrams.onprem.certificates import LetsEncrypt
from diagrams.onprem.database import Postgresql
from diagrams.onprem.network import Consul
from diagrams.onprem.network import Nginx
from diagrams.onprem.security import Vault


with Diagram("System design", filename="system_design", outformat="png"):
    client = Mobile("Client")
    letsencrypt = LetsEncrypt("Let's Encrypt")
    
    with Cluster("DigitalOcean K8s Cluster"):
        certmanager = CertManager("Cert Manager")
        nginxlb = Nginx("Nginx Ingress LoadBalancer")
        consul = Consul("Consul")
        grpcsvcs = [
            Deploy("Service 1"),
            Deploy("Service 2")
        ]
        vault = Vault("Vault")
        
        letsencrypt >> certmanager >> nginxlb << consul >> grpcsvcs
        vault >> Edge() << grpcsvcs
    
    with Cluster("DigitalOcean Database Cluster"):
        primarydb = Postgresql("Primary")
        primarydb - Postgresql("Backup")
    
    with Cluster("GCP"):
        kms = KeyManagementService("Vault Unseal Keys")
    
    vault >> Edge() << kms
    vault >> Edge() << primarydb
    client >> nginxlb
