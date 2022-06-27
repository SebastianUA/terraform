#---------------------------------------------------
# Local file
#---------------------------------------------------
output "file_id" {
  description = "The ID of file"
  value       = element(concat(local_file.file.*.id, [""]), 0)
}

#---------------------------------------------------
# Local sensitive file
#---------------------------------------------------
output "sensitive_file_id" {
  description = "The ID of sensitive file"
  value       = element(concat(local_sensitive_file.sensitive_file.*.id, [""]), 0)
}
