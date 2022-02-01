#---------------------------------------------------
# Heroku app
#---------------------------------------------------
resource "heroku_app" "app" {
  count = var.enable_app ? 1 : 0

  name   = var.app_name
  region = var.app_region

  stack      = var.app_stack
  buildpacks = var.app_buildpacks

  config_vars           = var.app_config_vars
  sensitive_config_vars = var.app_sensitive_config_vars

  space            = var.app_space
  internal_routing = var.app_internal_routing
  acm              = var.app_acm

  dynamic "organization" {
    iterator = organization
    for_each = var.app_organization

    content {
      name     = lookup(organization.value, "name", null)
      locked   = lookup(organization.value, "locked", null)
      personal = lookup(organization.value, "personal", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
