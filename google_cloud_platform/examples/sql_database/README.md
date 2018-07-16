# Work with Google Cloud  Platform (SQL database) via terraform

A terraform module for making sql database.
 
## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "google" {
    credentials = "${file("/Users/captain/.config/gcloud/creds/terraform_creds.json")}"
    project     = "terraform-2018"
    region      = "us-east1"
}   
module "sql_database" {
    source                              = "../../modules/sql_database"
    name                                = "TEST"

    #MySQL without replication
    enable_replication                  = false
    database_version                    = "MYSQL_5_6"
    settings_database_flags             = [
        {    
            name    = "skip_show_database"
            value   = "on"
        }
    ]
    #settings_maintenance_window         = []
    #
    #MySQL with replication
    #enable_replication                  = true
    #database_version                    = "MYSQL_5_6"    
    #settings_database_flags             = [
    #    {
    #        name    = "skip_show_database"
    #        value   = "on"
    #    }
    #]
    #settings_maintenance_window         = []
    #
    # Postgres without replication
    #enable_replication                  = false
    #database_version                    = "POSTGRES_9_6"
    #settings_database_flags             = []
    #settings_maintenance_window         = [
    #    {
    #        day             = "6"
    #        hour            = "23"
    #        update_track    = ""
    #    }
    #]
    # Postgres with replication
    #enable_replication                  = true
    #database_version                    = "POSTGRES_9_6"
    #settings_database_flags             = []
    #settings_maintenance_window         = [
    #    {
    #        day             = "6"
    #        hour            = "23"
    #        update_track    = ""
    #    }
    #]

    # DB
    sql_database_instance_name           = "test-sd-instance-stage-1"
    enable_sql_database_creating         = true
    enable_sql_user_creating             = true
    
}


```

Module Input Variables
----------------------
- `name` - A unique name for the resource, required by GCE. Changing this forces a new resource to be created (`default     = "TEST"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `count_sql_database_instance` - Counter, which count how many nodes which will be created (`default     = "1"`).
- `database_version` - (Optional, Default: MYSQL_5_6) The MySQL version to use. Can be MYSQL_5_6, MYSQL_5_7 or POSTGRES_9_6 for second-generation instances, or MYSQL_5_5 or MYSQL_5_6 for first-generation instances. See Second Generation Capabilities for more information. POSTGRES_9_6 support is in Beta (`default     = "MYSQL_5_6"`).
- `region` - (Required) The region the instance will sit in. Note, first-generation Cloud SQL instance regions do not line up with the Google Compute Engine (GCE) regions, and Cloud SQL is not available in all regions - choose from one of the options listed here. A valid region must be provided to use this resource. If a region is not provided in the resource definition, the provider region will be used instead, but this will be an apply-time error for all first-generation instances and for second-generation instances if the provider region is not supported with Cloud SQL. If you choose not to provide the region argument for this resource, make sure you understand this (`default     = {
        MYSQL_5_6       = "us-east1"
        MYSQL_5_7       = "us-east1"
        POSTGRES_9_6    = "us-east1"
    }`).
