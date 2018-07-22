#---------------------------------------------------
# Create google container cluster
#---------------------------------------------------
resource "google_container_cluster" "container_cluster_zone" {
    count                               = "${var.enable_container_cluster && length(var.zone) >0 && var.region =="" ? 1 : 0}"
                                
    name                                = "${lower(var.name)}-cc-${lower(var.environment)}"
    description                         = "${var.description}"
    project                             = "${var.project}"
    zone                                = "${var.zone}"
    initial_node_count                  = "${var.initial_node_count}"
                                
    additional_zones                    = ["${var.additional_zones}"]
    private_cluster                     = "${var.private_cluster}"
    cluster_ipv4_cidr                   = "${var.cluster_ipv4_cidr}"
    enable_kubernetes_alpha             = "${var.enable_kubernetes_alpha}"
    enable_legacy_abac                  = "${var.enable_legacy_abac}"
    network                             = "${var.network}"
    subnetwork                          = "${var.subnetwork}"
    
    master_authorized_networks_config   = ["${var.master_authorized_networks_config}"]
    master_ipv4_cidr_block              = "${var.master_ipv4_cidr_block}"
    min_master_version                  = "${var.min_master_version}"
    
    logging_service                     = "${var.logging_service}"
    monitoring_service                  = "${var.monitoring_service}"
        
    node_pool                           = ["${var.node_pool}"]
    node_version                        = "${var.node_version}"
    remove_default_node_pool            = "${var.remove_default_node_pool}"
   
    master_auth {
        username = "${var.master_auth_username}"
        password = "${var.master_auth_password}"
        client_certificate_config {
            issue_client_certificate = "${var.issue_client_certificate}"
        }
    }
    
    node_config {
        disk_size_gb        = "${var.node_config_disk_size_gb}"
        image_type          = "${var.node_config_image_type}"
        local_ssd_count     = "${var.node_config_local_ssd_count}"
        machine_type        = "${var.node_config_machine_type}"
        min_cpu_platform    = "${var.node_config_min_cpu_platform}"
        preemptible         = "${var.node_config_preemptible}"
        service_account     = "${var.node_config_service_account}"
        taint               = ["${var.node_config_taint}"]

        metadata {
            ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
        }
        workload_metadata_config {
            node_metadata = "${var.node_config_workload_metadata_config_node_metadata}"
        }

        guest_accelerator {
            count   = "${var.node_config_guest_accelerator_count}"
            type    = "${var.node_config_guest_accelerator_type}"    
        }

        oauth_scopes    = ["${var.node_config_oauth_scopes}"]

        labels {
            name                = "${lower(var.name)}-cc-${lower(var.environment)}"
            initial_node_count  = "${var.initial_node_count}"
            environment         = "${lower(var.environment)}"
            orchestration       = "${lower(var.orchestration)}"
        }
        
        tags = [
            "${lower(var.name)}",
            "${lower(var.environment)}",
            "${lower(var.orchestration)}"
        ]
    }

    addons_config {
        horizontal_pod_autoscaling {
            disabled = "${var.horizontal_pod_autoscaling_disabled}"
        }
        http_load_balancing {
            disabled = "${var.http_load_balancing_disabled}"
        }
        kubernetes_dashboard {
            disabled = "${var.kubernetes_dashboard_disabled}"
        }
        network_policy_config {
            disabled = "${var.network_policy_config_disabled}"
        }
    }

    #ip_allocation_policy {
    #    cluster_secondary_range_name    = "${length(var.ip_allocation_policy_cluster_secondary_range_name) >0 ? var.ip_allocation_policy_cluster_secondary_range_name : "${lower(var.name)}-cc-${lower(var.environment)}-pods" }"
    #    services_secondary_range_name   = "${length(var.ip_allocation_policy_services_secondary_range_name) >0 ? var.ip_allocation_policy_services_secondary_range_name : "${lower(var.name)}-cc-${lower(var.environment)}-services" }"
    #}

    network_policy {
        provider = "${var.network_policy_provider}"
        enabled  = "${var.network_policy_enabled}"
    }

    pod_security_policy_config {
        enabled = "${var.pod_security_policy_config_enabled}"
    }

    maintenance_policy {
        daily_maintenance_window {
            start_time = "${var.daily_maintenance_window_start_time}"
        }
    }

    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        ignore_changes = ["node_count"]
        create_before_destroy = true
    }
}

