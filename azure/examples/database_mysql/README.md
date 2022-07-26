# Work with DATABASE_MYSQL via terraform

A terraform module for making DATABASE_MYSQL.


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
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_mysql_active_directory_administrator` - Enable mysql active directory administrator usage (`default = False`)
- `mysql_active_directory_administrator_server_name` - The name of the MySQL Server on which to set the administrator. Changing this forces a new resource to be created. (`default = null`)
- `mysql_active_directory_administrator_resource_group_name` - (Required) The name of the resource group for the MySQL server. Changing this forces a new resource to be created. (`default = null`)
- `mysql_active_directory_administrator_login` - (Required) The login name of the principal to set as the server administrator (`default = null`)
- `mysql_active_directory_administrator_object_id` - (Required) The ID of the principal to set as the server administrator. For a managed identity this should be the Client ID of the identity. (`default = null`)
- `mysql_active_directory_administrator_tenant_id` - (Required) The Azure Tenant ID (`default = null`)
- `mysql_active_directory_administrator_timeouts` - Set timeouts for mysql active directory administrator (`default = {}`)
- `enable_mysql_configuration` - Enable mysql configuration usage (`default = False`)
- `mysql_configuration_server_name` - Specifies the name of the MySQL Server. Changing this forces a new resource to be created. (`default = ""`)
- `mysql_configuration_resource_group_name` - (Required) The name of the resource group in which the MySQL Server exists. Changing this forces a new resource to be created. (`default = null`)
- `mysql_configuration_parameters` - Set key/value parameters for MySQL (`default = []`)
- `mysql_configuration_timeouts` - Set timeouts for mysql configuration (`default = {}`)
- `enable_mysql_server` - Enable mysql server usage (`default = False`)
- `mysql_server_name` - Specifies the name of the MySQL Server. Changing this forces a new resource to be created. This needs to be globally unique within Azure. (`default = ""`)
- `mysql_server_resource_group_name` - (Required) The name of the resource group in which to create the MySQL Server. Changing this forces a new resource to be created. (`default = null`)
- `mysql_server_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `mysql_server_sku_name` - (Required) Specifies the SKU Name for this MySQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8). For more information see the product documentation. (`default = null`)
- `mysql_server_version` - (Required) Specifies the version of MySQL to use. Valid values are 5.7, or 8.0. Changing this forces a new resource to be created. (`default = null`)
- `mysql_server_administrator_login` - (Optional) The Administrator login for the MySQL Server. Required when create_mode is Default. Changing this forces a new resource to be created. (`default = null`)
- `mysql_server_administrator_login_password` - (Optional) The Password associated with the administrator_login for the MySQL Server. Required when create_mode is Default. (`default = null`)
- `mysql_server_auto_grow_enabled` - (Optional) Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true (`default = null`)
- `mysql_server_backup_retention_days` - (Optional) Backup retention days for the server, supported values are between 7 and 35 days (`default = null`)
- `mysql_server_restore_point_in_time` - (Optional) When create_mode is PointInTimeRestore, specifies the point in time to restore from creation_source_server_id (`default = null`)
- `mysql_server_geo_redundant_backup_enabled` - (Optional) Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier. (`default = null`)
- `mysql_server_create_mode` - (Optional) The creation mode. Can be used to restore or replicate existing servers. Possible values are Default, Replica, GeoRestore, and PointInTimeRestore. Defaults to Default. (`default = null`)
- `mysql_server_creation_source_server_id` - (Optional) For creation modes other than Default, the source server ID to use. (`default = null`)
- `mysql_server_public_network_access_enabled` - (Optional) Whether or not public network access is allowed for this server. Defaults to true (`default = null`)
- `mysql_server_infrastructure_encryption_enabled` - (Optional) Whether or not infrastructure is encrypted for this server. Defaults to false. Changing this forces a new resource to be created. (`default = null`)
- `mysql_server_ssl_enforcement_enabled` - (Required) Specifies if SSL should be enforced on connections. Possible values are true and false. (`default = null`)
- `mysql_server_ssl_minimal_tls_version_enforced` - (Optional) The minimum TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2. (`default = null`)
- `mysql_server_storage_mb` - (Required) Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 16777216 MB(16TB) for General Purpose/Memory Optimized SKUs. For more information see the product documentation. (`default = null`)
- `mysql_server_identity` - (Optional) An identity block (`default = {}`)
- `mysql_server_threat_detection_policy` - Optional) Threat detection policy configuration, known in the API as Server Security Alerts Policy. (`default = {}`)
- `mysql_server_timeouts` - Set timeouts for mysql server (`default = {}`)
- `enable_mysql_server_key` - Enable mysql server key usage (`default = False`)
- `mysql_server_key_server_id` - The ID of the MySQL Server. Changing this forces a new resource to be created. (`default = ""`)
- `mysql_server_key_key_vault_key_id` - (Required) The URL to a Key Vault Key. (`default = null`)
- `mysql_server_key_timeouts` - Set timeouts for mysql server key (`default = {}`)
- `enable_mysql_database` - Enable mysql database usage (`default = False`)
- `mysql_database_name` - Specifies the name of the MySQL Database, which needs to be a valid MySQL identifier. Changing this forces a new resource to be created. (`default = ""`)
- `mysql_database_server_name` - Specifies the name of the MySQL Server. Changing this forces a new resource to be created. (`default = null`)
- `mysql_database_resource_group_name` - (Required) The name of the resource group in which the MySQL Server exists. Changing this forces a new resource to be created. (`default = null`)
- `mysql_database_charset` - (Required) Specifies the Charset for the MySQL Database, which needs to be a valid MySQL Charset. Changing this forces a new resource to be created. (`default = null`)
- `mysql_database_collation` - (Required) Specifies the Collation for the MySQL Database, which needs to be a valid MySQL Collation. Changing this forces a new resource to be created. (`default = null`)
- `mysql_database_timeouts` - Set timeouts for mysql database (`default = {}`)
- `enable_mysql_virtual_network_rule` - Enable mysql virtual network rule usage (`default = False`)
- `mysql_virtual_network_rule_name` - The name of the MySQL Virtual Network Rule. Cannot be empty and must only contain alphanumeric characters and hyphens. Cannot start with a number, and cannot start or end with a hyphen. Changing this forces a new resource to be created. (`default = ""`)
- `mysql_virtual_network_rule_resource_group_name` - (Required) The name of the resource group where the MySQL server resides. Changing this forces a new resource to be created. (`default = null`)
- `mysql_virtual_network_rule_server_name` - The name of the SQL Server to which this MySQL virtual network rule will be applied to. Changing this forces a new resource to be created. (`default = ""`)
- `mysql_virtual_network_rule_subnet_id` - (Required) The ID of the subnet that the MySQL server will be connected to. (`default = null`)
- `mysql_virtual_network_rule_timeouts` - Set timeouts for mysql virtual network rule (`default = {}`)
- `enable_mysql_firewall_rule` - Enable mysql firewall rule usage (`default = False`)
- `mysql_firewall_rule_server_name` - Specifies the name of the MySQL Server. Changing this forces a new resource to be created. (`default = ""`)
- `mysql_firewall_rule_resource_group_name` - (Required) The name of the resource group in which the MySQL Server exists. Changing this forces a new resource to be created. (`default = null`)
- `mysql_firewall_rule_properties` - Set list with key/values that includes (name, start_ip_address, end_ip_address) (`default = []`)
- `mysql_firewall_rule_timeouts` - Set timeouts for mysql firewall rule (`default = {}`)
- `enable_mysql_flexible_server` - Enable mysql flexible server usage (`default = False`)
- `mysql_flexible_server_name` - The name which should be used for this MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created. (`default = ""`)
- `mysql_flexible_server_resource_group_name` - (Required) The name of the Resource Group where the MySQL Flexible Server should exist. Changing this forces a new MySQL Flexible Server to be created. (`default = null`)
- `mysql_flexible_server_location` - (Required) The Azure Region where the MySQL Flexible Server should exist. Changing this forces a new MySQL Flexible Server to be created. (`default = null`)
- `mysql_flexible_server_administrator_login` - (Optional) The Administrator login for the MySQL Flexible Server. Required when create_mode is Default. Changing this forces a new MySQL Flexible Server to be created. (`default = null`)
- `mysql_flexible_server_administrator_password` - (Optional) The Password associated with the administrator_login for the MySQL Flexible Server. Required when create_mode is Default. (`default = null`)
- `mysql_flexible_server_create_mode` - (Optional)The creation mode which can be used to restore or replicate existing servers. Possible values are Default, PointInTimeRestore, GeoRestore, and Replica. Changing this forces a new MySQL Flexible Server to be created. (`default = null`)
- `mysql_flexible_server_backup_retention_days` - (Optional) The backup retention days for the MySQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 7 (`default = null`)
- `mysql_flexible_server_geo_redundant_backup_enabled` - (Optional) Should geo redundant backup enabled? Defaults to false. Changing this forces a new MySQL Flexible Server to be created. (`default = null`)
- `mysql_flexible_server_point_in_time_restore_time_in_utc` - (Optional) The point in time to restore from creation_source_server_id when create_mode is PointInTimeRestore. Changing this forces a new MySQL Flexible Server to be created. (`default = null`)
- `mysql_flexible_server_replication_role` - The replication role. Possible value is None. (`default = null`)
- `mysql_flexible_server_delegated_subnet_id` - (Optional) The ID of the virtual network subnet to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created. (`default = null`)
- `mysql_flexible_server_source_server_id` - (Optional)The resource ID of the source MySQL Flexible Server to be restored. Required when create_mode is PointInTimeRestore, GeoRestore, and Replica. Changing this forces a new MySQL Flexible Server to be created. (`default = null`)
- `mysql_flexible_server_sku_name` - (Optional) The SKU Name for the MySQL Flexible Server. (`default = null`)
- `mysql_flexible_server_version` - (Optional) The version of the MySQL Flexible Server to use. Possible values are 5.7, and 8.0.21. Changing this forces a new MySQL Flexible Server to be created. (`default = null`)
- `mysql_flexible_server_private_dns_zone_id` - (Optional) The ID of the private DNS zone to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created. (`default = null`)
- `mysql_flexible_server_zone` - (Optional) Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2 and 3. (`default = null`)
- `mysql_flexible_server_high_availability` - (Optional) A high_availability block (`default = {}`)
- `mysql_flexible_server_maintenance_window` - (Optional) A maintenance_window block (`default = {}`)
- `mysql_flexible_server_storage` - (Optional) A storage block (`default = {}`)
- `mysql_flexible_server_timeouts` - Set timeouts for mysql flexible server (`default = {}`)
- `enable_mysql_flexible_server_firewall_rule` - Enable mysql flexible server firewall rule usage (`default = False`)
- `mysql_flexible_server_firewall_rule_name` - Specifies the name of the MySQL Firewall Rule. Changing this forces a new resource to be created. (`default = ""`)
- `mysql_flexible_server_firewall_rule_server_name` - Specifies the name of the MySQL Flexible Server. Changing this forces a new resource to be created. (`default = ""`)
- `mysql_flexible_server_firewall_rule_resource_group_name` - (Required) The name of the resource group in which the MySQL Flexible Server exists. Changing this forces a new resource to be created. (`default = null`)
- `mysql_flexible_server_firewall_rule_start_ip_address` - (Required) Specifies the Start IP Address associated with this Firewall Rule. Changing this forces a new resource to be created. (`default = null`)
- `mysql_flexible_server_firewall_rule_end_ip_address` - (Required) Specifies the End IP Address associated with this Firewall Rule. Changing this forces a new resource to be created. (`default = null`)
- `mysql_flexible_server_firewall_rule_timeouts` - Set timeouts for mysql flexible server firewall rule (`default = {}`)
- `enable_mysql_flexible_server_configuration` - Enable mysql flexible_server configuration usage (`default = False`)
- `mysql_flexible_server_configuration_resource_group_name` - (Required) The name of the resource group in which the MySQL Flexible Server exists. Changing this forces a new resource to be created. (`default = null`)
- `mysql_flexible_server_configuration_server_name` - Specifies the name of the MySQL Flexible Server. Changing this forces a new resource to be created. (`default = ""`)
- `mysql_flexible_server_configuration_parameters` - Set list with key/value params (`default = []`)
- `mysql_flexible_server_configuration_timeouts` - Set timeouts for mysql flexible server configuration (`default = {}`)
- `enable_mysql_flexible_database` - Enable mysql flexible database usage (`default = False`)
- `mysql_flexible_database_name` - Specifies the name of the MySQL Database, which needs to be a valid MySQL identifier. Changing this forces a new resource to be created. (`default = ""`)
- `mysql_flexible_database_server_name` - Specifies the name of the MySQL Flexible Server. Changing this forces a new resource to be created. (`default = ""`)
- `mysql_flexible_database_resource_group_name` - (Required) The name of the resource group in which the MySQL Server exists. Changing this forces a new resource to be created. (`default = null`)
- `mysql_flexible_database_charset` - (Required) Specifies the Charset for the MySQL Database, which needs to be a valid MySQL Charset. Changing this forces a new resource to be created. (`default = null`)
- `mysql_flexible_database_collation` - (Required) Specifies the Collation for the MySQL Database, which needs to be a valid MySQL Collation. Changing this forces a new resource to be created. (`default = null`)
- `mysql_flexible_database_timeouts` - Set timeouts for mysql flexible database (`default = {}`)

