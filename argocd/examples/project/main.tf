#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = ">= 0.13.0"

  required_providers {
    argocd = {
      source = "oboukili/argocd"

    }
  }
}

provider "argocd" {
  server_addr = "argocd.local:443"
  auth_token  = "1234..."
}

module "argocd_project" {
  source = "../../modules/project"

}
