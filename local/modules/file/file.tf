#---------------------------------------------------
# Save content to file
#---------------------------------------------------
resource "local_file" "file" {
  count = var.enable_file ? 1 : 0

  filename = var.file_filename

  content              = var.file_content
  content_base64       = var.file_content_base64
  source               = var.file_source
  file_permission      = var.file_file_permission
  directory_permission = var.file_directory_permission

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}