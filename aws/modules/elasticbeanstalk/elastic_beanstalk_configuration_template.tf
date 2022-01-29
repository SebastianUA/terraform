#---------------------------------------------------
# AWS elastic beanstalk configuration template
#---------------------------------------------------
resource "aws_elastic_beanstalk_configuration_template" "elastic_beanstalk_configuration_template" {
  count = var.enable_elastic_beanstalk_configuration_template ? 1 : 0

  name        = var.elastic_beanstalk_configuration_template_name != "" ? var.elastic_beanstalk_configuration_template_name : "${lower(var.name)}-conf-template-${lower(var.environment)}"
  description = var.elastic_beanstalk_configuration_template_description != "" ? var.elastic_beanstalk_configuration_template_description : null

  environment_id      = var.elastic_beanstalk_configuration_template_environment_id != "" ? var.elastic_beanstalk_configuration_template_environment_id : (var.enable_elastic_beanstalk_environment ? aws_elastic_beanstalk_environment.elastic_beanstalk_environment.0.id : null)
  application         = var.elastic_beanstalk_configuration_template_application != "" ? var.elastic_beanstalk_configuration_template_application : (var.enable_elastic_beanstalk_application_version ? aws_elastic_beanstalk_application.elastic_beanstalk_application.0.name : null)
  solution_stack_name = var.elastic_beanstalk_configuration_template_solution_stack_name

  dynamic "setting" {
    iterator = setting
    for_each = var.elastic_beanstalk_configuration_template_setting

    content {
      name      = lookup(setting.value, "name", null)
      value     = lookup(setting.value, "value", null)
      namespace = lookup(setting.value, "namespace", null)
      resource  = lookup(setting.value, "resource", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elastic_beanstalk_environment.elastic_beanstalk_environment,
    aws_elastic_beanstalk_application.elastic_beanstalk_application
  ]
}
