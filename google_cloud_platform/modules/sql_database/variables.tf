variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "count_sql_database_instance" {
    description = "Counter, which count how many nodes which will be created"
    default     = "1"
}

variable "database_version" {
    description = "(Optional, Default: MYSQL_5_6) The MySQL version to use. Can be MYSQL_5_6, MYSQL_5_7 or POSTGRES_9_6 for second-generation instances, or MYSQL_5_5 or MYSQL_5_6 for first-generation instances. See Second Generation Capabilities for more information. POSTGRES_9_6 support is in Beta."
    default     = "MYSQL_5_6"
}

variable "region" {
    description = "(Required) The region the instance will sit in. Note, first-generation Cloud SQL instance regions do not line up with the Google Compute Engine (GCE) regions, and Cloud SQL is not available in all regions - choose from one of the options listed here. A valid region must be provided to use this resource. If a region is not provided in the resource definition, the provider region will be used instead, but this will be an apply-time error for all first-generation instances and for second-generation instances if the provider region is not supported with Cloud SQL. If you choose not to provide the region argument for this resource, make sure you understand this."
    type        = "map"
    default     = {
        MYSQL_5_6       = "us-east1"
        MYSQL_5_7       = "us-east1"
        POSTGRES_9_6    = "us-east1"
    }
}

variable "timeouts_create" {
    description = "Time to create redis node. Default is 6 minutes. Valid units of time are s, m, h."
    default     = "6m"
}

variable "timeouts_update" {
    description = "Time to update redis node. Default is 4 minutes. Valid units of time are s, m, h."
    default     = "4m"
}

variable "timeouts_delete" {
    description = "Time to delete redis node. Default is 4 minutes. Valid units of time are s, m, h."
    default     = "4m"
}

variable "master_instance_name" { 
    description = "(Optional) The name of the instance that will act as the master in the replication setup. Note, this requires the master to have binary_log_enabled set, as well as existing backups."
    default     = ""
}

variable "project" {
    description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = "terraform-2018"
}

variable "replica_configuration_ca_certificate" {
    description = "(Optional) PEM representation of the trusted CA's x509 certificate."
    default     = ""
}

variable "replica_configuration_client_certificate" {
    description = "(Optional) PEM representation of the slave's x509 certificate."
    default     = ""
}

variable "replica_configuration_client_key" {
    description = "(Optional) PEM representation of the slave's private key. The corresponding public key in encoded in the client_certificate."
    default     = ""
}

variable "replica_configuration_connect_retry_interval" {
    description = "(Optional, Default: 60) The number of seconds between connect retries."
    default     = "60"
}

variable "replica_configuration_dump_file_path" {
    description = "(Optional) Path to a SQL file in GCS from which slave instances are created. Format is gs://bucket/filename."
    default     = ""
}

variable "replica_configuration_failover_target" {
    description = "(Optional) Specifies if the replica is the failover target. If the field is set to true the replica will be designated as a failover replica. If the master instance fails, the replica instance will be promoted as the new master instance."
    default     = ""
}

variable "replica_configuration_master_heartbeat_period" {
    description = "(Optional) Time in ms between replication heartbeats."
    default     = "60000"
}

variable "replica_configuration_password" {
    description = "(Optional) Password for the replication connection."
    default     = ""
}

variable "replica_configuration_username" {
    description = "(Optional) Username for replication connection."
    default     = ""
}

variable "replica_configuration_verify_server_certificate" {
    description = "(Optional) True if the master's common name value is checked during the SSL handshake."
    default     = ""
}

variable "settings_tier" {
    description = "(Required) The machine tier (First Generation) or type (Second Generation) to use. See tiers for more details and supported versions. Postgres supports only shared-core machine types such as db-f1-micro, and custom machine types such as db-custom-2-13312. See the Custom Machine Type Documentation to learn about specifying custom machine types."
    type        = "map"
    default     = {
        MYSQL_5_6       = "D0"
        MYSQL_5_7       = "D0"
        POSTGRES_9_6    = "db-f1-micro"
    }
}

variable "settings_activation_policy" {
    description = "(Optional) This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND."
    default     = "ALWAYS"
}

variable "settings_authorized_gae_applications" {
    description = "(Optional) A list of Google App Engine (GAE) project names that are allowed to access this instance."
    default     = []
}

variable "settings_availability_type" {
    description = "(Optional) This specifies whether a PostgreSQL instance should be set up for high availability (REGIONAL) or single zone (ZONAL)."
    default     = "REGIONAL"
}

