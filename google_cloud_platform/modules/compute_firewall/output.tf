output "all_ingress_firewall_name" {
    description = "Name of google compute firewall"
    value       = "${google_compute_firewall.compute_firewall_all_ingress.*.name}"
}

output "all_ingress_firewall_self_link" {
    description = "Self link"
    value       = "${google_compute_firewall.compute_firewall_all_ingress.*.self_link}"
}

output "needed_ingress_firewall_name" {
    description = "Name of google compute firewall"
    value       = "${google_compute_firewall.compute_firewall_needed_ingress.*.name}"
}

output "needed_ingress_firewall_self_link" {
    description = "Self link"
    value       = "${google_compute_firewall.compute_firewall_needed_ingress.*.self_link}"
}

output "all_egress_firewall_name" {
    description = "Name of google compute firewall"
    value       = "${google_compute_firewall.compute_firewall_all_egress.*.name}"
}

output "all_egress_firewall_self_link" {
    description = "Self link"
    value       = "${google_compute_firewall.compute_firewall_all_egress.*.self_link}"
}

output "needed_egress_firewall_name" {
    description = "Name of google compute firewall"
    value       = "${google_compute_firewall.compute_firewall_needed_egress.*.name}"
}

output "needed_egress_firewall_self_link" {
    description = "Self link"
    value       = "${google_compute_firewall.compute_firewall_needed_egress.*.self_link}"
}

