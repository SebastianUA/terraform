output "google_bigtable_instance_name" {
    description = "Name of google bigtable instance"
    value       = "${google_bigtable_instance.bigtable_instance.*.name}"
}

output "google_bigtable_instance_id" {
    description = "ID"
    value       = "${google_bigtable_instance.bigtable_instance.*.id}"
}

output "google_bigtable_table_name" {
    description = "Name of google_bigtable_table_name"
    value       = "${google_bigtable_table.bigtable_table.*.name}"
}

output "google_bigtable_table_id" {
    description = "ID"
    value       = "${google_bigtable_table.bigtable_table.*.id}"
}
