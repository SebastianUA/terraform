#---------------------------------------------------
# Create runtimeconfig config
#---------------------------------------------------
resource "google_runtimeconfig_config" "runtimeconfig_config" {
    
    name        = "${lower(var.name)}-rc-config-${lower(var.environment)}"
    description = "${var.description}"
    project     = "${var.project}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
#---------------------------------------------------
# Create runtimeconfig variable 
#---------------------------------------------------
resource "google_runtimeconfig_variable" "runtimeconfig_variable_text" {
    count       = "${var.enable_runtimeconfig_variable_text_usage ? 1 : 0}"
    
    parent      = "${var.runtimeconfig_config_name}"
    name        = "${lower(var.name)}-rc-variable-${lower(var.environment)}"
    project     = "${var.project}"
    text        = "${var.text}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_runtimeconfig_variable" "runtimeconfig_variable_value" {
    count       = "${var.enable_runtimeconfig_variable_value_usage ? 1 : 0}"

    parent      = "${var.runtimeconfig_config_name}"
    name        = "${lower(var.name)}-rc-variable-${lower(var.environment)}"
    project     = "${var.project}"
    value       = "${length(var.value) >0 ? "${base64encode(var.value)}" : "${base64encode(file("${path.module}/${var.value_file}"))}" }"
    
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

