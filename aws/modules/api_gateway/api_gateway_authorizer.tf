#---------------------------------------------------
# AWS API Gateway authorizer
#---------------------------------------------------
resource "aws_api_gateway_authorizer" "api_gateway_authorizer" {
    count                               = var.enable_api_gateway_authorizer ? 1 : 0

    name                                = var.api_gateway_authorizer_name != "" ? var.api_gateway_authorizer_name : "${lower(var.name)}-api-gw-authorizer-${lower(var.environment)}"
    rest_api_id                         = var.api_gateway_authorizer_rest_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_authorizer_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)

    authorizer_uri                      = var.api_gateway_authorizer_authorizer_uri
    authorizer_credentials              = var.api_gateway_authorizer_authorizer_credentials
    authorizer_result_ttl_in_seconds    = var.api_gateway_authorizer_authorizer_result_ttl_in_seconds
    identity_source                     = var.api_gateway_authorizer_identity_source
    type                                = upper(var.api_gateway_authorizer_type)
    identity_validation_expression      = var.api_gateway_authorizer_identity_validation_expression
    provider_arns                       = var.api_gateway_authorizer_provider_arns

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                          = [
        aws_api_gateway_rest_api.api_gateway_rest_api
    ]
}
