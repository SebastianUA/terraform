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

module "storage_account" {
  source = "../../modules/storage"

  // Enable storage account
  enable_storage_account = true

  storage_account_name                     = "mystorageaccount"
  storage_account_location                 = module.base_resource_group.resource_group_location
  storage_account_resource_group_name      = module.base_resource_group.resource_group_name
  storage_account_account_tier             = "Standard"
  storage_account_account_replication_type = "GRS"

  // Enable storage account network rules
  enable_storage_account_network_rules         = true
  storage_account_network_rules_default_action = "Allow"

  storage_account_network_rules_bypass                     = ["Metrics"]
  storage_account_network_rules_ip_rules                   = ["127.0.0.1"]
  storage_account_network_rules_virtual_network_subnet_ids = []

  // Enable storage account customer managed key
  enable_storage_account_customer_managed_key       = false
  storage_account_customer_managed_key_key_vault_id = ""
  storage_account_customer_managed_key_key_name     = ""

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]
}

module "storage_blob" {
  source = "../../modules/storage"

  // Enable storage container
  enable_storage_container                = true
  storage_container_name                  = "vhds"
  storage_container_container_access_type = "private"

  // Enable storage blob
  enable_storage_blob               = true
  storage_blob_name                 = "my-storage-blob.zip"
  storage_blob_storage_account_name = module.storage_account.storage_account_id
  storage_blob_type                 = "Block"

  storage_blob_source = "some-local-file.zip"

  // Enable storage blob inventory policy
  enable_storage_blob_inventory_policy = true

  storage_blob_inventory_policy_rules = [
    {
      name     = "rule1"
      format   = "Csv"
      schedule = "Daily"
      scope    = "Container"
      schema_fields = [
        "Name",
        "Last-Modified",
      ]
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

module "storage_share" {
  source = "../../modules/storage"

  // Enable storage share
  enable_storage_share = true

  storage_share_name                 = "my-storage-share"
  storage_share_storage_account_name = module.storage_account.storage_account_id
  storage_share_quota                = 50

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]
}

module "storage_sync" {
  source = "../../modules/storage"

  // Enable storage sync
  enable_storage_sync = true

  storage_sync_name                = "my-storage-sync"
  storage_sync_location            = module.base_resource_group.resource_group_location
  storage_sync_resource_group_name = module.base_resource_group.resource_group_name

  // Enable storage sync group
  enable_storage_sync_group = true
  storage_sync_group_name   = "my-storage-sync-group"

  // Enable storage sync cloud endpoint
  enable_storage_sync_cloud_endpoint             = true
  storage_sync_cloud_endpoint_name               = "my-storage-sync-cloud-endpoint"
  storage_sync_cloud_endpoint_file_share_name    = module.storage_share.storage_share_id
  storage_sync_cloud_endpoint_storage_account_id = module.storage_account.storage_account_id

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]
}

module "storage_container" {
  source = "../../modules/storage"

  // Enable storage container
  enable_storage_container               = true
  storage_container_name                 = "vhds"
  storage_container_storage_account_name = "examplestoraccount" # module.storage_account.storage_account_id

  storage_container_container_access_type = "private"

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.storage_account
  ]
}
