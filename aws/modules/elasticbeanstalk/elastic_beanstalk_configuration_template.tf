#---------------------------------------------------
# Create AWS elastic beanstalk configuration template
#---------------------------------------------------
resource "aws_elastic_beanstalk_configuration_template" "elastic_beanstalk_configuration_template" {
    count               = var.enable_elastic_beanstalk_configuration_template ? 1 : 0

    name                = var.configuration_template_name != "" ? var.configuration_template_name: "${lower(var.name)}-conf-template-${lower(var.environment)}"
    description         = var.configuration_template_description != "" ? var.configuration_template_description: null

    environment_id      = var.environment_id != "" ? var.environment_id : aws_elastic_beanstalk_environment.elastic_beanstalk_environment.0.id
    application         = var.elastic_beanstalk_application_name != "" ? var.elastic_beanstalk_application_name : aws_elastic_beanstalk_application.elastic_beanstalk_application.0.name
    solution_stack_name = var.solution_stack_name

    dynamic "setting" {
        for_each = var.setting
        content {
            name            = lookup(setting.value, "name", null)
            value           = lookup(setting.value, "value", null)
            namespace       = lookup(setting.value, "namespace", null)
            resource        = lookup(setting.value, "resource", null)
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_elastic_beanstalk_environment.elastic_beanstalk_environment,
        aws_elastic_beanstalk_application.elastic_beanstalk_application
    ]
}
