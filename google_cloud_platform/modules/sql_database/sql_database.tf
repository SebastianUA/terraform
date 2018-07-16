#---------------------------------------------------
# Create google sql database instance
#---------------------------------------------------
resource "google_sql_database_instance" "sql_database_instance_mysql" {
    count                            = "${var.database_version !="POSTGRES_9_6" && !var.enable_replication ? var.count_sql_database_instance : 0}"
                                                                                                                                             
    name                             = "${lower(var.name)}-sd-instance-${lower(var.environment)}-${count.index+1}"
    project                          = "${var.project}"                
    database_version                 = "${var.database_version}"
    region                           = "${lookup(var.region, var.database_version)}"
                                                 
    master_instance_name             = "${var.master_instance_name}"
    
    settings {
        tier                        = "${lookup(var.settings_tier, var.database_version)}"
        activation_policy           = "${var.settings_activation_policy}"
        authorized_gae_applications = ["${var.settings_authorized_gae_applications}"]
        availability_type           = "${var.settings_availability_type}"
        crash_safe_replication      = "${var.settings_crash_safe_replication}"
        replication_type            = "${var.settings_replication_type}"
        pricing_plan                = "${var.settings_pricing_plan}"        
                
        user_labels {
            name            = "${lower(var.name)}-sd-instance-${lower(var.environment)}-${count.index+1}"
            environment     = "${lower(var.environment)}"
            orchestration   = "${lower(var.orchestration)}"
        }
        
        database_flags  = ["${var.settings_database_flags}"]
        
        backup_configuration {      
            binary_log_enabled  = "${var.settings_backup_configuration_binary_log_enabled}"
            enabled             = "${var.settings_backup_configuration_enabled}"
            start_time          = "${var.settings_backup_configuration_start_time}"
        }
        
        ip_configuration {
            ipv4_enabled    = "${var.settings_ip_configuration_ipv4_enabled}"
            require_ssl     = "${var.settings_ip_configuration_require_ssl}"
             
            authorized_networks {
                expiration_time = "${var.settings_authorized_networks_expiration_time}"
                name            = "${var.settings_authorized_networks_name}"
                value           = "${var.settings_authorized_networks_value}" 
            }
        }
        
        location_preference {           
            follow_gae_application  = "${var.settings_location_preference_follow_gae_application}"
            zone                    = "${var.settings_location_preference_zone}"
        }
    
        maintenance_window = []
         
    }
    
    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_sql_database_instance" "sql_database_instance_postgres" {
    count                            = "${var.database_version =="POSTGRES_9_6" && !var.enable_replication ? var.count_sql_database_instance : 0}"

    name                             = "${lower(var.name)}-sd-instance15-${lower(var.environment)}-${count.index+1}"
    project                          = "${var.project}"         
    database_version                 = "${var.database_version}"
    region                           = "${lookup(var.region, var.database_version)}"

    master_instance_name             = "${var.master_instance_name}"

    settings {
        tier                        = "${lookup(var.settings_tier, var.database_version)}"
        activation_policy           = "${var.settings_activation_policy}"
        authorized_gae_applications = ["${var.settings_authorized_gae_applications}"]
        availability_type           = "${var.settings_availability_type}"
        crash_safe_replication      = "${var.settings_crash_safe_replication}"
        replication_type            = "${var.settings_replication_type}"
        
        disk_autoresize             = "${var.settings_disk_autoresize}"
        disk_size                   = "${var.database_version =="POSTGRES_9_6" ? var.settings_disk_size : 0}"
        disk_type                   = "${var.settings_disk_type}"
        
        user_labels {
            name            = "${lower(var.name)}-sd-instance-${lower(var.environment)}-${count.index+1}"
            environment     = "${lower(var.environment)}"
            orchestration   = "${lower(var.orchestration)}"
        }
        
        database_flags  = ["${var.settings_database_flags}"]
        
        backup_configuration {
            binary_log_enabled  = "${var.settings_backup_configuration_binary_log_enabled}"
            enabled             = "${var.settings_backup_configuration_enabled}"
            start_time          = "${var.settings_backup_configuration_start_time}"
        }
        
        ip_configuration {
            ipv4_enabled    = "${var.settings_ip_configuration_ipv4_enabled}"
            require_ssl     = "${var.settings_ip_configuration_require_ssl}"
        
            authorized_networks {
                expiration_time = "${var.settings_authorized_networks_expiration_time}"
                name            = "${var.settings_authorized_networks_name}"
                value           = "${var.settings_authorized_networks_value}"
            }
        }
        
        location_preference {
            follow_gae_application  = "${var.settings_location_preference_follow_gae_application}"
            zone                    = "${var.settings_location_preference_zone}"
        }
        
        maintenance_window = []

    }

    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
#---------------------------------------------------
# Create google sql database instance replication
#---------------------------------------------------
resource "google_sql_database_instance" "sql_database_instance_mysql_replication" {
    count                            = "${var.database_version !="POSTGRES_9_6" && var.enable_replication ? var.count_sql_database_instance : 0}"

    name                             = "${lower(var.name)}-sd-instance-${lower(var.environment)}-${count.index+1}"
    project                          = "${var.project}"             
    database_version                 = "${var.database_version}"
    region                           = "${lookup(var.region, var.database_version)}"

    master_instance_name             = "${var.master_instance_name}"

    replica_configuration {
        ca_certificate              = "${var.replica_configuration_ca_certificate}"
        client_certificate          = "${var.replica_configuration_client_certificate}"
        client_key                  = "${var.replica_configuration_client_key}"
        connect_retry_interval      = "${var.replica_configuration_connect_retry_interval}"
        dump_file_path              = "${var.replica_configuration_dump_file_path}"
        failover_target             = "${var.replica_configuration_failover_target}"
        master_heartbeat_period     = "${var.replica_configuration_master_heartbeat_period}"
        username                    = "${var.replica_configuration_username}"
        password                    = "${var.replica_configuration_password}"
        verify_server_certificate   = "${var.replica_configuration_verify_server_certificate}"
    }

    settings {
        tier                        = "${lookup(var.settings_tier, var.database_version)}"
        activation_policy           = "${var.settings_activation_policy}"
        authorized_gae_applications = ["${var.settings_authorized_gae_applications}"]
        availability_type           = "${var.settings_availability_type}"
        crash_safe_replication      = "${var.settings_crash_safe_replication}"
        replication_type            = "${var.settings_replication_type}"
        pricing_plan                = "${var.settings_pricing_plan}"

        user_labels {
            name            = "${lower(var.name)}-sd-instance-${lower(var.environment)}-${count.index+1}"
            environment     = "${lower(var.environment)}"
            orchestration   = "${lower(var.orchestration)}"
        }

        database_flags  = ["${var.settings_database_flags}"]

        backup_configuration {
            binary_log_enabled  = "${var.settings_backup_configuration_binary_log_enabled}"
            enabled             = "${var.settings_backup_configuration_enabled}"
            start_time          = "${var.settings_backup_configuration_start_time}"
        }

        ip_configuration {
            ipv4_enabled    = "${var.settings_ip_configuration_ipv4_enabled}"
            require_ssl     = "${var.settings_ip_configuration_require_ssl}"

            authorized_networks {
                expiration_time = "${var.settings_authorized_networks_expiration_time}"
                name            = "${var.settings_authorized_networks_name}"
                value           = "${var.settings_authorized_networks_value}"
            }
        }

        location_preference {
            follow_gae_application  = "${var.settings_location_preference_follow_gae_application}"
            zone                    = "${var.settings_location_preference_zone}"
        }

        maintenance_window = []

    }

    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_sql_database_instance" "sql_database_instance_postgres_replication" {
    count                            = "${var.database_version =="POSTGRES_9_6" && var.enable_replication ? var.count_sql_database_instance : 0}"

    name                             = "${lower(var.name)}-sd-instance-${lower(var.environment)}-${count.index+1}"
    project                          = "${var.project}"
    database_version                 = "${var.database_version}"
    region                           = "${lookup(var.region, var.database_version)}"

    master_instance_name             = "${var.master_instance_name}"

    replica_configuration {
        ca_certificate              = "${var.replica_configuration_ca_certificate}"
        client_certificate          = "${var.replica_configuration_client_certificate}"
        client_key                  = "${var.replica_configuration_client_key}"
        connect_retry_interval      = "${var.replica_configuration_connect_retry_interval}"
        dump_file_path              = "${var.replica_configuration_dump_file_path}"
        failover_target             = "${var.replica_configuration_failover_target}"
        master_heartbeat_period     = "${var.replica_configuration_master_heartbeat_period}"
        username                    = "${var.replica_configuration_username}"
        password                    = "${var.replica_configuration_password}"
        verify_server_certificate   = "${var.replica_configuration_verify_server_certificate}"
    }

    settings {
        tier                        = "${lookup(var.settings_tier, var.database_version)}"
        activation_policy           = "${var.settings_activation_policy}"
        authorized_gae_applications = ["${var.settings_authorized_gae_applications}"]
        availability_type           = "${var.settings_availability_type}"
        crash_safe_replication      = "${var.settings_crash_safe_replication}"
        replication_type            = "${var.settings_replication_type}"

        disk_autoresize             = "${var.settings_disk_autoresize}"
        disk_size                   = "${var.database_version =="POSTGRES_9_6" ? var.settings_disk_size : 0}"
        disk_type                   = "${var.settings_disk_type}"

        user_labels {
            name            = "${lower(var.name)}-sd-instance-${lower(var.environment)}-${count.index+1}"
            environment     = "${lower(var.environment)}"
            orchestration   = "${lower(var.orchestration)}"
        }

        database_flags  = ["${var.settings_database_flags}"]

        backup_configuration {
            binary_log_enabled  = "${var.settings_backup_configuration_binary_log_enabled}"
            enabled             = "${var.settings_backup_configuration_enabled}"
            start_time          = "${var.settings_backup_configuration_start_time}"
        }

        ip_configuration {
            ipv4_enabled    = "${var.settings_ip_configuration_ipv4_enabled}"
            require_ssl     = "${var.settings_ip_configuration_require_ssl}"

            authorized_networks {
                expiration_time = "${var.settings_authorized_networks_expiration_time}"
                name            = "${var.settings_authorized_networks_name}"
                value           = "${var.settings_authorized_networks_value}"
            }
        }

        location_preference {
            follow_gae_application  = "${var.settings_location_preference_follow_gae_application}"
            zone                    = "${var.settings_location_preference_zone}"
        }

        maintenance_window = []

    }

    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create google sql database
#---------------------------------------------------
resource "google_sql_database" "sql_database" {
    count       = "${var.enable_sql_database_creating && length(var.sql_database_instance_name) >0 ? 1 : 0}"  

    name        = "${var.sql_database_name}"
    project     = "${var.project}"
    instance    = "${var.sql_database_instance_name}"
    charset     = "${var.sql_database_charset}"
    collation   = "${var.sql_database_collation}"
}

#---------------------------------------------------
# Create google sql user
#---------------------------------------------------
resource "google_sql_user" "sql_user" {
    count       = "${var.enable_sql_user_creating && length(var.sql_database_instance_name) >0 ? 1 : 0}"

    name        = "${var.sql_user_name}"
    project     = "${var.project}"
    instance    = "${var.sql_database_instance_name}"
    host        = "${var.sql_user_host}"
    password    = "${var.sql_user_password}"
}
