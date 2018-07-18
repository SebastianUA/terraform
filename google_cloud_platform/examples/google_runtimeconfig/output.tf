output "runtimeconfig_config_name" {
    description = "Name of google_runtimeconfig_config"
    value       = "${module.google_runtimeconfig.google_runtimeconfig_config_name}"
}
    
output "runtimeconfig_config_id" {
    description = "ID"
    value       = "${module.google_runtimeconfig.google_runtimeconfig_config_id}"
}
        
output "runtimeconfig_variable_text_update_time" {
    description = "update_time"
    value       = "${module.google_runtimeconfig.google_runtimeconfig_variable_text_update_time}"
}

output "runtimeconfig_variable_value_update_time" {
    description = "update_time"
    value       = "${module.google_runtimeconfig.google_runtimeconfig_variable_value_update_time}"
}

