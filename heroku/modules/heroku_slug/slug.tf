#---------------------------------------------------
# Heroku slug
#---------------------------------------------------
resource "heroku_slug" "slug" {
  count = var.enable_slug ? 1 : 0

  app = var.slug_app

  stack                          = var.slug_stack != "" ? var.slug_stack : "${var.name}-${var.environment}-slug-stack"
  buildpack_provided_description = var.slug_buildpack_provided_description
  checksum                       = var.slug_checksum
  commit                         = var.slug_commit
  commit_description             = var.slug_commit_description
  file_path                      = var.slug_file_path
  file_url                       = var.slug_file_url

  process_types = var.slug_process_types

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