variable "settings_crash_safe_replication" {
    description = "(Optional) Specific to read instances, indicates when crash-safe replication flags are enabled."
    default     = ""
}

variable "settings_disk_autoresize" {
    description = "(Optional, Second Generation, Default: true) Configuration to increase storage size automatically."
    default     = "true"
}

variable "settings_disk_size" {
    description = "(Optional, Second Generation, Default: 10) The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
    default     = "10"
}

variable "settings_disk_type" {
    description = "(Optional, Second Generation, Default: PD_SSD) The type of data disk: PD_SSD or PD_HDD."
    default     = "PD_SSD"
}

variable "settings_pricing_plan" {
    description = "(Optional, First Generation) Pricing plan for this instance, can be one of PER_USE or PACKAGE."
    default     = "PER_USE"
}

variable "settings_replication_type" {
    description = "(Optional) Replication type for this instance, can be one of ASYNCHRONOUS or SYNCHRONOUS."
    default     = "SYNCHRONOUS"
}

variable "settings_backup_configuration_binary_log_enabled" {
    description = "(Optional) True if binary logging is enabled. If logging is false, this must be as well."
    default     = "false"
}

variable "settings_backup_configuration_enabled" {
    description = "(Optional) True if backup configuration is enabled."
    default     = "true"
}

variable "settings_backup_configuration_start_time" {
    description = "(Optional) HH:MM format time indicating when backup configuration starts."
    default     = "23:00"
}

variable "settings_ip_configuration_ipv4_enabled" {
    description = "(Optional) True if the instance should be assigned an IP address. The IPv4 address cannot be disabled for Second Generation instances."
    default     = "true"
}

variable "settings_ip_configuration_require_ssl" {
    description = "(Optional) True if mysqld should default to REQUIRE X509 for users connecting over IP."
    default     = ""
}

variable "settings_authorized_networks_expiration_time" {
    description = "(Optional) The RFC 3339 formatted date time string indicating when this whitelist expires."
    default     = ""
}

variable "settings_authorized_networks_name" {
    description = "(Optional) A name for this whitelist entry."
    default     = "allow_from_all"
}

variable "settings_authorized_networks_value" {
    description = "(Optional) A CIDR notation IPv4 or IPv6 address that is allowed to access this instance. Must be set even if other two attributes are not for the whitelist to become active."
    default     = "0.0.0.0/0"
}

variable "settings_location_preference_follow_gae_application" {
    description = "(Optional) A GAE application whose zone to remain in. Must be in the same region as this instance."
    default     = ""
}

variable "settings_location_preference_zone" {
    description = "(Optional) The preferred compute engine zone."
    default     = ""
}

variable "settings_maintenance_window" {
    description = "Set maintenance window. Need to set flags (day (1-7), start from Monday; hour (0-23); update_track ((Optional) Receive updates earlier (canary) or later (stable)))."
    default     = []
}

variable "settings_database_flags" {
    description = "Set database flags"
    default     = []
}

variable "enable_replication" {
    description = "Enable replication"
    default     = "false"
}

variable "enable_sql_database_creating" {
    description = "Enable sql DB creating"
    default     = "true"
}

variable "sql_database_name" {
    description = "(Required) The name of the database."
    default     = "test_db"
}

variable "sql_database_instance_name" {
    description = "(Required) The name of containing instance."
    default     = ""
}

variable "sql_database_charset" {
    description = "(Optional) The charset value. See MySQL's Supported Character Sets and Collations and Postgres' Character Set Support for more details and supported values. Postgres databases are in Beta, and have limited charset support; they only support a value of UTF8 at creation time."
    default     = ""
}

variable "sql_database_collation" {
    description = "(Optional) The collation value. See MySQL's Supported Character Sets and Collations and Postgres' Collation Support for more details and supported values. Postgres databases are in Beta, and have limited collation support; they only support a value of en_US.UTF8 at creation time."
    default     = ""
}

variable "enable_sql_user_creating" {
    description = "Enable sql user"
    default     = "true"
}

variable "sql_user_name" {
    description = "(Required) The name of the user. Changing this forces a new resource to be created."
    default     = "test_user"
}

variable "sql_user_host" {
    description = "(Optional) The host the user can connect from. This is only supported for MySQL instances. Don't set this field for PostgreSQL instances. Can be an IP address. Changing this forces a new resource to be created."
    default     = ""
}

variable "sql_user_password" {
    description = "(Optional) The password for the user. Can be updated."
    default     = ""
}
