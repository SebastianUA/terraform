#---------------------------------------------------
# AWS elastic beanstalk environment
#---------------------------------------------------
resource "aws_elastic_beanstalk_environment" "elastic_beanstalk_environment" {
  count = var.enable_elastic_beanstalk_environment ? 1 : 0

  name        = var.elastic_beanstalk_environment_name != "" ? var.elastic_beanstalk_environment_name : "${lower(var.name)}-eb-env-${lower(var.environment)}"
  description = var.elastic_beanstalk_environment_description != "" ? var.elastic_beanstalk_environment_description : null
  application = var.elastic_beanstalk_environment_application != "" ? var.elastic_beanstalk_application_name : (var.enable_elastic_beanstalk_application ? aws_elastic_beanstalk_application.elastic_beanstalk_application.0.name : null)

  solution_stack_name = var.elastic_beanstalk_environment_solution_stack_name != "" && var.elastic_beanstalk_environment_template_name == "" ? var.elastic_beanstalk_environment_solution_stack_name : null
  template_name       = var.elastic_beanstalk_environment_template_name != "" && var.elastic_beanstalk_environment_solution_stack_name == "" ? var.elastic_beanstalk_environment_template_name : null
  cname_prefix        = var.elastic_beanstalk_environment_cname_prefix != "" ? var.elastic_beanstalk_environment_cname_prefix : null
  tier                = var.elastic_beanstalk_environment_tier

  dynamic "setting" {
    iterator = setting
    for_each = var.elastic_beanstalk_environment_setting

    content {
      name      = lookup(setting.value, "name", null)
      value     = lookup(setting.value, "value", null)
      namespace = lookup(setting.value, "namespace", null)
      resource  = lookup(setting.value, "resource", null)
    }
  }

  platform_arn           = var.elastic_beanstalk_environment_platform_arn
  wait_for_ready_timeout = var.elastic_beanstalk_environment_wait_for_ready_timeout
  poll_interval          = var.elastic_beanstalk_environment_poll_interval
  version_label          = var.elastic_beanstalk_environment_version_label

  tags = merge(
    {
      Name = var.elastic_beanstalk_environment_name != "" ? lower(var.elastic_beanstalk_environment_name) : "${lower(var.name)}-eb-env-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [tags]
  }

  depends_on = [
    aws_elastic_beanstalk_application.elastic_beanstalk_application
  ]
}
