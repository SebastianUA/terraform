#---------------------------------------------------
# Create compute security policy
#---------------------------------------------------
resource "google_compute_security_policy" "compute_security_policy" {
    count       = "${var.enable_compute_security_policy && length(var.rule) ==0 ? 1 : 0}"

    name        = "${lower(var.name)}-cs-policy-${lower(var.environment)}"
    description = "${var.description}"        
    project     = "${var.project}"            

    rule {
        action      = "${var.rule_action}"
        priority    = "${var.rule_priority}"
        description = "${var.rule_description}" 
        preview     = "${var.rule_preview}"
        match {
            versioned_expr = "${var.match_versioned_expr}"
            config {
                src_ip_ranges = ["${var.match_config_src_ip_ranges}"]
            }
        }
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_compute_security_policy" "compute_security_policy_custom" {
    count       = "${var.enable_compute_security_policy && length(var.rule) >0 ? 1 : 0}"

    name        = "${lower(var.name)}-cs-policy-${lower(var.environment)}"
    description = "${var.description}"
    project     = "${var.project}"

    rule        = ["${var.rule}"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

