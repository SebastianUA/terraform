output "name" {
    description = "Name of google compute image"
    value       = "${module.compute_image.name}"
}

output "self_link" {
    description = ""
    value       = "${module.compute_image.self_link}"
}

