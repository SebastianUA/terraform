#---------------------------------------------------
# AWS wafregional ipset
#---------------------------------------------------
resource "aws_wafregional_ipset" "wafregional_ipset" {
    count           = var.enable_wafregional_ipset ? 0 : 1

    name            = "${lower(var.name)}-wafregional-ipset-${lower(var.environment)}"

    ip_set_descriptor {
        type    = var.ip_set_descriptors_type
        value   = var.ip_set_descriptors_value
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = []
}
