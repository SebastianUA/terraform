#---------------------------------------------------------------------------
# Google bigquery dataset
#---------------------------------------------------------------------------
output "google_bigquery_dataset_dataset_id" {
    description = "dataset_id of google_bigquery_dataset"
    value       = "${google_bigquery_dataset.bigquery_dataset.*.dataset_id}"
}

output "google_bigquery_dataset_id" {
    description = "ID"
    value       = "${google_bigquery_dataset.bigquery_dataset.*.id}"
}

output "google_bigquery_dataset_etag" {
    description = "etag"
    value       = "${google_bigquery_dataset.bigquery_dataset.*.etag}"
}

output "google_bigquery_dataset_friendly_name" {
    description = "friendly_name"
    value       = "${google_bigquery_dataset.bigquery_dataset.*.friendly_name}"
}

output "google_bigquery_dataset_self_link" {
    description = "self_link"
    value       = "${google_bigquery_dataset.bigquery_dataset.*.self_link}"
}

output "google_bigquery_dataset_creation_time" {
    description = "creation_time"
    value       = "${google_bigquery_dataset.bigquery_dataset.*.creation_time}"
}

#---------------------------------------------------------------------------
# Google bigquery table
#---------------------------------------------------------------------------
output "google_bigquery_table_etag" {
    description = "etag"
    value       = "${google_bigquery_table.bigquery_table.*.etag}"
}

output "google_bigquery_table_self_link" {
    description = "self_link"
    value       = "${google_bigquery_table.bigquery_table.*.self_link}"
}

output "google_bigquery_table_table_id" {
    description = "table_id"
    value       = "${google_bigquery_table.bigquery_table.*.table_id}"
}

output "google_bigquery_table_view_etag" {
    description = "etag"
    value       = "${google_bigquery_table.bigquery_table_view.*.etag}"
}

output "google_bigquery_table_view_self_link" {
    description = "self_link"
    value       = "${google_bigquery_table.bigquery_table_view.*.self_link}"
}

output "google_bigquery_table_view_table_id" {
    description = "table_id"
    value       = "${google_bigquery_table.bigquery_table_view.*.table_id}"
}

