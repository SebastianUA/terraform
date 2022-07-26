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

module "database_mysql" {
  source = "../../modules/database_mysql"

  // Enable MySQL server
  enable_mysql_server = true

  mysql_server_name                = "my-server-mysql"
  mysql_server_location            = module.base_resource_group.resource_group_location
  mysql_server_resource_group_name = module.base_resource_group.resource_group_name

  mysql_server_administrator_login          = "root"
  mysql_server_administrator_login_password = "H@Sh1CoR3!"

  mysql_server_sku_name   = "B_Gen5_2"
  mysql_server_storage_mb = 1024
  mysql_server_version    = "5.7"

  mysql_server_auto_grow_enabled                 = true
  mysql_server_backup_retention_days             = 7
  mysql_server_geo_redundant_backup_enabled      = false
  mysql_server_infrastructure_encryption_enabled = false
  mysql_server_public_network_access_enabled     = true
  mysql_server_ssl_enforcement_enabled           = true
  mysql_server_ssl_minimal_tls_version_enforced  = "TLS1_2"

  // Enable MySQL configuration
  enable_mysql_configuration              = true
  mysql_configuration_resource_group_name = module.base_resource_group.resource_group_name
  mysql_configuration_parameters = [
    {
      name  = "binlog_row_image"
      value = "FULL"
    }
  ]

  // Enable MySQL DB
  mysql_database_name                = "exampledb"
  mysql_database_resource_group_name = module.base_resource_group.resource_group_name
  mysql_database_charset             = "utf8"
  mysql_database_collation           = "utf8_unicode_ci"

  // Enable MySQL firewall rule
  enable_mysql_firewall_rule              = true
  mysql_firewall_rule_resource_group_name = module.base_resource_group.resource_group_name
  mysql_firewall_rule_properties = [
    {
      name             = "Allow-all"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "255.255.255.255"
    }
  ]

  // Enable MySQL virtual network rule
  enable_mysql_virtual_network_rule              = true
  mysql_virtual_network_rule_name                = "my-server-mysql"
  mysql_virtual_network_rule_resource_group_name = module.base_resource_group.resource_group_name
  mysql_virtual_network_rule_subnet_id           = data.azurerm_subnet.vnet.id


  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet
data "azurerm_subnet" "vnet" {
  name                 = "vnet-subnet-default"
  virtual_network_name = "vnet"
  resource_group_name  = module.base_resource_group.resource_group_name
}