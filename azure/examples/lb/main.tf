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

module "lb" {
  source = "../../modules/lb"

  // LB
  enable_lb              = true
  lb_name                = ""
  lb_location            = module.base_resource_group.resource_group_location
  lb_resource_group_name = module.base_resource_group.resource_group_name

  lb_frontend_ip_configuration = [
    {
      name                 = "PublicIPAddress"
      public_ip_address_id = "public_ip_address_id_here"
    }
  ]

  // LB rule
  enabne_lb_rule                         = true
  lb_rule_name                           = ""
  lb_rule_frontend_ip_configuration_name = "PublicIPAddress"
  lb_rule_protocol                       = "Tcp"
  lb_rule_frontend_port                  = 3389
  lb_rule_backend_port                   = 3389

  // LB probe
  enable_lb_probe = true
  lb_probe_name   = ""
  lb_probe_port   = 22

  // LB nat rule
  enable_lb_nat_rule                         = true
  lb_nat_rule_name                           = ""
  lb_nat_rule_resource_group_name            = module.base_resource_group.resource_group_name
  lb_nat_rule_frontend_ip_configuration_name = "PublicIPAddress"
  lb_nat_rule_protocol                       = "Tcp"
  lb_nat_rule_frontend_port                  = 3389
  lb_nat_rule_backend_port                   = 3389

  // LB nat pool
  enable_lb_nat_pool                         = true
  lb_nat_pool_name                           = ""
  lb_nat_pool_resource_group_name            = module.base_resource_group.resource_group_name
  lb_nat_pool_frontend_ip_configuration_name = "PublicIPAddress"
  lb_nat_pool_protocol                       = "Tcp"
  lb_nat_pool_frontend_port_start            = 80
  lb_nat_pool_frontend_port_end              = 81
  lb_nat_pool_backend_port                   = 3389

  // LB backend address pool
  enable_lb_backend_address_pool = true
  lb_backend_address_pool_name   = ""

  // LB lb backend address pool address
  enable_lb_backend_address_pool_address             = true
  lb_backend_address_pool_address_name               = ""
  lb_backend_address_pool_address_virtual_network_id = "virt_net_id_here"
  lb_backend_address_pool_address_ip_address         = "10.0.0.1"

  // LB outbound rule
  enable_lb_outbound_rule   = true
  lb_outbound_rule_name     = ""
  lb_outbound_rule_protocol = "Tcp"
  // lb_outbound_rule_backend_address_pool_id = ""

  lb_outbound_rule_frontend_ip_configuration = [
    {
      name = "PublicIPAddress"
    }
  ]


  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]
}