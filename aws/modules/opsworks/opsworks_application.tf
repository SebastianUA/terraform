#---------------------------------------------------
# AWS opsworks application
#---------------------------------------------------
resource "aws_opsworks_application" "opsworks_application" {
  count = var.enable_opsworks_application ? 1 : 0

  name        = var.opsworks_application_name != "" ? lower(var.opsworks_application_name) : "${lower(var.name)}-opsworks-app-${lower(var.environment)}"
  short_name  = var.opsworks_application_short_name != "" ? lower(var.opsworks_application_short_name) : "opsworks-app"
  description = var.opsworks_application_description != "" ? var.opsworks_application_description : "This is simple opsworks app"

  stack_id = var.opsworks_application_stack_id != "" && ! var.enable_opsworks_stack ? var.opsworks_application_stack_id : element(concat(aws_opsworks_stack.opsworks_stack.*.id, [""]), 0)
  type     = var.opsworks_application_type
  domains  = var.opsworks_application_domains

  data_source_arn           = var.opsworks_application_data_source_arn
  data_source_type          = var.opsworks_application_data_source_type
  data_source_database_name = var.opsworks_application_data_source_database_name

  enable_ssl = var.opsworks_application_enable_ssl

  document_root          = var.opsworks_application_document_root
  auto_bundle_on_deploy  = var.opsworks_application_auto_bundle_on_deploy
  rails_env              = var.opsworks_application_rails_env
  aws_flow_ruby_settings = var.opsworks_application_aws_flow_ruby_settings

  dynamic "environment" {
    for_each = var.opsworks_application_environment
    content {
      key    = lookup(opsworks_application_environment.value, "key", null)
      value  = lookup(opsworks_application_environment.value, "value", null)
      secure = lookup(opsworks_application_environment.value, "secure", null)
    }
  }

  dynamic "app_source" {
    for_each = var.opsworks_application_app_source
    content {
      type     = lookup(opsworks_application_app_source.value, "type", null)
      revision = lookup(opsworks_application_app_source.value, "revision", null)
      url      = lookup(opsworks_application_app_source.value, "url", null)
      username = lookup(opsworks_application_app_source.value, "username", null)
      password = lookup(opsworks_application_app_source.value, "password", null)
      ssh_key  = lookup(opsworks_application_app_source.value, "ssh_key", null)
    }
  }

  dynamic "ssl_configuration" {
    for_each = var.opsworks_application_ssl_configuration
    content {
      private_key = lookup(opsworks_application_ssl_configuration.value, "private_key", null)
      certificate = lookup(opsworks_application_ssl_configuration.value, "certificate", null)
      chain       = lookup(opsworks_application_ssl_configuration.value, "chain", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_opsworks_stack.opsworks_stack
  ]
}
