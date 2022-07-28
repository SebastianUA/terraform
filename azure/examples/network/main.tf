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

module "network_sg" {
  source = "../../modules/network"

  // Enable Network SG
  enable_network_security_group              = true
  network_security_group_name                = "my-sg"
  network_security_group_location            = module.base_resource_group.resource_group_location
  network_security_group_resource_group_name = module.base_resource_group.resource_group_name

  network_security_group_security_rule = [
    {
      name      = "test123"
      protocol  = "Tcp"
      access    = "Allow"
      priority  = 100
      direction = "Inbound"


      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
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

module "virtual_network" {
  source = "../../modules/network"

  // Enable Network SG
  enable_virtual_network              = true
  virtual_network_name                = "my-virtual-network"
  virtual_network_location            = module.base_resource_group.resource_group_location
  virtual_network_resource_group_name = module.base_resource_group.resource_group_name

  virtual_network_dns_servers   = []
  virtual_network_address_space = ["10.0.0.0/16"]
  virtual_network_subnet = [
    {
      # name           = 
      address_prefix = "10.0.1.0/24"
      security_group = module.network_sg.network_security_group_id
    },
    {
      # name           = 
      address_prefix = "10.0.2.0/24"
    }
  ]

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group,
    module.network_sg
  ]
}