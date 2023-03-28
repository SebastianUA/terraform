#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "this"
}

variable "environment" {
  description = "Environment for service"
  default     = "test"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage account
#-----------------------------------------------------------
variable "enable_storage_account" {
  description = "Enable storage account usage"
  default     = false
}

variable "storage_account_name" {
  description = "Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  default     = ""
}

variable "storage_account_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
  default     = null
}

variable "storage_account_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "storage_account_account_tier" {
  description = "(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  default     = null
}

variable "storage_account_account_replication_type" {
  description = " (Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa."
  default     = null
}

variable "storage_account_account_kind" {
  description = "(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to StorageV2."
  default     = null
}

# variable "storage_account_cross_tenant_replication_enabled" {
#   description = "(Optional) Should cross Tenant replication be enabled? Defaults to true."
#   default     = null
# }

variable "storage_account_access_tier" {
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."
  default     = null
}

variable "storage_account_edge_zone" {
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
  default     = null
}

variable "storage_account_enable_https_traffic_only" {
  description = "(Optional) Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true"
  default     = null
}

variable "storage_account_min_tls_version" {
  description = "(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts."
  default     = null
}

variable "storage_account_allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true"
  default     = null
}

variable "storage_account_shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true"
  default     = null
}

variable "storage_account_is_hns_enabled" {
  description = "(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see here for more information). Changing this forces a new resource to be created."
  default     = null
}

variable "storage_account_nfsv3_enabled" {
  description = "(Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false"
  default     = null
}

variable "storage_account_large_file_share_enabled" {
  description = "(Optional) Is Large File Share Enabled?"
  default     = null
}

variable "storage_account_queue_encryption_key_type" {
  description = "(Optional) The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  default     = null
}

variable "storage_account_table_encryption_key_type" {
  description = "(Optional) The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  default     = null
}

variable "storage_account_infrastructure_encryption_enabled" {
  description = "(Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false"
  default     = null
}

variable "storage_account_custom_domain" {
  description = "(Optional) A custom_domain block"
  default     = {}
}

variable "storage_account_customer_managed_key" {
  description = "(Optional) A customer_managed_key block"
  default     = {}
}

variable "storage_account_identity" {
  description = "(Optional) An identity block"
  default     = {}
}

variable "storage_account_blob_properties" {
  description = "(Optional) A blob_properties block"
  default     = {}
}

variable "storage_account_queue_properties" {
  description = "(Optional) A queue_properties block"
  default     = {}
}

variable "storage_account_static_website" {
  description = "(Optional) A static_website block"
  default     = {}
}

variable "storage_account_share_properties" {
  description = "(Optional) A share_properties block"
  default     = {}
}

variable "storage_account_network_rules" {
  description = "(Optional) A network_rules block"
  default     = {}
}

variable "storage_account_azure_files_authentication" {
  description = "(Optional) A azure_files_authentication block"
  default     = {}
}

variable "storage_account_routing" {
  description = "(Optional) A routing block"
  default     = {}
}

