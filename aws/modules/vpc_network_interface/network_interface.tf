#---------------------------------------------------
# AWS VPC network interface
#---------------------------------------------------
resource "aws_network_interface" "network_interface" {
    count               = var.enable_network_interface ? 1 : 0

    subnet_id           = var.network_interface_subnet_id

    description         = var.network_interface_description
    private_ips         = var.network_interface_private_ips
    private_ips_count   = var.network_interface_private_ips_count
    security_groups     = var.network_interface_security_groups
    source_dest_check   = var.network_interface_source_dest_check

    dynamic "attachment" {
        iterator = attachment
        for_each = var.network_interface_attachment
        content {
            instance     = lookup(attachment.value, "instance", null)
            device_index = lookup(attachment.value, "device_index", null)
        }
    }

    tags                = merge(
        {
            "Name"  = var.network_interface_name != "" ? lower(var.network_interface_name) : "${lower(var.name)}-eni-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = []
}
