#---------------------------------------------------
# AWS API Gateway request validator
#---------------------------------------------------
resource "aws_api_gateway_request_validator" "api_gateway_request_validator" {
    count                           = var.enable_api_gateway_request_validator ? 1 : 0

    name                            = var.api_gateway_request_validator_name != "" ? var.api_gateway_request_validator_name : "${lower(var.name)}-api-gw-request-validator-${lower(var.environment)}"
    rest_api_id                     = var.api_gateway_request_validator_rest_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_request_validator_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
    validate_request_body           = var.api_gateway_request_validator_validate_request_body
    validate_request_parameters     = var.api_gateway_request_validator_validate_request_parameters

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                      = [
        aws_api_gateway_rest_api.api_gateway_rest_api
    ]
}
