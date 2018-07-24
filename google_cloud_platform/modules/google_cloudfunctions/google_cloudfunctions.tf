#---------------------------------------------------
# Create google cloudfunctions
#---------------------------------------------------
resource "google_cloudfunctions_function" "cloudfunctions_function_http" {
    count                   = "${var.trigger_http ? 1 : 0}"
  
    name                    = "${lower(var.name)}-cf-function-${lower(var.environment)}"
    description             = "${var.description}"
    project                 = "${var.project}"
    region                  = "${var.region}"

    source_archive_bucket   = "${var.source_archive_bucket}"
    source_archive_object   = "${var.source_archive_object}"

    available_memory_mb     = "${var.available_memory_mb}"
    timeout                 = "${var.timeout}"
    entry_point             = "${var.entry_point}"
    trigger_http            = "${var.trigger_http}"
    
    labels {
        name            = "${lower(var.name)}-cf-function-${lower(var.environment)}"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_cloudfunctions_function" "cloudfunctions_function_https" {
    count                   = "${!var.trigger_http ? 1 : 0}"

    name                    = "${lower(var.name)}-cf-function-${lower(var.environment)}"
    description             = "${var.description}"
    project                 = "${var.project}"
    region                  = "${var.region}"

    source_archive_bucket   = "${var.source_archive_bucket}"
    source_archive_object   = "${var.source_archive_object}"

    available_memory_mb     = "${var.available_memory_mb}"
    timeout                 = "${var.timeout}"
    entry_point             = "${var.entry_point}"
    trigger_http            = "${var.trigger_http}"

    trigger_bucket          = "${var.trigger_bucket}"
    trigger_topic           = "${var.trigger_topic}"
    retry_on_failure        = "${var.retry_on_failure}"
    
    labels {
        name            = "${lower(var.name)}-cf-function-${lower(var.environment)}"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

