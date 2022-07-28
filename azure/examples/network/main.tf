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

  // Enable virtual network
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
      address_prefix = "10.0.2.0/24"
    },
    {
      name           = "temp"
      address_prefix = "10.0.3.0/24"
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

module "subnet" {
  source = "../../modules/network"

  // Enable subnet
  enable_subnet               = true
  subnet_name                 = "my-subnet"
  subnet_resource_group_name  = module.base_resource_group.resource_group_name
  subnet_virtual_network_name = module.virtual_network.virtual_network_id
  subnet_address_prefixes     = ["10.0.4.0/24"]

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group,
    module.virtual_network
  ]
}

module "public_ip" {
  source = "../../modules/network"

  // Enable Network SG
  enable_public_ip              = true
  public_ip_name                = "my-public-ip"
  public_ip_location            = module.base_resource_group.resource_group_location
  public_ip_resource_group_name = module.base_resource_group.resource_group_name
  public_ip_allocation_method   = "Static"

  public_ip_ip_version = "IPv4"
  public_ip_sku        = null
  public_ip_sku_tier   = null

  public_ip_ip_tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]
}

module "bastion_host" {
  source = "../../modules/network"

  // Enable bastion host
  enable_bastion_host              = true
  bastion_host_name                = "my-public-ip"
  bastion_host_location            = module.base_resource_group.resource_group_location
  bastion_host_resource_group_name = module.base_resource_group.resource_group_name

  bastion_host_ip_configuration = {
    name                 = "configuration"
    subnet_id            = module.subnet.subnet_id
    public_ip_address_id = module.public_ip.public_ip_id
  }

  bastion_host_sku         = null
  bastion_host_scale_units = null

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group,
    module.public_ip
  ]
}