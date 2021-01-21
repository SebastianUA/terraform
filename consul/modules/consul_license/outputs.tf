#---------------------------------------------------
# Consul license
#---------------------------------------------------
output "consul_license_id" {
  description = "ID of Counsul license"
  value       = element(concat(consul_license.license.*.id, [""]), 0)
}

output "consul_license_valid" {
  description = "Whether the license is valid."
  value       = element(concat(consul_license.license.*.valid, [""]), 0)
}

output "consul_license_license_id" {
  description = "The ID of the license used."
  value       = element(concat(consul_license.license.*.license_id, [""]), 0)
}

output "consul_license_customer_id" {
  description = "The ID of the customer the license is attached to."
  value       = element(concat(consul_license.license.*.customer_id, [""]), 0)
}

output "consul_license_installation_id" {
  description = "The ID of the current installation."
  value       = element(concat(consul_license.license.*.installation_id, [""]), 0)
}

output "consul_license_issue_time" {
  description = "The date the license was issued."
  value       = element(concat(consul_license.license.*.issue_time, [""]), 0)
}

output "consul_license_start_time" {
  description = "The start time of the license."
  value       = element(concat(consul_license.license.*.start_time, [""]), 0)
}

output "consul_license_expiration_time" {
  description = "The expiration time of the license."
  value       = element(concat(consul_license.license.*.expiration_time, [""]), 0)
}

output "consul_license_product" {
  description = "The product for which the license is valid."
  value       = element(concat(consul_license.license.*.product, [""]), 0)
}

output "consul_license_features" {
  description = "The features for which the license is valid."
  value       = element(concat(consul_license.license.*.features, [""]), 0)
}

output "consul_license_warnings" {
  description = "A list of warning messages regarding the license validity."
  value       = element(concat(consul_license.license.*.warnings, [""]), 0)
}
