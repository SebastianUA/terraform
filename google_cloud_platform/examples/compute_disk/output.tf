output "name" {
    description = "Name for google compute disk"
    value       = "${module.compute_disk.name}"
}

output "self_link" {
    description = "Self link for google compute disk"
    value       = "${module.compute_disk.self_link}"
}
