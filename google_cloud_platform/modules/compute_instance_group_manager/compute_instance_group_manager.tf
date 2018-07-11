#---------------------------------------------------
# Create compute instance group manager
#---------------------------------------------------
resource "google_compute_instance_group_manager" "compute_instance_group_manager" {
    count                   = "${var.enable_just_instance_template_usage && !var.use_compute_instance_group_manager_default ? 1 : 0}"

    name                    = "${lower(var.name)}-ce-gm-${lower(var.environment)}"
    description             = "${var.description}"
    zone                    = "${var.zone}"
    project                 = "${var.project}"

    base_instance_name      = "${lower(var.base_instance_name)}-${lower(var.environment)}"
    instance_template       = "${var.instance_template}"
    wait_for_instances      = "${var.wait_for_instances}"

    target_pools            = ["${var.target_pools}"]
    target_size             = "${var.target_size}"

    named_port {
        name    = "${var.named_port_name}"
        port    = "${var.named_port_port}"
    }
 
    update_strategy         = "${var.update_strategy}"
    auto_healing_policies {
        health_check      = "${var.auto_healing_policies_health_check}"
        initial_delay_sec = "${var.auto_healing_policies_initial_delay_sec}"
    }
    rolling_update_policy {
        type                    = "${var.rolling_update_policy_type}"
        minimal_action          = "${var.rolling_update_policy_minimal_action}"
        #max_surge_fixed         = "${var.rolling_update_policy_max_surge_fixed}"
        max_surge_percent       = "${var.rolling_update_policy_max_surge_percent}"
        max_unavailable_fixed   = "${var.rolling_update_policy_max_unavailable_fixed}"
        #max_unavailable_percent = "${var.rolling_update_policy_max_unavailable_percent}"
        min_ready_sec           = "${var.rolling_update_policy_min_ready_sec}"
    }   

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_compute_instance_group_manager" "compute_instance_group_manager_default" {
    count               = "${var.use_compute_instance_group_manager_default ? 1 : 0}"

    name                = "${lower(var.name)}-ce-gm-${lower(var.environment)}"
    zone                = "${var.zone}"

    instance_template   = "${var.instance_template}"
    target_pools        = ["${var.target_pools}"]
    base_instance_name  = "${lower(var.base_instance_name)}-${lower(var.environment)}"

    auto_healing_policies {
        health_check      = "${var.auto_healing_policies_health_check}"
        initial_delay_sec = "${var.auto_healing_policies_initial_delay_sec}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
#---------------------------------------------------
# Create compute instance group manager with version (IN TESTING. PLEASE DO NOT USE IT FOR NOW)
#---------------------------------------------------
resource "google_compute_instance_group_manager" "compute_instance_group_manager_version" {
    count                   = "${!var.enable_just_instance_template_usage && !var.use_compute_instance_group_manager_default ? 1 : 0}"

    name                    = "${lower(var.name)}-ce-gm-${lower(var.environment)}"
    description             = "${var.description}"
    zone                    = "${var.zone}"
    project                 = "${var.project}"

    base_instance_name      = "${lower(var.base_instance_name)}-${lower(var.environment)}"
    wait_for_instances      = "${var.wait_for_instances}"
    
    version {
        name                = "${lower(var.base_instance_name)}-${lower(var.environment)}"
        instance_template   = "${var.instance_template}"
        #target_size {
        #    fixed = 1
        #}
    }
    #version {
    #    name               = "${lower(var.base_instance_name)}-${lower(var.environment)}"
    #    instance_template  = "${var.instance_template}"
    #    target_size {
    #        percent = 20
    #    }
    #}

    target_pools            = ["${var.target_pools}"]
    target_size             = "${var.target_size}"
    
    named_port {
        name    = "${var.named_port_name}"
        port    = "${var.named_port_port}"
    }

    update_strategy         = "${var.update_strategy}"
    auto_healing_policies {
        health_check      = "${var.auto_healing_policies_health_check}"
        initial_delay_sec = "${var.auto_healing_policies_initial_delay_sec}"
    }
    rolling_update_policy {
        type                    = "${var.rolling_update_policy_type}"
        minimal_action          = "${var.rolling_update_policy_minimal_action}"
        #max_surge_fixed         = "${var.rolling_update_policy_max_surge_fixed}"
        max_surge_percent       = "${var.rolling_update_policy_max_surge_percent}"
        max_unavailable_fixed   = "${var.rolling_update_policy_max_unavailable_fixed}"
        #max_unavailable_percent = "${var.rolling_update_policy_max_unavailable_percent}"
        min_ready_sec           = "${var.rolling_update_policy_min_ready_sec}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
