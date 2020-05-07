#---------------------------------------------------
# AWS API Gateway domain name
#---------------------------------------------------
resource "aws_api_gateway_domain_name" "api_gateway_domain_name" {
    count                       = var.enable_api_gateway_domain_name ? 1 : 0

    domain_name                 = var.api_gateway_domain_name_domain_name != "" ? var.api_gateway_domain_name_domain_name : "${lower(var.name)}-api-gw-domain-name-${lower(var.environment)}"

    security_policy             = var.api_gateway_domain_name_security_policy

    certificate_arn             = var.api_gateway_domain_name_certificate_arn
    certificate_name            = var.api_gateway_domain_name_certificate_name
    certificate_body            = var.api_gateway_domain_name_certificate_body
    certificate_chain           = var.api_gateway_domain_name_certificate_chain
    certificate_private_key     = var.api_gateway_domain_name_certificate_private_key
    regional_certificate_arn    = var.api_gateway_domain_name_regional_certificate_arn
    regional_certificate_name   = var.api_gateway_domain_name_regional_certificate_name

    dynamic "endpoint_configuration" {
        iterator = endpoint_configuration
        for_each = var.api_gateway_domain_name_endpoint_configuration
        content {
            types       = lookup(endpoint_configuration.value, "types", ["EDGE"])
        }
    }

    tags                = merge(
        {
            "Name"  = var.api_gateway_domain_name_domain_name != "" ? var.api_gateway_domain_name_domain_name : "${lower(var.name)}-api-gw-domain-name-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = []
}
