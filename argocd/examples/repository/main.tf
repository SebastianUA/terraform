#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = ">= 0.13.0"

  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = "0.4.7"
    }
  }
}

provider "argocd" {
  server_addr = "argocd.local:443" # env ARGOCD_SERVER
  auth_token  = "1234..."          # env ARGOCD_AUTH_TOKEN
  # username  = "admin"            # env ARGOCD_AUTH_USERNAME
  # password  = "foo"              # env ARGOCD_AUTH_PASSWORD
  insecure = false # env ARGOCD_INSECURE
}

module "argocd_repository" {
  source = "../../modules/repository"

  enable_repository = true
  repository_repo   = "https://helm.nginx.com/stable"
  repository_name   = "nginx-stable"
  repository_type   = "helm"
}
