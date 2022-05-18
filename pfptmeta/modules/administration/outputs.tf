#-----------------------------------------------------------
# ProofPoint Meta certificate
#-----------------------------------------------------------
output "certificate_id" {
  description = "The ID of this resource."
  value       = element(concat(pfptmeta_certificate.certificate.*.id, [""]), 0)
}

output "certificate_serial_number" {
  description = "The serial number."
  value       = element(concat(pfptmeta_certificate.certificate.*.serial_number, [""]), 0)
}

output "certificate_status" {
  description = "Certificate state"
  value       = element(concat(pfptmeta_certificate.certificate.*.status, [""]), 0)
}

output "certificate_valid_not_after" {
  description = "The date valid_not_before"
  value       = element(concat(pfptmeta_certificate.certificate.*.valid_not_after, [""]), 0)
}

output "certificate_valid_not_before" {
  description = "The date valid_not_before"
  value       = element(concat(pfptmeta_certificate.certificate.*.valid_not_before, [""]), 0)
}

#-----------------------------------------------------------
# ProofPoint Meta log streaming access bridge
#-----------------------------------------------------------
output "log_streaming_access_bridge_id" {
  description = "The ID of this resource."
  value       = element(concat(pfptmeta_log_streaming_access_bridge.log_streaming_access_bridge.*.id, [""]), 0)
}

output "log_streaming_access_bridge_status" {
  description = "The status"
  value       = element(concat(pfptmeta_log_streaming_access_bridge.log_streaming_access_bridge.*.status, [""]), 0)
}

#-----------------------------------------------------------
# ProofPoint Meta role
#-----------------------------------------------------------
output "role_id" {
  description = "The ID of this resource."
  value       = element(concat(pfptmeta_role.role.*.id, [""]), 0)
}

#-----------------------------------------------------------
# ProofPoint Meta user settings
#-----------------------------------------------------------
output "user_settings_id" {
  description = "The ID of this resource."
  value       = element(concat(pfptmeta_user_settings.user_settings.*.id, [""]), 0)
}