- `timeouts_create` - Time to create redis node. Default is 6 minutes. Valid units of time are s, m, h (`default     = "6m"`).
- `timeouts_update` - Time to update redis node. Default is 4 minutes. Valid units of time are s, m, h (`default     = "4m"`)
- `timeouts_delete` - Time to delete redis node. Default is 4 minutes. Valid units of time are s, m, h (`default     = "4m"`)
- `master_instance_name` -  (Optional) The name of the instance that will act as the master in the replication setup. Note, this requires the master to have binary_log_enabled set, as well as existing backups (`default     = ""`).
- `project` - (Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used (`default     = "terraform-2018"`).
- `replica_configuration_ca_certificate` - (Optional) PEM representation of the trusted CA's x509 certificate (`default     = ""`).
- `replica_configuration_client_certificate` - (Optional) PEM representation of the slave's x509 certificate (`default     = ""`).
- `replica_configuration_client_key` - (Optional) PEM representation of the slave's private key. The corresponding public key in encoded in the client_certificate (`default     = ""`).
- `replica_configuration_connect_retry_interval` - (Optional, Default: 60) The number of seconds between connect retries (`default     = "60"`).
- `replica_configuration_dump_file_path` - (Optional) Path to a SQL file in GCS from which slave instances are created. Format is gs://bucket/filename (`default     = ""`).
- `replica_configuration_failover_target` - (Optional) Specifies if the replica is the failover target. If the field is set to true the replica will be designated as a failover replica. If the master instance fails, the replica instance will be promoted as the new master instance (`default     = ""`).
- `replica_configuration_master_heartbeat_period` - (Optional) Time in ms between replication heartbeats (`default     = "60000"`).
- `replica_configuration_password` - (Optional) Password for the replication connection (`default     = ""`).
- `replica_configuration_username` - (Optional) Username for replication connection (`default     = ""`).
- `replica_configuration_verify_server_certificate` - (Optional) True if the master's common name value is checked during the SSL handshake (`default     = ""`).
- `settings_tier` - (Required) The machine tier (First Generation) or type (Second Generation) to use. See tiers for more details and supported versions. Postgres supports only shared-core machine types such as db-f1-micro, and custom machine types such as db-custom-2-13312. See the Custom Machine Type Documentation to learn about specifying custom machine types (`default     = {
        MYSQL_5_6       = "D0"
        MYSQL_5_7       = "D0"
        POSTGRES_9_6    = "db-f1-micro"
    }`).
- `settings_activation_policy` - (Optional) This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND (`default     = "ALWAYS"`).
- `settings_authorized_gae_applications` - (Optional) A list of Google App Engine (GAE) project names that are allowed to access this instance (`default     = []`).
- `settings_availability_type` - (Optional) This specifies whether a PostgreSQL instance should be set up for high availability (REGIONAL) or single zone (ZONAL) - (`default     = "REGIONAL"`).
- `settings_crash_safe_replication` - (Optional) Specific to read instances, indicates when crash-safe replication flags are enabled (`default     = ""`).
- `settings_disk_autoresize` - (Optional, Second Generation, Default: true) Configuration to increase storage size automatically (`default     = "true"`).
- `settings_disk_size` - (Optional, Second Generation, Default: 10) The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased (`default     = "10"`).
- `settings_disk_type` - (Optional, Second Generation, Default: PD_SSD) The type of data disk: PD_SSD or PD_HDD (`default     = "PD_SSD"`).
- `settings_pricing_plan` - (Optional, First Generation) Pricing plan for this instance, can be one of PER_USE or PACKAGE (`default     = "PER_USE"`).
- `settings_replication_type` - (Optional) Replication type for this instance, can be one of ASYNCHRONOUS or SYNCHRONOUS (`default     = "SYNCHRONOUS"`).
- `settings_backup_configuration_binary_log_enabled` - (Optional) True if binary logging is enabled. If logging is false, this must be as well (`default     = "false"`).
- `settings_backup_configuration_enabled` - (Optional) True if backup configuration is enabled (`default     = "true"`).
- `settings_backup_configuration_start_time` - (Optional) HH:MM format time indicating when backup configuration starts (`default     = "23:00"`).
- `settings_ip_configuration_ipv4_enabled` - (Optional) True if the instance should be assigned an IP address. The IPv4 address cannot be disabled for Second Generation instances (`default     = "true"`).
- `settings_ip_configuration_require_ssl` - (Optional) True if mysqld should default to REQUIRE X509 for users connecting over IP (`default     = ""`).
- `settings_authorized_networks_expiration_time` - (Optional) The RFC 3339 formatted date time string indicating when this whitelist expires (`default     = ""`).
- `settings_authorized_networks_name` - (Optional) A name for this whitelist entry (`default     = "allow_from_all"`).
- `settings_authorized_networks_value` - (Optional) A CIDR notation IPv4 or IPv6 address that is allowed to access this instance. Must be set even if other two attributes are not for the whitelist to become active (`default     = "0.0.0.0/0"`).
- `settings_location_preference_follow_gae_application` - (Optional) A GAE application whose zone to remain in. Must be in the same region as this instance (`default     = ""`).
- `settings_location_preference_zone` - (Optional) The preferred compute engine zone (`default     = ""`).
- `settings_maintenance_window` - Set maintenance window. Need to set flags (day (1-7), start from Monday; hour (0-23); update_track ((Optional) Receive updates earlier (canary) or later (stable))) - (`default     = []`).
- `settings_database_flags` - Set database flags (`default     = []`).
- `enable_replication` - Enable replication (`default     = "false"`).
- `enable_sql_database_creating` - Enable sql DB creating (`default     = "true`).
- `sql_database_name` - (Required) The name of the database (`default     = "test_db"`).
- `sql_database_instance_name` - (Required) The name of containing instance (`default     = ""`).
- `sql_database_charset` - (Optional) The charset value. See MySQL's Supported Character Sets and Collations and Postgres' Character Set Support for more details and supported values. Postgres databases are in Beta, and have limited charset support; they only support a value of UTF8 at creation time (`default     = ""`).
- `sql_database_collation` - (Optional) The collation value. See MySQL's Supported Character Sets and Collations and Postgres' Collation Support for more details and supported values. Postgres databases are in Beta, and have limited collation support; they only support a value of en_US.UTF8 at creation time (`default     = ""`).
- `enable_sql_user_creating` - Enable sql user (`default     = "true"`).
- `sql_user_name` - (Required) The name of the user. Changing this forces a new resource to be created (`default     = "test_user"`).
- `sql_user_host` - (Optional) The host the user can connect from. This is only supported for MySQL instances. Don't set this field for PostgreSQL instances. Can be an IP address. Changing this forces a new resource to be created (`default     = ""`).
- `sql_user_password` - (Optional) The password for the user. Can be updated (`default     = ""`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
