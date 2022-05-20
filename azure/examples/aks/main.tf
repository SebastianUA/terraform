#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.1.0"
    }
  }
}


provider "azurerm" {
  # Configuration options
}


module "base_resource_group" {
  source = "../../modules/base"

  enable_resource_group   = true
  resource_group_name     = "res-group"
  resource_group_location = "West Europe"

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

module "aks" {
  source = "../../modules/aks"

  enable_kubernetes_cluster              = true
  kubernetes_cluster_name                = "test-eks-1"
  kubernetes_cluster_location            = module.base_resource_group.resource_group_location
  kubernetes_cluster_resource_group_name = module.base_resource_group.resource_group_name
  kubernetes_cluster_dns_prefix          = "exampleaks1"
  kubernetes_cluster_oidc_issuer_enabled = true

  kubernetes_cluster_default_node_pool = {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  kubernetes_cluster_identity = {
    type = "SystemAssigned"
  }


  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]
}