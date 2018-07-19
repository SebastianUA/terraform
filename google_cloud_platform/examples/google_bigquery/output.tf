#---------------------------------------------------------------------------
# Google bigquery dataset
#---------------------------------------------------------------------------
output "bigquery_dataset_dataset_id" {
    description = "dataset_idof google_bigquery_dataset"
    value       = "${module.google_bigquery.google_bigquery_dataset_dataset_id}"
}
    
output "bigquery_dataset_id" {
    description = "ID"
    value       = "${module.google_bigquery.google_bigquery_dataset_id}"
}

output "bigquery_dataset_etag" {
    description = "etag"
    value       = "${module.google_bigquery.google_bigquery_dataset_etag}"
}

output "bigquery_dataset_friendly_name" {
    description = "friendly_name"
    value       = "${module.google_bigquery.google_bigquery_dataset_friendly_name}"
}

output "bigquery_dataset_self_link" {
    description = "self_link"
    value       = "${module.google_bigquery.google_bigquery_dataset_self_link}"
}

output "bigquery_dataset_creation_time" {
    description = "creation_time"
    value       = "${module.google_bigquery.google_bigquery_dataset_creation_time}"
}

#---------------------------------------------------------------------------
# Google bigquery table
#---------------------------------------------------------------------------
output "bigquery_table_etag" {
    description = "etag"
    value       = "${module.google_bigquery.google_bigquery_table_etag}"
}

output "bigquery_table_self_link" {
    description = "self_link"
    value       = "${module.google_bigquery.google_bigquery_table_self_link}"
}

output "bigquery_table_table_id" {
    description = "table_id"
    value       = "${module.google_bigquery.google_bigquery_table_table_id}"
}

output "bigquery_table_view_etag" {
    description = "etag"
    value       = "${module.google_bigquery.google_bigquery_table_view_etag}"
}

output "bigquery_table_view_self_link" {
    description = "self_link"
    value       = "${module.google_bigquery.google_bigquery_table_view_self_link}"
}

output "bigquery_table_view_table_id" {
    description = "table_id"
    value       = "${module.google_bigquery.google_bigquery_table_view_table_id}"
}

