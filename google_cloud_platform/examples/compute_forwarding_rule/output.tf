#########################################################################################################
################################################ instance ###############################################
#########################################################################################################
output "compute_instance_ids" {
    description = "The server-assigned unique identifier of this instance."
    value       = "${module.compute_instance.compute_instance_ids}"
}                                       

output "compute_instance_self_links" {
    description = "output the URI of the created resource."
    value       = "${module.compute_instance.compute_instance_self_links}"
}

output "compute_instance_cpu_platforms" {
    description = "The CPU platform used by this instance."
    value       = "${module.compute_instance.compute_instance_cpu_platforms}"
}

output "compute_instance_internal_ip_addresses" {
    description = "The internal ip address of the instance, either manually or dynamically assigned."
    value       = "${module.compute_instance.compute_instance_internal_ip_addresses}"
}

output "compute_instance_external_ip_addresses" {
    description = "If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip (if you didn't provide one)."
    value       = "${module.compute_instance.compute_instance_external_ip_addresses}"
}
#-----
# instance with attached disk
#-----
output "compute_instance_with_attached_disk_ids" {
    description = "The server-assigned unique identifier of this instance."
    value       = "${module.compute_instance.compute_instance_with_attached_disk_ids}"
}

output "compute_instance_with_attached_disk_self_links" {
    description = "output the URI of the created resource."
    value       = "${module.compute_instance.compute_instance_with_attached_disk_self_links}"
}

output "compute_instance_with_attached_disk_cpu_platforms" {
    description = "The CPU platform used by this instance."
    value       = "${module.compute_instance.compute_instance_with_attached_disk_cpu_platforms}"
}

output "compute_instance_with_attached_disk_internal_ip_addresses" {
    description = "The internal ip address of the instance, either manually or dynamically assigned."
    value       = "${module.compute_instance.compute_instance_with_attached_disk_internal_ip_addresses}"
}

output "compute_instance_with_attached_disk_external_ip_addresses" {
    description = "If the instance has an access config, either the given external ip (in the nat_ip field) or the ephemeral (generated) ip (if you didn't provide one)."
    value       = "${module.compute_instance.compute_instance_with_attached_disk_external_ip_addresses}"
}

#########################################################################################################
############################################## health check #############################################
#########################################################################################################
output "http_name" {
    description = "Name of http HC"
    value       = "${module.compute_health_check.http_name}"
}

output "http_self_link" {
    description = "self_link of http HC"
    value       = "${module.compute_health_check.http_self_link}"
}

output "https_name" {
    description = "Name of https HC"
    value       = "${module.compute_health_check.https_name}"
}

output "https_self_link" {
    description = "self_link of https HC"
    value       = "${module.compute_health_check.https_self_link}"
}

output "ssl_name" {
    description = "Name of ssl HC"
    value       = "${module.compute_health_check.ssl_name}"
}

output "ssl_self_link" {
    description = "self_link of ssl HC"                     
    value       = "${module.compute_health_check.ssl_self_link}"
}

#########################################################################################################
############################################## target pool ##############################################
#########################################################################################################
output "self_link" {
    description = "self link for target pool"
    value       = "${module.compute_target_pool.self_link}"
}

output "name" {
    description = "Name of target pool"
    value       = "${module.compute_target_pool.name}"
}

#########################################################################################################
############################################ forwarding rule ############################################
#########################################################################################################
output "forwarding_rule_name" {
    description = "Name of google_compute forwarding rule"
    value       = "${module.compute_forwarding_rule.forwarding_rule_name}"
}

output "forwarding_rule_self_link" {
    description = "Self link"
    value       = "${module.compute_forwarding_rule.forwarding_rule_self_link}"
}

#########################################################################################################
################################################ FireWall ###############################################
#########################################################################################################
output "all_ingress_firewall_name" {
    description = "Name of google compute firewall"
    value       = "${module.compute_firewall.all_ingress_firewall_name}"
}

output "all_ingress_firewall_self_link" {
    description = "Self link"
    value       = "${module.compute_firewall.all_ingress_firewall_self_link}"
}

output "needed_ingress_firewall_name" {
    description = "Name of google compute firewall"
    value       = "${module.compute_firewall.needed_ingress_firewall_name}"
}

output "needed_ingress_firewall_self_link" {
    description = "Self link"
    value       = "${module.compute_firewall.needed_ingress_firewall_self_link}"
}

output "all_egress_firewall_name" {
    description = "Name of google compute firewall"
    value       = "${module.compute_firewall.all_egress_firewall_name}"
}

output "all_egress_firewall_self_link" {
    description = "Self link"
    value       = "${module.compute_firewall.all_egress_firewall_self_link}"
}

output "needed_egress_firewall_name" {
    description = "Name of google compute firewall"
    value       = "${module.compute_firewall.needed_egress_firewall_name}"
}

output "needed_egress_firewall_self_link" {
    description = "Self link"
    value       = "${module.compute_firewall.needed_egress_firewall_self_link}"
}

