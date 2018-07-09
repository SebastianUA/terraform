output "name" {
    description = "Name of compute instance template"
    value       = "${module.compute_instance_template.name}"
}

output "self_link" {
    description = "self_link"
    value       = "${module.compute_instance_template.self_link}"
}