## Module Output Variables
----------------------
- `mysql_active_directory_administrator_id` - The ID of the MySQL Active Directory Administrator.
- `mysql_configuration_id` - The ID of the MySQL Configuration.
- `mysql_server_id` - The ID of the MySQL Server.
- `mysql_server_name` - The name of the MySQL Server.
- `mysql_server_fqdn` - The FQDN of the MySQL Server.
- `mysql_server_identity` - The identity (principal_id, tenant_id) of the MySQL Server.
- `mysql_server_key_id` - The ID of the MySQL Server Key.
- `mysql_database_id` - The ID of the MySQL Database.
- `mysql_virtual_network_rule_id` - The ID of the MySQL Virtual Network Rule.
- `mysql_firewall_rule_id` - The ID of the MySQL Firewall Rule.
- `mysql_flexible_server_id` - The ID of the MySQL Flexible Server.
- `mysql_flexible_server_name` - The name of the flexible MySQL Server.
- `mysql_flexible_server_fqdn` - The fully qualified domain name of the MySQL Flexible Server.
- `mysql_flexible_server_public_network_access_enabled` - Is the public network access enabled?
- `mysql_flexible_server_replica_capacity` - The maximum number of replicas that a primary MySQL Flexible Server can have.
- `mysql_flexible_server_firewall_rule_id` - The ID of the MySQL Firewall Rule.
- `mysql_flexible_server_configuration_id` - The ID of the MySQL Flexible Server Configuration.
- `mysql_flexible_database_id` - The ID of the MySQL Database.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
