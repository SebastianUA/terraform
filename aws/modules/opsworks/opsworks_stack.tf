#---------------------------------------------------
# AWS opsworks stack
#---------------------------------------------------
resource "aws_opsworks_stack" "opsworks_stack" {
    count                               = var.enable_opsworks_stack ? 1 : 0

    name                                = var.opsworks_stack_name != "" ? lower(var.opsworks_stack_name) : "${lower(var.name)}-opsworks-stack-${lower(var.environment)}"
    region                              = var.region
    service_role_arn                    = var.opsworks_stack_service_role_arn
    default_instance_profile_arn        = var.opsworks_stack_default_instance_profile_arn

    configuration_manager_name          = var.opsworks_stack_configuration_manager_name
    configuration_manager_version       = var.opsworks_stack_configuration_manager_version
    agent_version                       = var.opsworks_stack_agent_version

    dynamic "custom_cookbooks_source" {
        for_each = var.opsworks_stack_custom_cookbooks_source
        content {
            type        = lookup(opsworks_stack_custom_cookbooks_source.value, "type", null)
            url         = lookup(opsworks_stack_custom_cookbooks_source.value, "url", null)
            username    = lookup(opsworks_stack_custom_cookbooks_source.value, "username", null)
            password    = lookup(opsworks_stack_custom_cookbooks_source.value, "password", null)
            ssh_key     = lookup(opsworks_stack_custom_cookbooks_source.value, "ssh_key", null)
            revision    = lookup(opsworks_stack_custom_cookbooks_source.value, "revision", null)
        }
    }

    custom_json                         = var.opsworks_stack_custom_json

    default_availability_zone           = var.opsworks_stack_default_availability_zone
    default_os                          = var.opsworks_stack_default_os
    default_root_device_type            = var.opsworks_stack_default_root_device_type
    default_ssh_key_name                = var.opsworks_stack_default_ssh_key_name
    default_subnet_id                   = var.opsworks_stack_default_subnet_id

    berkshelf_version                   = var.opsworks_stack_berkshelf_version
    manage_berkshelf                    = var.opsworks_stack_manage_berkshelf

    use_custom_cookbooks                = var.opsworks_stack_use_custom_cookbooks
    use_opsworks_security_groups        = var.opsworks_stack_use_opsworks_security_groups

    hostname_theme                      = var.opsworks_stack_hostname_theme
    color                               = var.opsworks_stack_color
    vpc_id                              = var.opsworks_stack_vpc_id

    tags = merge(
        {
            "Name"   = var.opsworks_stack_name != "" ? lower(var.opsworks_stack_name) : "${lower(var.name)}-opsworks-stack-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                          = []
}
