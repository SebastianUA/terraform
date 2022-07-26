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
# Azure mysql active directory administrator
#-----------------------------------------------------------
variable "enable_mysql_active_directory_administrator" {
  description = "Enable mysql active directory administrator usage"
  default     = false
}

variable "mysql_active_directory_administrator_server_name" {
  description = "The name of the MySQL Server on which to set the administrator. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_active_directory_administrator_resource_group_name" {
  description = "(Required) The name of the resource group for the MySQL server. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_active_directory_administrator_login" {
  description = "(Required) The login name of the principal to set as the server administrator"
  default     = null
}

variable "mysql_active_directory_administrator_object_id" {
  description = "(Required) The ID of the principal to set as the server administrator. For a managed identity this should be the Client ID of the identity."
  default     = null
}

variable "mysql_active_directory_administrator_tenant_id" {
  description = "(Required) The Azure Tenant ID"
  default     = null
}

variable "mysql_active_directory_administrator_timeouts" {
  description = "Set timeouts for mysql active directory administrator"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql configuration
#-----------------------------------------------------------
variable "enable_mysql_configuration" {
  description = "Enable mysql configuration usage"
  default     = false
}

variable "mysql_configuration_server_name" {
  description = "Specifies the name of the MySQL Server. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_configuration_resource_group_name" {
  description = "(Required) The name of the resource group in which the MySQL Server exists. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_configuration_parameters" {
  description = "Set key/value parameters for MySQL"
  default     = []
}

variable "mysql_configuration_timeouts" {
  description = "Set timeouts for mysql configuration"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql server
#-----------------------------------------------------------
variable "enable_mysql_server" {
  description = "Enable mysql server usage"
  default     = false
}

variable "mysql_server_name" {
  description = "Specifies the name of the MySQL Server. Changing this forces a new resource to be created. This needs to be globally unique within Azure."
  default     = ""
}

variable "mysql_server_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the MySQL Server. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_server_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_server_sku_name" {
  description = "(Required) Specifies the SKU Name for this MySQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8). For more information see the product documentation."
  default     = null
}

variable "mysql_server_version" {
  description = "(Required) Specifies the version of MySQL to use. Valid values are 5.7, or 8.0. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_server_administrator_login" {
  description = "(Optional) The Administrator login for the MySQL Server. Required when create_mode is Default. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_server_administrator_login_password" {
  description = "(Optional) The Password associated with the administrator_login for the MySQL Server. Required when create_mode is Default."
  default     = null
}

variable "mysql_server_auto_grow_enabled" {
  description = "(Optional) Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true"
  default     = null
}

variable "mysql_server_backup_retention_days" {
  description = "(Optional) Backup retention days for the server, supported values are between 7 and 35 days"
  default     = null
}

variable "mysql_server_restore_point_in_time" {
  description = "(Optional) When create_mode is PointInTimeRestore, specifies the point in time to restore from creation_source_server_id"
  default     = null
}

variable "mysql_server_geo_redundant_backup_enabled" {
  description = "(Optional) Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier."
  default     = null
}

variable "mysql_server_create_mode" {
  description = "(Optional) The creation mode. Can be used to restore or replicate existing servers. Possible values are Default, Replica, GeoRestore, and PointInTimeRestore. Defaults to Default."
  default     = null
}

variable "mysql_server_creation_source_server_id" {
  description = "(Optional) For creation modes other than Default, the source server ID to use."
  default     = null
}

variable "mysql_server_public_network_access_enabled" {
  description = "(Optional) Whether or not public network access is allowed for this server. Defaults to true"
  default     = null
}

variable "mysql_server_infrastructure_encryption_enabled" {
  description = "(Optional) Whether or not infrastructure is encrypted for this server. Defaults to false. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_server_ssl_enforcement_enabled" {
  description = "(Required) Specifies if SSL should be enforced on connections. Possible values are true and false."
  default     = null
}

variable "mysql_server_ssl_minimal_tls_version_enforced" {
  description = "(Optional) The minimum TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2."
  default     = null
}

variable "mysql_server_storage_mb" {
  description = "(Required) Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 16777216 MB(16TB) for General Purpose/Memory Optimized SKUs. For more information see the product documentation."
  default     = null
}

variable "mysql_server_identity" {
  description = "(Optional) An identity block"
  default     = {}
}

variable "mysql_server_threat_detection_policy" {
  description = "Optional) Threat detection policy configuration, known in the API as Server Security Alerts Policy."
  default     = {}
}

variable "mysql_server_timeouts" {
  description = "Set timeouts for mysql server"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql server key
#-----------------------------------------------------------
variable "enable_mysql_server_key" {
  description = "Enable mysql server key usage"
  default     = false
}

variable "mysql_server_key_server_id" {
  description = "The ID of the MySQL Server. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_server_key_key_vault_key_id" {
  description = "(Required) The URL to a Key Vault Key."
  default     = null
}

variable "mysql_server_key_timeouts" {
  description = "Set timeouts for mysql server key"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql database
#-----------------------------------------------------------
variable "enable_mysql_database" {
  description = "Enable mysql database usage"
  default     = false
}

variable "mysql_database_name" {
  description = "Specifies the name of the MySQL Database, which needs to be a valid MySQL identifier. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_database_server_name" {
  description = "Specifies the name of the MySQL Server. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_database_resource_group_name" {
  description = "(Required) The name of the resource group in which the MySQL Server exists. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_database_charset" {
  description = "(Required) Specifies the Charset for the MySQL Database, which needs to be a valid MySQL Charset. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_database_collation" {
  description = "(Required) Specifies the Collation for the MySQL Database, which needs to be a valid MySQL Collation. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_database_timeouts" {
  description = "Set timeouts for mysql database"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql virtual network rule
#-----------------------------------------------------------
variable "enable_mysql_virtual_network_rule" {
  description = "Enable mysql virtual network rule usage"
  default     = false
}

variable "mysql_virtual_network_rule_name" {
  description = "The name of the MySQL Virtual Network Rule. Cannot be empty and must only contain alphanumeric characters and hyphens. Cannot start with a number, and cannot start or end with a hyphen. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_virtual_network_rule_resource_group_name" {
  description = "(Required) The name of the resource group where the MySQL server resides. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_virtual_network_rule_server_name" {
  description = "The name of the SQL Server to which this MySQL virtual network rule will be applied to. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_virtual_network_rule_subnet_id" {
  description = "(Required) The ID of the subnet that the MySQL server will be connected to."
  default     = null
}

variable "mysql_virtual_network_rule_timeouts" {
  description = "Set timeouts for mysql virtual network rule"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql firewall rule
#-----------------------------------------------------------
variable "enable_mysql_firewall_rule" {
  description = "Enable mysql firewall rule usage"
  default     = false
}

variable "mysql_firewall_rule_server_name" {
  description = "Specifies the name of the MySQL Server. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_firewall_rule_resource_group_name" {
  description = "(Required) The name of the resource group in which the MySQL Server exists. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_firewall_rule_properties" {
  description = "Set list with key/values that includes (name, start_ip_address, end_ip_address)"
  default     = []
}

variable "mysql_firewall_rule_timeouts" {
  description = "Set timeouts for mysql firewall rule"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql flexible server
#-----------------------------------------------------------
variable "enable_mysql_flexible_server" {
  description = "Enable mysql flexible server usage"
  default     = false
}

variable "mysql_flexible_server_name" {
  description = "The name which should be used for this MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created."
  default     = ""
}

variable "mysql_flexible_server_resource_group_name" {
  description = "(Required) The name of the Resource Group where the MySQL Flexible Server should exist. Changing this forces a new MySQL Flexible Server to be created."
  default     = null
}

variable "mysql_flexible_server_location" {
  description = "(Required) The Azure Region where the MySQL Flexible Server should exist. Changing this forces a new MySQL Flexible Server to be created."
  default     = null
}

variable "mysql_flexible_server_administrator_login" {
  description = "(Optional) The Administrator login for the MySQL Flexible Server. Required when create_mode is Default. Changing this forces a new MySQL Flexible Server to be created."
  default     = null
}

variable "mysql_flexible_server_administrator_password" {
  description = "(Optional) The Password associated with the administrator_login for the MySQL Flexible Server. Required when create_mode is Default."
  default     = null
}

variable "mysql_flexible_server_create_mode" {
  description = "(Optional)The creation mode which can be used to restore or replicate existing servers. Possible values are Default, PointInTimeRestore, GeoRestore, and Replica. Changing this forces a new MySQL Flexible Server to be created."
  default     = null
}

variable "mysql_flexible_server_backup_retention_days" {
  description = "(Optional) The backup retention days for the MySQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 7"
  default     = null
}

variable "mysql_flexible_server_geo_redundant_backup_enabled" {
  description = "(Optional) Should geo redundant backup enabled? Defaults to false. Changing this forces a new MySQL Flexible Server to be created."
  default     = null
}

variable "mysql_flexible_server_point_in_time_restore_time_in_utc" {
  description = "(Optional) The point in time to restore from creation_source_server_id when create_mode is PointInTimeRestore. Changing this forces a new MySQL Flexible Server to be created."
  default     = null
}

variable "mysql_flexible_server_replication_role" {
  description = "The replication role. Possible value is None."
  default     = null
}

variable "mysql_flexible_server_delegated_subnet_id" {
  description = "(Optional) The ID of the virtual network subnet to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created."
  default     = null
}

variable "mysql_flexible_server_source_server_id" {
  description = "(Optional)The resource ID of the source MySQL Flexible Server to be restored. Required when create_mode is PointInTimeRestore, GeoRestore, and Replica. Changing this forces a new MySQL Flexible Server to be created."
  default     = null
}

variable "mysql_flexible_server_sku_name" {
  description = "(Optional) The SKU Name for the MySQL Flexible Server."
  default     = null
}

variable "mysql_flexible_server_version" {
  description = "(Optional) The version of the MySQL Flexible Server to use. Possible values are 5.7, and 8.0.21. Changing this forces a new MySQL Flexible Server to be created."
  default     = null
}

variable "mysql_flexible_server_private_dns_zone_id" {
  description = "(Optional) The ID of the private DNS zone to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created."
  default     = null
}

variable "mysql_flexible_server_zone" {
  description = "(Optional) Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2 and 3."
  default     = null
}

variable "mysql_flexible_server_high_availability" {
  description = "(Optional) A high_availability block"
  default     = {}
}

variable "mysql_flexible_server_maintenance_window" {
  description = "(Optional) A maintenance_window block"
  default     = {}
}

variable "mysql_flexible_server_storage" {
  description = "(Optional) A storage block"
  default     = {}
}

variable "mysql_flexible_server_timeouts" {
  description = "Set timeouts for mysql flexible server"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql flexible server firewall rule
#-----------------------------------------------------------
variable "enable_mysql_flexible_server_firewall_rule" {
  description = "Enable mysql flexible server firewall rule usage"
  default     = false
}

variable "mysql_flexible_server_firewall_rule_name" {
  description = "Specifies the name of the MySQL Firewall Rule. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_flexible_server_firewall_rule_server_name" {
  description = "Specifies the name of the MySQL Flexible Server. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_flexible_server_firewall_rule_resource_group_name" {
  description = "(Required) The name of the resource group in which the MySQL Flexible Server exists. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_flexible_server_firewall_rule_start_ip_address" {
  description = "(Required) Specifies the Start IP Address associated with this Firewall Rule. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_flexible_server_firewall_rule_end_ip_address" {
  description = "(Required) Specifies the End IP Address associated with this Firewall Rule. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_flexible_server_firewall_rule_timeouts" {
  description = "Set timeouts for mysql flexible server firewall rule"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql flexible server configuration
#-----------------------------------------------------------
variable "enable_mysql_flexible_server_configuration" {
  description = "Enable mysql flexible_server configuration usage"
  default     = false
}

variable "mysql_flexible_server_configuration_resource_group_name" {
  description = "(Required) The name of the resource group in which the MySQL Flexible Server exists. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_flexible_server_configuration_server_name" {
  description = "Specifies the name of the MySQL Flexible Server. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_flexible_server_configuration_parameters" {
  description = "Set list with key/value params"
  default     = []
}

variable "mysql_flexible_server_configuration_timeouts" {
  description = "Set timeouts for mysql flexible server configuration"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql flexible database
#-----------------------------------------------------------
variable "enable_mysql_flexible_database" {
  description = "Enable mysql flexible database usage"
  default     = false
}

variable "mysql_flexible_database_name" {
  description = "Specifies the name of the MySQL Database, which needs to be a valid MySQL identifier. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_flexible_database_server_name" {
  description = "Specifies the name of the MySQL Flexible Server. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_flexible_database_resource_group_name" {
  description = "(Required) The name of the resource group in which the MySQL Server exists. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_flexible_database_charset" {
  description = "(Required) Specifies the Charset for the MySQL Database, which needs to be a valid MySQL Charset. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_flexible_database_collation" {
  description = "(Required) Specifies the Collation for the MySQL Database, which needs to be a valid MySQL Collation. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_flexible_database_timeouts" {
  description = "Set timeouts for mysql flexible database"
  default     = {}
}