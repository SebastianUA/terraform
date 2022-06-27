#---------------------------------------------------
# Save sensitive content to file
#---------------------------------------------------
resource "local_sensitive_file" "sensitive_file" {
  count = var.enable_sensitive_file ? 1 : 0

  filename = var.sensitive_file_filename

  content              = var.sensitive_file_content
  content_base64       = var.sensitive_file_content_base64
  source               = var.sensitive_file_source
  file_permission      = var.sensitive_file_file_permission
  directory_permission = var.sensitive_file_directory_permission

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}