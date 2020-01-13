#---------------------------------------------------
# Create AWS elastic beanstalk environment
#---------------------------------------------------
resource "aws_elastic_beanstalk_environment" "elastic_beanstalk_environment" {
    count                       = var.enable_elastic_beanstalk_environment ? 1 : 0

    name                        = var.elastic_beanstalk_environment_name != "" ? var.elastic_beanstalk_environment_name : "${lower(var.name)}-eb-env-${lower(var.environment)}"
    description                 = var.elastic_beanstalk_environment_description != "" ? var.elastic_beanstalk_environment_description : null
    application                 = var.elastic_beanstalk_application_name != "" ? var.elastic_beanstalk_application_name : aws_elastic_beanstalk_application.elastic_beanstalk_application.0.name
    
    solution_stack_name         = var.solution_stack_name != "" && var.template_name == "" ? var.solution_stack_name : null
    template_name               = var.template_name != "" && var.solution_stack_name == "" ? var.template_name : null
    cname_prefix                = var.cname_prefix != "" ? lower(var.cname_prefix) : null 
    tier                        = var.tier

    dynamic "setting" {
        for_each = var.setting
        content {
            name            = lookup(setting.value, "name", null)
            value           = lookup(setting.value, "value", null)
            namespace       = lookup(setting.value, "namespace", null) 
            resource        = lookup(setting.value, "resource", null)
        }
    }

    #dynamic "all_settings" {
    #    for_each = var.all_settings
    #    content {
    #        name            = lookup(all_settings.value, "name", null)
    #        value           = lookup(all_settings.value, "value", null)
    #        namespace       = lookup(all_settings.value, "namespace", null) 
    #        resource        = lookup(all_settings.value, "resource", null)
    #    }
    #}
    
    platform_arn                = var.platform_arn
    wait_for_ready_timeout      = var.wait_for_ready_timeout
    poll_interval               = var.poll_interval
    version_label               = var.version_label

    tags = merge(
        var.tags,
        {
            "Name"          = var.elastic_beanstalk_environment_name !="" ? "${lower(var.elastic_beanstalk_environment_name)}" : "${lower(var.name)}-eb-env-${lower(var.environment)}"
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = [tags]
    }

    depends_on  = [
        aws_elastic_beanstalk_application.elastic_beanstalk_application,
        #aws_elastic_beanstalk_application_version.elastic_beanstalk_application_version
    ]

}