variable "storage_account_timeouts" {
  description = "Set timeouts for storage account"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage account network rules
#-----------------------------------------------------------
variable "enable_storage_account_network_rules" {
  description = "Enable storage account network rules usage"
  default     = false
}

variable "storage_account_network_rules_default_action" {
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow"
  default     = null
}

variable "storage_account_network_rules_storage_account_id" {
  description = "Specifies the ID of the storage account. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_account_network_rules_bypass" {
  description = "(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  default     = null
}

variable "storage_account_network_rules_ip_rules" {
  description = "(Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed."
  default     = null
}

variable "storage_account_network_rules_virtual_network_subnet_ids" {
  description = "(Optional) A list of virtual network subnet ids to to secure the storage account."
  default     = null
}

variable "storage_account_network_rules_private_link_access" {
  description = "(Optional) One or More private_link_access block"
  default     = {}
}

variable "storage_account_network_rules_timeouts" {
  description = "Set timeouts for storage account network rules"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage account customer managed key
#-----------------------------------------------------------
variable "enable_storage_account_customer_managed_key" {
  description = "Enable storage account customer managed key usage"
  default     = false
}

variable "storage_account_customer_managed_key_storage_account_id" {
  description = "The ID of the Storage Account. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_account_customer_managed_key_key_vault_id" {
  description = "(Required) The ID of the Key Vault. Changing this forces a new resource to be created."
  default     = null
}

variable "storage_account_customer_managed_key_key_name" {
  description = "(Required) The name of Key Vault Key."
  default     = null
}

variable "storage_account_customer_managed_key_key_version" {
  description = "(Optional) The version of Key Vault Key. Remove or omit this argument to enable Automatic Key Rotation."
  default     = null
}

variable "storage_account_customer_managed_key_user_assigned_identity_id" {
  description = "(Optional) The ID of a user assigned identity."
  default     = null
}

variable "storage_account_customer_managed_key_timeouts" {
  description = "Set timeouts for storage account customer managed key"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage container
#-----------------------------------------------------------
variable "enable_storage_container" {
  description = "Enable storage container usage"
  default     = false
}

variable "storage_container_name" {
  description = "The name of the Container which should be created within the Storage Account."
  default     = false
}

variable "storage_container_storage_account_name" {
  description = "The name of the Storage Account where the Container should be created."
  default     = "examplestoraccount"
}

variable "storage_container_container_access_type" {
  description = "(Optional) The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private"
  default     = null
}

variable "storage_container_metadata" {
  description = "(Optional) A mapping of MetaData for this Container. All metadata keys should be lowercase."
  default     = null
}

variable "storage_container_timeouts" {
  description = "Set timeouts for storage container"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage blob
#-----------------------------------------------------------
variable "enable_storage_blob" {
  description = "Enable storage blob usage"
  default     = false
}

variable "storage_blob_name" {
  description = "(Required) The name of the storage blob. Must be unique within the storage container the blob is located."
  default     = null
}

variable "storage_blob_storage_account_name" {
  description = "Specifies the storage account in which to create the storage container. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_blob_storage_container_name" {
  description = "The name of the storage container in which this blob should be created."
  default     = ""
}

variable "storage_blob_type" {
  description = "(Required) The type of the storage blob to be created. Possible values are Append, Block or Page. Changing this forces a new resource to be created."
  default     = null
}

variable "storage_blob_size" {
  description = "(Optional) Used only for page blobs to specify the size in bytes of the blob to be created. Must be a multiple of 512. Defaults to 0."
  default     = null
}

variable "storage_blob_access_tier" {
  description = "(Optional) The access tier of the storage blob. Possible values are Archive, Cool and Hot."
  default     = null
}

variable "storage_blob_cache_control" {
  description = "(Optional) Controls the cache control header content of the response when blob is requested ."
  default     = null
}

variable "storage_blob_content_type" {
  description = "(Optional) The content type of the storage blob. Cannot be defined if source_uri is defined. Defaults to application/octet-stream."
  default     = null
}

variable "storage_blob_content_md5" {
  description = "(Optional) The MD5 sum of the blob contents. Cannot be defined if source_uri is defined, or if blob type is Append or Page. Changing this forces a new resource to be created."
  default     = null
}

variable "storage_blob_source" {
  description = "(Optional) An absolute path to a file on the local system. This field cannot be specified for Append blobs and cannot be specified if source_content or source_uri is specified."
  default     = null
}

variable "storage_blob_source_content" {
  description = "(Optional) The content for this blob which should be defined inline. This field can only be specified for Block blobs and cannot be specified if source or source_uri is specified."
  default     = null
}

variable "storage_blob_source_uri" {
  description = "(Optional) The URI of an existing blob, or a file in the Azure File service, to use as the source contents for the blob to be created. Changing this forces a new resource to be created. This field cannot be specified for Append blobs and cannot be specified if source or source_content is specified."
  default     = null
}

variable "storage_blob_parallelism" {
  description = "(Optional) The number of workers per CPU core to run for concurrent uploads. Defaults to 8"
  default     = null
}

variable "storage_blob_metadata" {
  description = "(Optional) A map of custom blob metadata."
  default     = null
}

variable "storage_blob_timeouts" {
  description = "Set timeouts for storage blob"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage blob inventory policy
#-----------------------------------------------------------
variable "enable_storage_blob_inventory_policy" {
  description = "Enable storage blob inventory policy usage"
  default     = false
}

variable "storage_blob_inventory_policy_storage_account_id" {
  description = "The ID of the storage account to apply this Blob Inventory Policy to. Changing this forces a new Storage Blob Inventory Policy to be created."
  default     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.Storage/storageAccounts/myaccount"
}

variable "storage_blob_inventory_policy_rules" {
  description = "(Required) One or more rules blocks"
  default     = []
}

variable "storage_blob_inventory_policy_timeouts" {
  description = "Set timeouts for storage blob inventory policy"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage data lake gen2 filesystem
#-----------------------------------------------------------
variable "enable_storage_data_lake_gen2_filesystem" {
  description = "Enable storage data lake gen2 filesystem usage"
  default     = false
}

variable "storage_data_lake_gen2_filesystem_name" {
  description = "The name of the Data Lake Gen2 File System which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_data_lake_gen2_filesystem_storage_account_id" {
  description = "Specifies the ID of the Storage Account in which the Data Lake Gen2 File System should exist. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_data_lake_gen2_filesystem_properties" {
  description = "(Optional) A mapping of Key to Base64-Encoded Values which should be assigned to this Data Lake Gen2 File System."
  default     = null
}

variable "storage_data_lake_gen2_filesystem_ace" {
  description = "(Optional) One or more ace blocks as defined below to specify the entries for the ACL for the path."
  default     = []
}

variable "storage_data_lake_gen2_filesystem_owner" {
  description = "(Optional) Specifies the Object ID of the Azure Active Directory User to make the owning user of the root path (i.e. /). Possible values also include $superuser."
  default     = null
}

variable "storage_data_lake_gen2_filesystem_group" {
  description = "(Optional) Specifies the Object ID of the Azure Active Directory Group to make the owning group of the root path (i.e. /). Possible values also include $superuser."
  default     = null
}

variable "storage_data_lake_gen2_filesystem_timeouts" {
  description = "Set timeouts for storage data lake gen2 filesystem"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage data lake gen2 path
#-----------------------------------------------------------
variable "enable_storage_data_lake_gen2_path" {
  description = "Enable storage data lake gen2 path usage"
  default     = false
}

variable "storage_data_lake_gen2_path_path" {
  description = "The path which should be created within the Data Lake Gen2 File System in the Storage Account. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_data_lake_gen2_path_filesystem_name" {
  description = "The name of the Data Lake Gen2 File System which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_data_lake_gen2_path_storage_account_id" {
  description = "Specifies the ID of the Storage Account in which the Data Lake Gen2 File System should exist. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_data_lake_gen2_path_resource" {
  description = "(Required) Specifies the type for path to create. Currently only directory is supported."
  default     = null
}

variable "storage_data_lake_gen2_path_owner" {
  description = "(Optional) Specifies the Object ID of the Azure Active Directory User to make the owning user. Possible values also include $superuser"
  default     = null
}

variable "storage_data_lake_gen2_path_group" {
  description = "(Optional) Specifies the Object ID of the Azure Active Directory Group to make the owning group. Possible values also include $superuser."
  default     = null
}

variable "storage_data_lake_gen2_path_ace" {
  description = "(Required) One or more ace blocks as defined below to specify the entries for the ACL for the path."
  default     = []
}

variable "storage_data_lake_gen2_path_timeouts" {
  description = "Set timeouts for storage data lake gen2 path"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage encryption scope
#-----------------------------------------------------------
variable "enable_storage_encryption_scope" {
  description = "Enable storage encryption scope usage"
  default     = false
}

variable "storage_encryption_scope_name" {
  description = "The name which should be used for this Storage Encryption Scope. Changing this forces a new Storage Encryption Scope to be created."
  default     = ""
}

variable "storage_encryption_scope_storage_account_id" {
  description = "The ID of the Storage Account where this Storage Encryption Scope is created. Changing this forces a new Storage Encryption Scope to be created."
  default     = ""
}

variable "storage_encryption_scope_source" {
  description = "(Required) The source of the Storage Encryption Scope. Possible values are Microsoft.KeyVault and Microsoft.Storage"
  default     = null
}

variable "storage_encryption_scope_infrastructure_encryption_required" {
  description = "(Optional) Is a secondary layer of encryption with Platform Managed Keys for data applied?"
  default     = null
}

variable "storage_encryption_scope_key_vault_key_ids" {
  description = "(Optional) The ID of the Key Vault Key. Required when source is Microsoft.KeyVault."
  default     = null
}

variable "storage_encryption_scope_timeouts" {
  description = "Set timeouts for storage encryption scope"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage queue
#-----------------------------------------------------------
variable "enable_storage_queue" {
  description = "Enable storage queue usage"
  default     = false
}

variable "storage_queue_name" {
  description = "The name of the Queue which should be created within the Storage Account. Must be unique within the storage account the queue is located."
  default     = ""
}

variable "storage_queue_storage_account_name" {
  description = "Specifies the Storage Account in which the Storage Queue should exist. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_queue_metadata" {
  description = "(Optional) A mapping of MetaData which should be assigned to this Storage Queue."
  default     = null
}

variable "storage_queue_timeouts" {
  description = "Set timeouts storage queue"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage object replication
#-----------------------------------------------------------
variable "enable_storage_object_replication" {
  description = "Enable storage object replication usage"
  default     = false
}

variable "storage_object_replication_source_storage_account_id" {
  description = "The ID of the source storage account. Changing this forces a new Storage Object Replication to be created."
  default     = ""
}

variable "storage_object_replication_destination_storage_account_id" {
  description = "(Required) The ID of the destination storage account. Changing this forces a new Storage Object Replication to be created."
  default     = null
}

variable "storage_object_replication_rules" {
  description = "(Required) One or more rules blocks"
  default     = []
}

variable "storage_object_replication_timeouts" {
  description = "Set timeouts for storage object replication"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage management policy
#-----------------------------------------------------------
variable "enable_storage_management_policy" {
  description = "Enable storage management policy usage"
  default     = false
}

variable "storage_management_policy_storage_account_id" {
  description = "Specifies the id of the storage account to apply the management policy to."
  default     = ""
}

variable "storage_management_policy_rule" {
  description = "(Optional) A rule blocks"
  default     = []
}

variable "storage_management_policy_timeouts" {
  description = "Set timeouts for storage management policy"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage table
#-----------------------------------------------------------
variable "enable_storage_table" {
  description = "Enable storage table usage"
  default     = false
}

variable "storage_table_name" {
  description = "The name of the storage table. Must be unique within the storage account the table is located."
  default     = ""
}

variable "storage_table_storage_account_name" {
  description = "Specifies the storage account in which to create the storage table. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_table_acl" {
  description = "(Optional) One or more acl blocks"
  default     = []
}

variable "storage_table_timeouts" {
  description = "Set timeouts for storage table"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage table entity
#-----------------------------------------------------------
variable "enable_storage_table_entity" {
  description = "Enable storage table entity usage"
  default     = false
}

variable "storage_table_entity_storage_account_name" {
  description = "Specifies the storage account in which to create the storage table entity. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_table_entity_table_name" {
  description = "The name of the storage table in which to create the storage table entity. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_table_entity_partition_key" {
  description = "(Required) The key for the partition where the entity will be inserted/merged. Changing this forces a new resource."
  default     = null
}

variable "storage_table_entity_row_key" {
  description = "(Required) The key for the row where the entity will be inserted/merged. Changing this forces a new resource."
  default     = null
}

variable "storage_table_entity_entity" {
  description = "(Required) A map of key/value pairs that describe the entity to be inserted/merged in to the storage table."
  default     = null
}

variable "storage_table_entity_timeouts" {
  description = "Set timeouts for storage table entity"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage share
#-----------------------------------------------------------
variable "enable_storage_share" {
  description = "Enable storage share usage"
  default     = false
}

variable "storage_share_name" {
  description = "The name of the share. Must be unique within the storage account where the share is located."
  default     = ""
}

variable "storage_share_storage_account_name" {
  description = "Specifies the storage account in which to create the share. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_share_quota" {
  description = "(Required) The maximum size of the share, in gigabytes. For Standard storage accounts, this must be 1GB (or higher) and at most 5120 GB (5 TB). For Premium FileStorage storage accounts, this must be greater than 100 GB and at most 102400 GB (100 TB)."
  default     = null
}

variable "storage_share_enabled_protocol" {
  description = "(Optional) The protocol used for the share. Possible values are SMB and NFS. The SMB indicates the share can be accessed by SMBv3.0, SMBv2.1 and REST. The NFS indicates the share can be accessed by NFSv4.1. Defaults to SMB. Changing this forces a new resource to be created."
  default     = null
}

variable "storage_share_metadata" {
  description = "(Optional) A mapping of MetaData for this File Share."
  default     = null
}

variable "storage_share_acl" {
  description = "(Optional) One or more acl blocks"
  default     = []
}

variable "storage_share_timeouts" {
  description = "Set timeouts for storage share"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage share file
#-----------------------------------------------------------
variable "enable_storage_share_file" {
  description = "Enable storage share file usage"
  default     = false
}

variable "storage_share_file_name" {
  description = "(Required) The name (or path) of the File that should be created within this File Share. Changing this forces a new resource to be created."
  default     = null
}

variable "storage_share_file_storage_share_id" {
  description = "The Storage Share ID in which this file will be placed into. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_share_file_source" {
  description = "(Optional) An absolute path to a file on the local system."
  default     = null
}

variable "storage_share_file_path" {
  description = "(Optional) The storage share directory that you would like the file placed into. Changing this forces a new resource to be created."
  default     = null
}

variable "storage_share_file_content_type" {
  description = "(Optional) The content type of the share file. Defaults to application/octet-stream."
  default     = null
}

variable "storage_share_file_content_md5" {
  description = "(Optional) The MD5 sum of the file contents. Changing this forces a new resource to be created."
  default     = null
}

variable "storage_share_file_content_encoding" {
  description = "(Optional) Specifies which content encodings have been applied to the file."
  default     = null
}

variable "storage_share_file_content_disposition" {
  description = "(Optional) Sets the file’s Content-Disposition header."
  default     = null
}

variable "storage_share_file_metadata" {
  description = "(Optional) A mapping of metadata to assign to this file."
  default     = null
}

variable "storage_share_file_timeouts" {
  description = "Set timeouts for storage share file"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage share directory
#-----------------------------------------------------------
variable "enable_storage_share_directory" {
  description = "Enable storage share directory usage"
  default     = false
}

variable "storage_share_directory_name" {
  description = "The name (or path) of the Directory that should be created within this File Share. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_share_directory_share_name" {
  description = "The name of the File Share where this Directory should be created. Changing this forces a new resource to be created."
  default     = ""
}

variable "storage_share_directory_storage_account_name" {
  description = "The name of the Storage Account within which the File Share is located. Changing this forces a new resource to be created"
  default     = ""
}

variable "storage_share_directory_metadata" {
  description = "(Optional) A mapping of metadata to assign to this Directory."
  default     = null
}

variable "storage_share_directory_timeouts" {
  description = "Set timeouts for storage share directory"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage sync
#-----------------------------------------------------------
variable "enable_storage_sync" {
  description = "Enable storage sync usage"
  default     = false
}

variable "storage_sync_name" {
  description = "The name which should be used for this Storage Sync. Changing this forces a new Storage Sync to be created."
  default     = ""
}

variable "storage_sync_resource_group_name" {
  description = "(Required) The name of the Resource Group where the Storage Sync should exist. Changing this forces a new Storage Sync to be created."
  default     = null
}

variable "storage_sync_location" {
  description = "(Required) The Azure Region where the Storage Sync should exist. Changing this forces a new Storage Sync to be created."
  default     = null
}

variable "storage_sync_incoming_traffic_policy" {
  description = "(Optional) Incoming traffic policy. Possible values are AllowAllTraffic and AllowVirtualNetworksOnly"
  default     = null
}

variable "storage_sync_timeouts" {
  description = "Set timeouts storage sync"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage sync group
#-----------------------------------------------------------
variable "enable_storage_sync_group" {
  description = "Enable storage sync group usage"
  default     = false
}

variable "storage_sync_group_name" {
  description = "The name which should be used for this Storage Sync Group. Changing this forces a new Storage Sync Group to be created."
  default     = ""
}

variable "storage_sync_group_storage_sync_id" {
  description = "The resource ID of the Storage Sync where this Storage Sync Group is. Changing this forces a new Storage Sync Group to be created."
  default     = ""
}

variable "storage_sync_group_timeouts" {
  description = "Set timeouts for storage sync group"
  default     = {}
}

#-----------------------------------------------------------
# Azure storage sync cloud endpoint
#-----------------------------------------------------------
variable "enable_storage_sync_cloud_endpoint" {
  description = "Enable storage sync cloud endpoint usage"
  default     = false
}

variable "storage_sync_cloud_endpoint_name" {
  description = "The name which should be used for this Storage Sync Cloud Endpoint. Changing this forces a new Storage Sync Cloud Endpoint to be created."
  default     = ""
}

variable "storage_sync_cloud_endpoint_storage_sync_group_id" {
  description = "The ID of the Storage Sync Group where this Cloud Endpoint should be created. Changing this forces a new Storage Sync Cloud Endpoint to be created."
  default     = ""
}

variable "storage_sync_cloud_endpoint_file_share_name" {
  description = "The Storage Share name to be synchronized in this Storage Sync Cloud Endpoint. Changing this forces a new Storage Sync Cloud Endpoint to be created."
  default     = ""
}

variable "storage_sync_cloud_endpoint_storage_account_id" {
  description = "The ID of the Storage Account where the Storage Share exists. Changing this forces a new Storage Sync Cloud Endpoint to be created."
  default     = ""
}

variable "storage_sync_cloud_endpoint_storage_account_tenant_id" {
  description = "(Optional) The Tenant ID of the Storage Account where the Storage Share exists. Changing this forces a new Storage Sync Cloud Endpoint to be created. Defaults to the current tenant id."
  default     = null
}

variable "storage_sync_cloud_endpoint_timeouts" {
  description = "Set timeouts for storage sync group"
  default     = {}
}