resource "google_container_cluster" "container_cluster_region" {
    count                               = "${var.enable_container_cluster && length(var.region) >0 && var.zone =="" ? 1 : 0}"
                                
    name                                = "${lower(var.name)}-cc-${lower(var.environment)}"
    description                         = "${var.description}"
    project                             = "${var.project}"
    region                              = "${var.region}"
    initial_node_count                  = "${var.initial_node_count}"
                                
    additional_zones                    = ["${var.additional_zones}"]
    private_cluster                     = "${var.private_cluster}"
    cluster_ipv4_cidr                   = "${var.cluster_ipv4_cidr}"
    enable_kubernetes_alpha             = "${var.enable_kubernetes_alpha}"
    enable_legacy_abac                  = "${var.enable_legacy_abac}"
    network                             = "${var.network}"
    subnetwork                          = "${var.subnetwork}"
    
    master_authorized_networks_config   = ["${var.master_authorized_networks_config}"]
    master_ipv4_cidr_block              = "${var.master_ipv4_cidr_block}"
    min_master_version                  = "${var.min_master_version}"
    
    logging_service                     = "${var.logging_service}"
    monitoring_service                  = "${var.monitoring_service}"
        
    node_pool                           = ["${var.node_pool}"]
    node_version                        = "${var.node_version}"
    remove_default_node_pool            = "${var.remove_default_node_pool}"
   
    master_auth {
        username = "${var.master_auth_username}"
        password = "${var.master_auth_password}"
        client_certificate_config {
            issue_client_certificate = "${var.issue_client_certificate}"
        }
    }
    
    node_config {
        disk_size_gb        = "${var.node_config_disk_size_gb}"
        image_type          = "${var.node_config_image_type}"
        local_ssd_count     = "${var.node_config_local_ssd_count}"
        machine_type        = "${var.node_config_machine_type}"
        min_cpu_platform    = "${var.node_config_min_cpu_platform}"
        preemptible         = "${var.node_config_preemptible}"
        service_account     = "${var.node_config_service_account}"
        taint               = ["${var.node_config_taint}"]
    
        metadata {
            ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
        }
        workload_metadata_config {
            node_metadata = "${var.node_config_workload_metadata_config_node_metadata}"
        }

        guest_accelerator {
            count   = "${var.node_config_guest_accelerator_count}"
            type    = "${var.node_config_guest_accelerator_type}"    
        }

        oauth_scopes    = ["${var.node_config_oauth_scopes}"]

        labels {
            name                = "${lower(var.name)}-cc-${lower(var.environment)}"
            initial_node_count  = "${var.initial_node_count}"
            environment         = "${lower(var.environment)}"
            orchestration       = "${lower(var.orchestration)}"
        }
        
        tags = [
            "${lower(var.name)}",
            "${lower(var.environment)}",
            "${lower(var.orchestration)}"
        ]
    }

    addons_config {
        horizontal_pod_autoscaling {
            disabled = "${var.horizontal_pod_autoscaling_disabled}"
        }
        http_load_balancing {
            disabled = "${var.http_load_balancing_disabled}"
        }
        kubernetes_dashboard {
            disabled = "${var.kubernetes_dashboard_disabled}"
        }
        network_policy_config {
            disabled = "${var.network_policy_config_disabled}"
        }
    }

    ip_allocation_policy {
        cluster_secondary_range_name    = "${var.ip_allocation_policy_cluster_secondary_range_name}"
        services_secondary_range_name   = "$var.ip_allocation_policy_services_secondary_range_name}"
    }

    network_policy {
        provider = "${var.network_policy_provider}"
        enabled  = "${var.network_policy_enabled}"
    }

    pod_security_policy_config {
        enabled = "${var.pod_security_policy_config_enabled}"
    }

    maintenance_policy {
        daily_maintenance_window {
            start_time = "${var.daily_maintenance_window_start_time}"
        }
    }

    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        ignore_changes = ["node_count"]
        create_before_destroy = true
    }
}
#---------------------------------------------------
# Create google container node pool
#---------------------------------------------------
resource "google_container_node_pool" "container_node_pool_zone" {
    count               = "${var.enable_container_node_pool && length(var.zone) >0 && var.region =="" ? 1 : 0}" 
                  
    name                = "${lower(var.name)}-cn-pool-${lower(var.environment)}"
    zone                = "${var.zone}"
    project             = "${var.project}"
    #region              = "${var.region}"
    cluster             = "${var.container_cluster_name}"
    node_count          = "${var.node_count}"
    #initial_node_count  = "${var.initial_node_count}"
    
    node_config {
        disk_size_gb        = "${var.node_config_disk_size_gb}"
        image_type          = "${var.node_config_image_type}"
        local_ssd_count     = "${var.node_config_local_ssd_count}"
        machine_type        = "${var.node_config_machine_type}"
        min_cpu_platform    = "${var.node_config_min_cpu_platform}"
        preemptible         = "${var.node_config_preemptible}"
        service_account     = "${var.node_config_service_account}"
        taint               = ["${var.node_config_taint}"]

        metadata {
            ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
        }
        workload_metadata_config {
            node_metadata = "${var.node_config_workload_metadata_config_node_metadata}"
        }

        guest_accelerator {
            count   = "${var.node_config_guest_accelerator_count}"
            type    = "${var.node_config_guest_accelerator_type}"
        }

        oauth_scopes    = ["${var.node_config_oauth_scopes}"]

        labels {
            name                = "${lower(var.name)}-cn-pool-${lower(var.environment)}"
            initial_node_count  = "${var.initial_node_count}"
            environment         = "${lower(var.environment)}"
            orchestration       = "${lower(var.orchestration)}"
        }

        tags = [
            "${lower(var.name)}",
            "${lower(var.environment)}",
            "${lower(var.orchestration)}"
        ]
    }

    autoscaling {
        min_node_count  = "${var.autoscaling_min_node_count}"
        max_node_count  = "${var.autoscaling_max_node_count}"
    }

    management {    
        auto_repair     = "${var.management_auto_repair}"
        auto_upgrade    = "${var.management_auto_upgrade}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_container_node_pool" "container_node_pool_region" {
    count               = "${var.enable_container_node_pool && length(var.region) >0 && var.zone =="" ? 1 : 0}"

    name                = "${lower(var.name)}-cn-pool-${lower(var.environment)}"
    project             = "${var.project}"
    region              = "${var.region}"
    cluster             = "${var.container_cluster_name}"
    node_count          = "${var.node_count}"

    node_config {
        disk_size_gb        = "${var.node_config_disk_size_gb}"
        image_type          = "${var.node_config_image_type}"
        local_ssd_count     = "${var.node_config_local_ssd_count}"
        machine_type        = "${var.node_config_machine_type}"
        min_cpu_platform    = "${var.node_config_min_cpu_platform}"
        preemptible         = "${var.node_config_preemptible}"
        service_account     = "${var.node_config_service_account}"
        taint               = ["${var.node_config_taint}"]

        metadata {
            ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
        }
        workload_metadata_config {
            node_metadata = "${var.node_config_workload_metadata_config_node_metadata}"
        }

        guest_accelerator {
            count   = "${var.node_config_guest_accelerator_count}"
            type    = "${var.node_config_guest_accelerator_type}"
        }

        oauth_scopes    = ["${var.node_config_oauth_scopes}"]

        labels {
            name                = "${lower(var.name)}-cn-pool-${lower(var.environment)}"
            initial_node_count  = "${var.initial_node_count}"
            environment         = "${lower(var.environment)}"
            orchestration       = "${lower(var.orchestration)}"
        }

        tags = [
            "${lower(var.name)}",
            "${lower(var.environment)}",
            "${lower(var.orchestration)}"
        ]
    }

    autoscaling {
        min_node_count  = "${var.autoscaling_min_node_count}"
        max_node_count  = "${var.autoscaling_max_node_count}"
    }

    management {
        auto_repair     = "${var.management_auto_repair}"
        auto_upgrade    = "${var.management_auto_upgrade}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

