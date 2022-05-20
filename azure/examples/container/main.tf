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

module "container" {
  source = "../../modules/container"

  enable_container_group              = true
  container_group_name                = "test-1"
  container_group_location            = module.base_resource_group.resource_group_location
  container_group_resource_group_name = module.base_resource_group.resource_group_name
  container_group_os_type             = "Linux"
  container_group_ip_address_type     = "public"
  container_group_dns_name_label      = "aci-label"

  container_group_container = [
    {
      name   = "hello-world"
      image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
      cpu    = "0.5"
      memory = "1.5"

      ports = [
        {
          port     = 443
          protocol = "TCP"
        }
      ]
    }
  ]

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}