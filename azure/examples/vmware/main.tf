#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.1.0"
    }
  }
}

provider "azurerm" {
  # The AzureRM Provider supports authenticating using via the Azure CLI, a Managed Identity
  # and a Service Principal. More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure

  # The features block allows changing the behaviour of the Azure Provider, more
  # information can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
  features {}

  // subscription_id = ""
  // tenant_id       = ""
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

module "vmware" {
  source = "../../modules/vmware"

  // Azure vmware private cloud
  enable_vmware_private_cloud              = true
  vmware_private_cloud_name                = "vmware-private-cloud"
  vmware_private_cloud_location            = module.base_resource_group.resource_group_location
  vmware_private_cloud_resource_group_name = module.base_resource_group.resource_group_name

  vmware_private_cloud_network_subnet_cidr = "192.168.48.0/22"
  vmware_private_cloud_sku_name            = "av36"
  vmware_private_cloud_management_cluster = {
    size = 3
  }

  vmware_private_cloud_internet_connection_enabled = false
  vmware_private_cloud_nsxt_password               = "QazWsx13$Edc"
  vmware_private_cloud_vcenter_password            = "WsxEdc23$Rfv"

  // Azure vmware cluster
  enable_vmware_cluster             = true
  vmware_cluster_name               = "vmware-cluster-1"
  vmware_cluster_cluster_node_count = 3
  vmware_cluster_sku_name           = "av36"

  // Azure vmware express route authorization
  enable_vmware_express_route_authorization = true
  vmware_express_route_authorization_name   = "vmware-express-route-authorization"

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]

}