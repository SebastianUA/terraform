#---------------------------------------------------
# Create compute url map
#---------------------------------------------------
resource "google_compute_url_map" "compute_url_map" {
    count           = "${var.enable_compute_url_map && length(var.path_rule) ==0 ? 1 : 0}"

    name            = "${lower(var.name)}-cr-map-${lower(var.environment)}"
    description     = "${var.description}"
    project         = "${var.project}"
     
    default_service = "${var.default_service}"

    host_rule {
        hosts           = ["${var.host_rule_hosts}"]
        description     = "${var.host_rule_description}"     
        path_matcher    = "${var.host_rule_path_matcher}"
    }

    path_matcher {
        name            = "${length(var.path_matcher_name) >0 ? var.path_matcher_name : "${lower(var.name)}-path-matcher-${lower(var.environment)}" }"
        default_service = "${var.default_service}"
        
        path_rule {
            paths   = ["${var.path_rule_paths}"]
            service = "${var.path_rule_service}"
        }
    }
    
    test {
        service     = "${var.test_service}"
        host        = "${var.test_host}"
        path        = "${var.test_path}"
        description = "${var.test_description}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_compute_url_map" "compute_url_map_custom" {
    count           = "${var.enable_compute_url_map && length(var.path_rule) >0 ? 1 : 0}"

    name            = "${lower(var.name)}-cr-map-${lower(var.environment)}"
    description     = "${var.description}"
    project         = "${var.project}"

    default_service = "${var.default_service}"

    host_rule {
        hosts           = ["${var.host_rule_hosts}"]
        description     = "${var.host_rule_description}"
        path_matcher    = "${var.host_rule_path_matcher}"
    }

    path_matcher {
        name            = "${length(var.path_matcher_name) >0 ? var.path_matcher_name : "${lower(var.name)}-path-matcher-${lower(var.environment)}" }"
        default_service = "${var.default_service}"

        path_rule       = ["${var.path_rule}"] 
    }

    test {
        service     = "${var.test_service}"
        host        = "${var.test_host}"
        path        = "${var.test_path}"
        description = "${var.test_description}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

