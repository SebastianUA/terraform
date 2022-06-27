#---------------------------------------------------
# Local file
#---------------------------------------------------
output "file_id" {
  description = "The ID of file"
  value       = element(concat(local_file.file.*.id, [""]), 0)
}
