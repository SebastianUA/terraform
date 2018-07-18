output "bigtable_instance_name" {
    description = "Name of google bigtable instance"
    value       = "${module.google_bigtable.google_bigtable_instance_name}"
}

output "bigtable_instance_id" {
    description = "ID"
    value       = "${module.google_bigtable.google_bigtable_instance_id}"
}

output "bigtable_table_name" {
    description = "Name of google_bigtable_table_name"
    value       = "${module.google_bigtable.google_bigtable_table_name}"
}

output "bigtable_table_id" {
    description = "ID"
    value       = "${module.google_bigtable.google_bigtable_table_id}"
}

