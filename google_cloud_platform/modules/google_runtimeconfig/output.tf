output "google_runtimeconfig_config_name" {
    description = "Name of google_runtimeconfig_config"
    value       = "${google_runtimeconfig_config.runtimeconfig_config.name}"
}

output "google_runtimeconfig_config_id" {
    description = "ID"
    value       = "${google_runtimeconfig_config.runtimeconfig_config.id}"
}

output "google_runtimeconfig_variable_text_update_time" {
    description = "update_time"
    value       = "${google_runtimeconfig_variable.runtimeconfig_variable_text.*.update_time}"
}

output "google_runtimeconfig_variable_value_update_time" {
    description = "update_time"
    value       = "${google_runtimeconfig_variable.runtimeconfig_variable_value.*.update_time}"
}
