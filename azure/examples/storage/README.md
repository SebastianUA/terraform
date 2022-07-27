# Work with STORAGE via terraform

A terraform module for making STORAGE.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

  storage_account_name                     = "my-storage-account"
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
  enable_storage_blob          = true
  storage_blob_name            = "my-storage-blob.zip"
  storage_blob_storage_account = module.storage_account.storage_account_id
  storage_blob_type            = "Block"

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
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_storage_account` - Enable storage account usage (`default = False`)
- `storage_account_name` - Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group. (`default = ""`)
- `storage_account_resource_group_name` - (Required) The name of the resource group in which to create the storage account. Changing this forces a new resource to be created. (`default = null`)
- `storage_account_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `storage_account_account_tier` - (Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. (`default = null`)
- `storage_account_account_replication_type` -  (Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa. (`default = null`)
- `storage_account_account_kind` - (Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to StorageV2. (`default = null`)
- `storage_account_cross_tenant_replication_enabled` - (Optional) Should cross Tenant replication be enabled? Defaults to true. (`default = null`)
- `storage_account_access_tier` - (Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot. (`default = null`)
- `storage_account_edge_zone` - (Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created. (`default = null`)
- `storage_account_enable_https_traffic_only` - (Optional) Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true (`default = null`)
- `storage_account_min_tls_version` - (Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts. (`default = null`)
- `storage_account_allow_nested_items_to_be_public` - Allow or disallow nested items within this Account to opt into being public. Defaults to true (`default = null`)
- `storage_account_shared_access_key_enabled` - Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true (`default = null`)
- `storage_account_is_hns_enabled` - (Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see here for more information). Changing this forces a new resource to be created. (`default = null`)
- `storage_account_nfsv3_enabled` - (Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false (`default = null`)
- `storage_account_large_file_share_enabled` - (Optional) Is Large File Share Enabled? (`default = null`)
- `storage_account_queue_encryption_key_type` - (Optional) The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service. (`default = null`)
- `storage_account_table_encryption_key_type` - (Optional) The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service. (`default = null`)
- `storage_account_infrastructure_encryption_enabled` - (Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false (`default = null`)
- `storage_account_custom_domain` - (Optional) A custom_domain block (`default = {}`)
- `storage_account_customer_managed_key` - (Optional) A customer_managed_key block (`default = {}`)
- `storage_account_identity` - (Optional) An identity block (`default = {}`)
- `storage_account_blob_properties` - (Optional) A blob_properties block (`default = {}`)
- `storage_account_queue_properties` - (Optional) A queue_properties block (`default = {}`)
- `storage_account_static_website` - (Optional) A static_website block (`default = {}`)
- `storage_account_share_properties` - (Optional) A share_properties block (`default = {}`)
- `storage_account_network_rules` - (Optional) A network_rules block (`default = {}`)
- `storage_account_azure_files_authentication` - (Optional) A azure_files_authentication block (`default = {}`)
- `storage_account_routing` - (Optional) A routing block (`default = {}`)
- `storage_account_timeouts` - Set timeouts for storage account (`default = {}`)
- `enable_storage_account_network_rules` - Enable storage account network rules usage (`default = False`)
- `storage_account_network_rules_default_action` - Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow (`default = null`)
- `storage_account_network_rules_storage_account_id` - Specifies the ID of the storage account. Changing this forces a new resource to be created. (`default = ""`)
- `storage_account_network_rules_bypass` - (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None. (`default = null`)
- `storage_account_network_rules_ip_rules` - (Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed. (`default = null`)
- `storage_account_network_rules_virtual_network_subnet_ids` - (Optional) A list of virtual network subnet ids to to secure the storage account. (`default = null`)
- `storage_account_network_rules_private_link_access` - (Optional) One or More private_link_access block (`default = {}`)
- `storage_account_network_rules_timeouts` - Set timeouts for storage account network rules (`default = {}`)
- `enable_storage_account_customer_managed_key` - Enable storage account customer managed key usage (`default = False`)
- `storage_account_customer_managed_key_storage_account_id` - The ID of the Storage Account. Changing this forces a new resource to be created. (`default = ""`)
- `storage_account_customer_managed_key_key_vault_id` - (Required) The ID of the Key Vault. Changing this forces a new resource to be created. (`default = null`)
- `storage_account_customer_managed_key_key_name` - (Required) The name of Key Vault Key. (`default = null`)
- `storage_account_customer_managed_key_key_version` - (Optional) The version of Key Vault Key. Remove or omit this argument to enable Automatic Key Rotation. (`default = null`)
- `storage_account_customer_managed_key_user_assigned_identity_id` - (Optional) The ID of a user assigned identity. (`default = null`)
- `storage_account_customer_managed_key_timeouts` - Set timeouts for storage account customer managed key (`default = {}`)
- `enable_storage_container` - Enable storage container usage (`default = False`)
- `storage_container_name` - The name of the Container which should be created within the Storage Account. (`default = False`)
- `storage_container_storage_account_name` - The name of the Storage Account where the Container should be created. (`default = ""`)
- `storage_container_container_access_type` - (Optional) The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private (`default = null`)
- `storage_container_metadata` - (Optional) A mapping of MetaData for this Container. All metadata keys should be lowercase. (`default = null`)
- `storage_container_timeouts` - Set timeouts for storage container (`default = {}`)
- `enable_storage_blob` - Enable storage blob usage (`default = False`)
- `storage_blob_name` - (Required) The name of the storage blob. Must be unique within the storage container the blob is located. (`default = null`)
- `storage_blob_storage_account_name` - Specifies the storage account in which to create the storage container. Changing this forces a new resource to be created. (`default = ""`)
- `storage_blob_storage_container_name` - The name of the storage container in which this blob should be created. (`default = ""`)
- `storage_blob_type` - (Required) The type of the storage blob to be created. Possible values are Append, Block or Page. Changing this forces a new resource to be created. (`default = null`)
- `storage_blob_size` - (Optional) Used only for page blobs to specify the size in bytes of the blob to be created. Must be a multiple of 512. Defaults to 0. (`default = null`)
- `storage_blob_access_tier` - (Optional) The access tier of the storage blob. Possible values are Archive, Cool and Hot. (`default = null`)
- `storage_blob_cache_control` - (Optional) Controls the cache control header content of the response when blob is requested . (`default = null`)
- `storage_blob_content_type` - (Optional) The content type of the storage blob. Cannot be defined if source_uri is defined. Defaults to application/octet-stream. (`default = null`)
- `storage_blob_content_md5` - (Optional) The MD5 sum of the blob contents. Cannot be defined if source_uri is defined, or if blob type is Append or Page. Changing this forces a new resource to be created. (`default = null`)
- `storage_blob_source` - (Optional) An absolute path to a file on the local system. This field cannot be specified for Append blobs and cannot be specified if source_content or source_uri is specified. (`default = null`)
- `storage_blob_source_content` - (Optional) The content for this blob which should be defined inline. This field can only be specified for Block blobs and cannot be specified if source or source_uri is specified. (`default = null`)
- `storage_blob_source_uri` - (Optional) The URI of an existing blob, or a file in the Azure File service, to use as the source contents for the blob to be created. Changing this forces a new resource to be created. This field cannot be specified for Append blobs and cannot be specified if source or source_content is specified. (`default = null`)
- `storage_blob_parallelism` - (Optional) The number of workers per CPU core to run for concurrent uploads. Defaults to 8 (`default = null`)
- `storage_blob_metadata` - (Optional) A map of custom blob metadata. (`default = null`)
- `storage_blob_timeouts` - Set timeouts for storage blob (`default = {}`)
- `enable_storage_blob_inventory_policy` - Enable storage blob inventory policy usage (`default = False`)
- `storage_blob_inventory_policy_storage_account_id` - The ID of the storage account to apply this Blob Inventory Policy to. Changing this forces a new Storage Blob Inventory Policy to be created. (`default = ""`)
- `storage_blob_inventory_policy_rules` - (Required) One or more rules blocks (`default = []`)
- `storage_blob_inventory_policy_timeouts` - Set timeouts for storage blob inventory policy (`default = {}`)
- `enable_storage_data_lake_gen2_filesystem` - Enable storage data lake gen2 filesystem usage (`default = False`)
- `storage_data_lake_gen2_filesystem_name` - The name of the Data Lake Gen2 File System which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created. (`default = ""`)
- `storage_data_lake_gen2_filesystem_storage_account_id` - Specifies the ID of the Storage Account in which the Data Lake Gen2 File System should exist. Changing this forces a new resource to be created. (`default = ""`)
- `storage_data_lake_gen2_filesystem_properties` - (Optional) A mapping of Key to Base64-Encoded Values which should be assigned to this Data Lake Gen2 File System. (`default = null`)
- `storage_data_lake_gen2_filesystem_ace` - (Optional) One or more ace blocks as defined below to specify the entries for the ACL for the path. (`default = []`)
- `storage_data_lake_gen2_filesystem_owner` - (Optional) Specifies the Object ID of the Azure Active Directory User to make the owning user of the root path (i.e. /). Possible values also include $superuser. (`default = null`)
- `storage_data_lake_gen2_filesystem_group` - (Optional) Specifies the Object ID of the Azure Active Directory Group to make the owning group of the root path (i.e. /). Possible values also include $superuser. (`default = null`)
- `storage_data_lake_gen2_filesystem_timeouts` - Set timeouts for storage data lake gen2 filesystem (`default = {}`)
- `enable_storage_data_lake_gen2_path` - Enable storage data lake gen2 path usage (`default = False`)
- `storage_data_lake_gen2_path_path` - The path which should be created within the Data Lake Gen2 File System in the Storage Account. Changing this forces a new resource to be created. (`default = ""`)
- `storage_data_lake_gen2_path_filesystem_name` - The name of the Data Lake Gen2 File System which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created. (`default = ""`)
- `storage_data_lake_gen2_path_storage_account_id` - Specifies the ID of the Storage Account in which the Data Lake Gen2 File System should exist. Changing this forces a new resource to be created. (`default = ""`)
- `storage_data_lake_gen2_path_resource` - (Required) Specifies the type for path to create. Currently only directory is supported. (`default = null`)
- `storage_data_lake_gen2_path_owner` - (Optional) Specifies the Object ID of the Azure Active Directory User to make the owning user. Possible values also include $superuser (`default = null`)
- `storage_data_lake_gen2_path_group` - (Optional) Specifies the Object ID of the Azure Active Directory Group to make the owning group. Possible values also include $superuser. (`default = null`)
- `storage_data_lake_gen2_path_ace` - (Required) One or more ace blocks as defined below to specify the entries for the ACL for the path. (`default = []`)
- `storage_data_lake_gen2_path_timeouts` - Set timeouts for storage data lake gen2 path (`default = {}`)
- `enable_storage_encryption_scope` - Enable storage encryption scope usage (`default = False`)
- `storage_encryption_scope_name` - The name which should be used for this Storage Encryption Scope. Changing this forces a new Storage Encryption Scope to be created. (`default = ""`)
- `storage_encryption_scope_storage_account_id` - The ID of the Storage Account where this Storage Encryption Scope is created. Changing this forces a new Storage Encryption Scope to be created. (`default = ""`)
- `storage_encryption_scope_source` - (Required) The source of the Storage Encryption Scope. Possible values are Microsoft.KeyVault and Microsoft.Storage (`default = null`)
- `storage_encryption_scope_infrastructure_encryption_required` - (Optional) Is a secondary layer of encryption with Platform Managed Keys for data applied? (`default = null`)
- `storage_encryption_scope_key_vault_key_ids` - (Optional) The ID of the Key Vault Key. Required when source is Microsoft.KeyVault. (`default = null`)
- `storage_encryption_scope_timeouts` - Set timeouts for storage encryption scope (`default = {}`)
- `enable_storage_queue` - Enable storage queue usage (`default = False`)
- `storage_queue_name` - The name of the Queue which should be created within the Storage Account. Must be unique within the storage account the queue is located. (`default = ""`)
- `storage_queue_storage_account_name` - Specifies the Storage Account in which the Storage Queue should exist. Changing this forces a new resource to be created. (`default = ""`)
- `storage_queue_metadata` - (Optional) A mapping of MetaData which should be assigned to this Storage Queue. (`default = null`)
- `storage_queue_timeouts` - Set timeouts storage queue (`default = {}`)
- `enable_storage_object_replication` - Enable storage object replication usage (`default = False`)
- `storage_object_replication_source_storage_account_id` - The ID of the source storage account. Changing this forces a new Storage Object Replication to be created. (`default = ""`)
- `storage_object_replication_destination_storage_account_id` - (Required) The ID of the destination storage account. Changing this forces a new Storage Object Replication to be created. (`default = null`)
- `storage_object_replication_rules` - (Required) One or more rules blocks (`default = []`)
- `storage_object_replication_timeouts` - Set timeouts for storage object replication (`default = {}`)
- `enable_storage_management_policy` - Enable storage management policy usage (`default = False`)
- `storage_management_policy_storage_account_id` - Specifies the id of the storage account to apply the management policy to. (`default = ""`)
- `storage_management_policy_rule` - (Optional) A rule blocks (`default = []`)
- `storage_management_policy_timeouts` - Set timeouts for storage management policy (`default = {}`)
- `enable_storage_table` - Enable storage table usage (`default = False`)
- `storage_table_name` - The name of the storage table. Must be unique within the storage account the table is located. (`default = ""`)
- `storage_table_storage_account_name` - Specifies the storage account in which to create the storage table. Changing this forces a new resource to be created. (`default = ""`)
- `storage_table_acl` - (Optional) One or more acl blocks (`default = []`)
- `storage_table_timeouts` - Set timeouts for storage table (`default = {}`)
- `enable_storage_table_entity` - Enable storage table entity usage (`default = False`)
- `storage_table_entity_storage_account_name` - Specifies the storage account in which to create the storage table entity. Changing this forces a new resource to be created. (`default = ""`)
- `storage_table_entity_table_name` - The name of the storage table in which to create the storage table entity. Changing this forces a new resource to be created. (`default = ""`)
- `storage_table_entity_partition_key` - (Required) The key for the partition where the entity will be inserted/merged. Changing this forces a new resource. (`default = null`)
- `storage_table_entity_row_key` - (Required) The key for the row where the entity will be inserted/merged. Changing this forces a new resource. (`default = null`)
- `storage_table_entity_entity` - (Required) A map of key/value pairs that describe the entity to be inserted/merged in to the storage table. (`default = null`)
- `storage_table_entity_timeouts` - Set timeouts for storage table entity (`default = {}`)
- `enable_storage_share` - Enable storage share usage (`default = False`)
- `storage_share_name` - The name of the share. Must be unique within the storage account where the share is located. (`default = ""`)
- `storage_share_storage_account_name` - Specifies the storage account in which to create the share. Changing this forces a new resource to be created. (`default = ""`)
- `storage_share_quota` - (Required) The maximum size of the share, in gigabytes. For Standard storage accounts, this must be 1GB (or higher) and at most 5120 GB (5 TB). For Premium FileStorage storage accounts, this must be greater than 100 GB and at most 102400 GB (100 TB). (`default = null`)
- `storage_share_enabled_protocol` - (Optional) The protocol used for the share. Possible values are SMB and NFS. The SMB indicates the share can be accessed by SMBv3.0, SMBv2.1 and REST. The NFS indicates the share can be accessed by NFSv4.1. Defaults to SMB. Changing this forces a new resource to be created. (`default = null`)
- `storage_share_metadata` - (Optional) A mapping of MetaData for this File Share. (`default = null`)
- `storage_share_acl` - (Optional) One or more acl blocks (`default = []`)
- `storage_share_timeouts` - Set timeouts for storage share (`default = {}`)
- `enable_storage_share_file` - Enable storage share file usage (`default = False`)
- `storage_share_file_name` - (Required) The name (or path) of the File that should be created within this File Share. Changing this forces a new resource to be created. (`default = null`)
- `storage_share_file_storage_share_id` - The Storage Share ID in which this file will be placed into. Changing this forces a new resource to be created. (`default = ""`)
- `storage_share_file_source` - (Optional) An absolute path to a file on the local system. (`default = null`)
- `storage_share_file_path` - (Optional) The storage share directory that you would like the file placed into. Changing this forces a new resource to be created. (`default = null`)
- `storage_share_file_content_type` - (Optional) The content type of the share file. Defaults to application/octet-stream. (`default = null`)
- `storage_share_file_content_md5` - (Optional) The MD5 sum of the file contents. Changing this forces a new resource to be created. (`default = null`)
- `storage_share_file_content_encoding` - (Optional) Specifies which content encodings have been applied to the file. (`default = null`)
- `storage_share_file_content_disposition` - (Optional) Sets the file’s Content-Disposition header. (`default = null`)
- `storage_share_file_metadata` - (Optional) A mapping of metadata to assign to this file. (`default = null`)
- `storage_share_file_timeouts` - Set timeouts for storage share file (`default = {}`)
- `enable_storage_share_directory` - Enable storage share directory usage (`default = False`)
- `storage_share_directory_name` - The name (or path) of the Directory that should be created within this File Share. Changing this forces a new resource to be created. (`default = ""`)
- `storage_share_directory_share_name` - The name of the File Share where this Directory should be created. Changing this forces a new resource to be created. (`default = ""`)
- `storage_share_directory_storage_account_name` - The name of the Storage Account within which the File Share is located. Changing this forces a new resource to be created (`default = ""`)
- `storage_share_directory_metadata` - (Optional) A mapping of metadata to assign to this Directory. (`default = null`)
- `storage_share_directory_timeouts` - Set timeouts for storage share directory (`default = {}`)
- `enable_storage_sync` - Enable storage sync usage (`default = False`)
- `storage_sync_name` - The name which should be used for this Storage Sync. Changing this forces a new Storage Sync to be created. (`default = ""`)
- `storage_sync_resource_group_name` - (Required) The name of the Resource Group where the Storage Sync should exist. Changing this forces a new Storage Sync to be created. (`default = null`)
- `storage_sync_location` - (Required) The Azure Region where the Storage Sync should exist. Changing this forces a new Storage Sync to be created. (`default = null`)
- `storage_sync_incoming_traffic_policy` - (Optional) Incoming traffic policy. Possible values are AllowAllTraffic and AllowVirtualNetworksOnly (`default = null`)
- `storage_sync_timeouts` - Set timeouts storage sync (`default = {}`)
- `enable_storage_sync_group` - Enable storage sync group usage (`default = False`)
- `storage_sync_group_name` - The name which should be used for this Storage Sync Group. Changing this forces a new Storage Sync Group to be created. (`default = ""`)
- `storage_sync_group_storage_sync_id` - The resource ID of the Storage Sync where this Storage Sync Group is. Changing this forces a new Storage Sync Group to be created. (`default = ""`)
- `storage_sync_group_timeouts` - Set timeouts for storage sync group (`default = {}`)
- `enable_storage_sync_cloud_endpoint` - Enable storage sync cloud endpoint usage (`default = False`)
- `storage_sync_cloud_endpoint_name` - The name which should be used for this Storage Sync Cloud Endpoint. Changing this forces a new Storage Sync Cloud Endpoint to be created. (`default = ""`)
- `storage_sync_cloud_endpoint_storage_sync_group_id` - The ID of the Storage Sync Group where this Cloud Endpoint should be created. Changing this forces a new Storage Sync Cloud Endpoint to be created. (`default = ""`)
- `storage_sync_cloud_endpoint_file_share_name` - The Storage Share name to be synchronized in this Storage Sync Cloud Endpoint. Changing this forces a new Storage Sync Cloud Endpoint to be created. (`default = ""`)
- `storage_sync_cloud_endpoint_storage_account_id` - The ID of the Storage Account where the Storage Share exists. Changing this forces a new Storage Sync Cloud Endpoint to be created. (`default = ""`)
- `storage_sync_cloud_endpoint_storage_account_tenant_id` - (Optional) The Tenant ID of the Storage Account where the Storage Share exists. Changing this forces a new Storage Sync Cloud Endpoint to be created. Defaults to the current tenant id. (`default = null`)
- `storage_sync_group_timeouts` - Set timeouts for storage sync group (`default = {}`)

## Module Output Variables
----------------------
- `storage_account_id` - The ID of the Storage Account.
- `storage_account_name` - The name of the Storage Account.
- `storage_account_primary_location` - The primary location of the storage account.
- `storage_account_secondary_location` - The secondary location of the storage account.
- `storage_account_primary_blob_endpoint` - The endpoint URL for blob storage in the primary location.
- `storage_account_primary_blob_host` - The hostname with port if applicable for blob storage in the primary location.
- `storage_account_secondary_blob_endpoint` - The endpoint URL for blob storage in the secondary location.
- `storage_account_secondary_blob_host` - The hostname with port if applicable for blob storage in the secondary location.
- `storage_account_primary_queue_endpoint` - The endpoint URL for queue storage in the primary location.
- `storage_account_primary_queue_host` - The hostname with port if applicable for queue storage in the primary location.
- `storage_account_secondary_queue_endpoint` - The endpoint URL for queue storage in the secondary location.
- `storage_account_secondary_queue_host` - The hostname with port if applicable for queue storage in the secondary location.
- `storage_account_primary_table_endpoint` - The endpoint URL for table storage in the primary location.
- `storage_account_primary_table_host` - The hostname with port if applicable for table storage in the primary location.
- `storage_account_secondary_table_endpoint` - The endpoint URL for table storage in the secondary location.
- `storage_account_secondary_table_host` - The hostname with port if applicable for table storage in the secondary location.
- `storage_account_primary_file_endpoint` - The endpoint URL for file storage in the primary location.
- `storage_account_primary_file_host` - The hostname with port if applicable for file storage in the primary location.
- `storage_account_secondary_file_endpoint` - The endpoint URL for file storage in the secondary location.
- `storage_account_secondary_file_host` - The hostname with port if applicable for file storage in the secondary location.
- `storage_account_primary_dfs_endpoint` - The endpoint URL for DFS storage in the primary location.
- `storage_account_primary_dfs_host` - The hostname with port if applicable for DFS storage in the primary location.
- `storage_account_secondary_dfs_endpoint` - The endpoint URL for DFS storage in the secondary location.
- `storage_account_secondary_dfs_host` - The hostname with port if applicable for DFS storage in the secondary location.
- `storage_account_primary_web_endpoint` - The endpoint URL for web storage in the primary location.
- `storage_account_primary_web_host` - The hostname with port if applicable for web storage in the primary location.
- `storage_account_secondary_web_endpoint` - The endpoint URL for web storage in the secondary location.
- `storage_account_secondary_web_host` - The hostname with port if applicable for web storage in the secondary location.
- `storage_account_primary_access_key` - The primary access key for the storage account.
- `storage_account_secondary_access_key` - The secondary access key for the storage account.
- `storage_account_primary_connection_string` - The connection string associated with the primary location.
- `storage_account_secondary_connection_string` - The connection string associated with the secondary location.
- `storage_account_primary_blob_connection_string` - The connection string associated with the primary blob location.
- `storage_account_secondary_blob_connection_string` - The connection string associated with the secondary blob location.
- `storage_account_network_rules_id` - The ID of the Storage Account.
- `storage_account_customer_managed_key_id` - The ID of the Storage Account.
- `storage_container_id` - The ID of the Storage Container.
- `storage_container_has_immutability_policy` - Is there an Immutability Policy configured on this Storage Container?
- `storage_container_has_legal_hold` - Is there a Legal Hold configured on this Storage Container?
- `storage_container_resource_manager_id` - The Resource Manager ID of this Storage Container.
- `storage_blob_id` - The ID of the Storage Blob.
- `storage_blob_url` - The URL of the blob
- `storage_blob_inventory_policy_id` - The ID of the Storage Blob Inventory Policy.
- `storage_data_lake_gen2_filesystem_id` - The ID of the Data Lake Gen2 File System.
- `storage_data_lake_gen2_filesystem_name` - The name of the Data Lake Gen2 File System.
- `storage_data_lake_gen2_path_id` - The ID of the Data Lake Gen2 File System.
- `storage_encryption_scope_id` - The ID of the Storage Encryption Scope.
- `storage_queue_id` - The ID of the Storage Queue.
- `storage_object_replication_id` - The ID of the Storage Object Replication in the destination storage account. It's composed as format source_object_replication_id;destination_object_replication_id.
- `storage_object_replication_source_object_replication_id` - The ID of the Object Replication in the source storage account.
- `storage_object_replication_destination_object_replication_id` - The ID of the Object Replication in the destination storage account.
- `storage_management_policy_id` - The ID of the Storage Account Management Policy.
- `storage_table_id` - The ID of the Table within the Storage Account.
- `storage_table_name` - The name of the Table within the Storage Account.
- `storage_table_entity_id` - The ID of the Entity within the Table in the Storage Account.
- `storage_share_id` - The ID of the File Share.
- `storage_share_resource_manager_id` - The Resource Manager ID of this File Share.
- `storage_share_url` - The URL of the File Share
- `storage_share_file_id` - The ID of the File Share.
- `storage_share_file_resource_manager_id` - The Resource Manager ID of this File Share.
- `storage_share_file_url` - The URL of the File Share
- `storage_share_directory_id` - The ID of the Directory within the File Share.
- `storage_share_directory_id` - The ID of the Directory within the File Share.
- `storage_sync_id` - The ID of the Storage Sync.
- `storage_sync_group_id` - The ID of the Storage Sync Group.
- `storage_sync_cloud_endpoint_id` - The ID of the Storage Sync Cloud Endpoint.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
