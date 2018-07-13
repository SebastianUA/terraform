#---------------------------------------------------
# Create google dns managed zone
#---------------------------------------------------
resource "google_dns_managed_zone" "dns_managed_zone" {
    count       = "${var.enable_dns_managed_zone && length(var.dns_name) >0 && length(var.description) >0 ? 1 : 0}"

    name        = "${lower(var.name)}-dns-mz-${lower(var.environment)}"
    description = "${var.description}"
    project     = "${var.project}"
    dns_name    = "${var.dns_name}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create google dns record set
#---------------------------------------------------
resource "google_dns_record_set" "dns_record_set" {
    count           = "${var.enable_dns_record_set && length(var.type) >0 && length(var.managed_zone) >0 && length(var.rrdatas) >0 ? 1 : 0}"

    name            = "${lower(var.name)}.${lower(var.dns_name)}."
    project         = "${var.project}"
    type            = "${var.type}"
    ttl             = "${var.ttl}"

    managed_zone    = "${var.managed_zone}"
    
    rrdatas         = ["${var.rrdatas}"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
} 
