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

