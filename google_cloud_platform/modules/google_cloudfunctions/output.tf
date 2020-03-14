output "google_cloudfunctions_function_http_name" {
    description = "Name of google cloudfunctions for http function"
    value       = "${google_cloudfunctions_function.cloudfunctions_function_http.*.name}"
}

output "google_cloudfunctions_function_https_name" {
    description = "Name of google cloudfunctions for https function"
    value       = "${google_cloudfunctions_function.cloudfunctions_function_https.*.name}"
}

output "google_cloudfunctions_function_http_id" {
    description = "ID"
    value       = "${google_cloudfunctions_function.cloudfunctions_function_http.*.id}"
}

output "google_cloudfunctions_function_https_id" {
    description = "ID"
    value       = "${google_cloudfunctions_function.cloudfunctions_function_https.*.id}"
}
