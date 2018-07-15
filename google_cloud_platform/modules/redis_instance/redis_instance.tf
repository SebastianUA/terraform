#---------------------------------------------------
# Create redis instance
#---------------------------------------------------
resource "google_redis_instance" "redis_instance" {
    count                   = "${var.count_redis_instance}"    

    name                    = "${lower(var.name)}-ri-${lower(var.environment)}-${count.index+1}"
    memory_size_gb          = "${var.memory_size_gb}"
    tier                    = "${var.tier}"
    
    project                 = "${var.project}"
    region                  = "${var.region}"
    location_id             = "${var.location_id}"
    alternative_location_id = "${var.alternative_location_id}"

    authorized_network      = "${var.authorized_network}"

    redis_version           = "${var.redis_version}"
    display_name            = "${length(var.display_name) > 0 ? var.display_name : "${lower(var.name)}-ri-${lower(var.environment)}" }"
    reserved_ip_range       = "${var.reserved_ip_range}"

    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"
        delete  = "${var.timeouts_delete}"
    }

    labels {
        name            = "${lower(var.name)}-ri-${lower(var.environment)}-${count.index+1}"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
