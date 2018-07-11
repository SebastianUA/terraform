#
# HC
#
output "hc_http_name" {
    description = "Name of http HC"
    value       = "${module.compute_health_check.http_name}"
}

output "hc_http_self_link" {
    description = "self_link of http HC"
    value       = "${module.compute_health_check.http_self_link}"
}

output "hc_https_name" {
    description = "Name of https HC"
    value       = "${module.compute_health_check.https_name}"
}

output "hc_https_self_link" {
    description = "self_link of https HC"
    value       = "${module.compute_health_check.https_self_link}"
}

output "hc_ssl_name" {
    description = "Name of ssl HC"
    value       = "${module.compute_health_check.ssl_name}"
}

output "hc_ssl_self_link" {
    description = "self_link of ssl HC"
    value       = "${module.compute_health_check.ssl_self_link}"
}

#
# template instance 
#
output "template_instance_name" {
    description = "Name of compute instance template"
    value       = "${module.compute_instance_template.name}"
}

output "template_instance_self_link" {
    description = "self_link"
    value       = "${module.compute_instance_template.self_link}"
}

#
# Group manager
#
output "group_manager_name" {
    description = ""
    value       = "${module.compute_instance_group_manager.name}"
}

output "group_manager_self_link" {
    description = "self_link"
    value       = "${module.compute_instance_group_manager.self_link}"
}

output "group_manager_instance_group" {
    description = "Instance group"
    value       = "${module.compute_instance_group_manager.instance_group}"
}

output "group_manager_self_link_default" {
    description = "self_link"
    value       = "${module.compute_instance_group_manager.gm_self_link_default}"
}
