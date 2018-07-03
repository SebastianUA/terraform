output "forwarding_rule_name" {
    description = "Name of google_compute forwarding rule"
    value       = "${google_compute_forwarding_rule.compute_forwarding_rule.*.name}"
}

output "forwarding_rule_self_link" {
    description = "Self link"
    value       = "${google_compute_forwarding_rule.compute_forwarding_rule.*.self_link}"
}

