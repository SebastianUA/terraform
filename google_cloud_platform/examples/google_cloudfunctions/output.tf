output "cloudfunctions_function_http_name" {
    description = "Name of google cloudfunctions for http function"
    value       = "${module.google_cloudfunctions.google_cloudfunctions_function_http_name}"
}

output "cloudfunctions_function_https_name" {
    description = "Name of google cloudfunctions for https function"
    value       = "${module.google_cloudfunctions.google_cloudfunctions_function_https_name}"
}

output "cloudfunctions_function_http_id" {
    description = "ID"
    value       = "${module.google_cloudfunctions.google_cloudfunctions_function_http_id}"
}

output "cloudfunctions_function_https_id" {
    description = "ID"
    value       = "${module.google_cloudfunctions.google_cloudfunctions_function_https_id}"
}

