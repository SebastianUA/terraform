#---------------------------------------------------
# Create compute ssl certificate
#---------------------------------------------------
resource "google_compute_ssl_certificate" "compute_ssl_certificate" {
    count       = "${var.enable_compute_ssl_certificate && length(var.name) >0 && var.name_prefix =="" ? 1 : 0}"

    name        = "${lower(var.name)}-cs-certificate-${lower(var.environment)}"
    description = "${var.description}"
    project     = "${var.project}"
    private_key = "${file("${var.private_key}")}"
    certificate = "${file("${var.certificate}")}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_compute_ssl_certificate" "compute_ssl_certificate_name_prefix" {
    count       = "${var.enable_compute_ssl_certificate && var.name =="" && length(var.name_prefix) >0 ? 1 : 0}"

    name_prefix = "${var.name_prefix}"
    description = "${var.description}"
    project     = "${var.project}"
    private_key = "${file("${var.private_key}")}"
    certificate = "${file("${var.certificate}")}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create compute ssl policy
#---------------------------------------------------
resource "google_compute_ssl_policy" "compute_ssl_policy" {
    count           = "${var.enable_compute_ssl_policy && upper(var.profile) !="CUSTOM" ? 1 : 0}"    

    name            = "${lower(var.name)}-cs-policy-${lower(var.environment)}"
    description     = "${var.description}"
    project         = "${var.project}"
    min_tls_version = "${var.min_tls_version}"
    profile         = "${var.profile}"

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

resource "google_compute_ssl_policy" "compute_ssl_policy_custom" {
    count           = "${var.enable_compute_ssl_policy && upper(var.profile) =="CUSTOM" ? 1 : 0}"

    name            = "${lower(var.name)}-cs-policy-custom-${lower(var.environment)}"
    description     = "${var.description}"
    project         = "${var.project}"
    min_tls_version = "${var.min_tls_version}"
    profile         = "${var.profile}"
    custom_features = ["${var.custom_features}"]

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

