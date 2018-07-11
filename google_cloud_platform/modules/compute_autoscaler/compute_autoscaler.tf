#---------------------------------------------------
# Create compute autoscaler
#---------------------------------------------------
resource "google_compute_autoscaler" "compute_autoscaler" {

    name            = "${lower(var.name)}-ce-as-${lower(var.environment)}"
    description     = "${var.description}"
    zone            = "${var.zone}"
    project         = "${var.project}"

    target          = "${var.target}"
            
    autoscaling_policy = {
        max_replicas    = "${var.autoscaling_policy_max_replicas}"
        min_replicas    = "${var.autoscaling_policy_min_replicas}"
        cooldown_period = "${var.autoscaling_policy_cooldown_period}"

        cpu_utilization {
            target  = "${var.cpu_utilization_target}"
        }
        
        metric {
            name    = "${var.metric_name}"
            type    = "${var.metric_type}"
            target  = "${var.metric_target}"
        }
        
        load_balancing_utilization {
            target  = "${var.load_balancing_utilization_target}"
        }
    }
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

