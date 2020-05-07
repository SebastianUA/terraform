#---------------------------------------------------
# AWS API Gateway integration response
#---------------------------------------------------
resource "aws_api_gateway_integration_response" "api_gateway_integration_response" {
    count               = var.enable_api_gateway_integration_response ? 1 : 0

    rest_api_id         = var.api_gateway_integration_response_rest_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_integration_response_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
    resource_id         = var.api_gateway_integration_response_resource_id != "" && !var.enable_api_gateway_resource ? var.api_gateway_integration_response_resource_id : element(concat(aws_api_gateway_resource.api_gateway_resource.*.id, [""]), 0)
    http_method         = var.api_gateway_integration_response_http_method != "" && !var.enable_api_gateway_method ? var.api_gateway_integration_response_http_method : element(concat(aws_api_gateway_method.api_gateway_method.*.http_method, [""]), 0)
    status_code         = var.api_gateway_integration_response_status_code != "" && !var.enable_api_gateway_method_response ? var.api_gateway_integration_response_status_code : element(concat(aws_api_gateway_method_response.api_gateway_method_response.*.status_code, [""]), 0)

    selection_pattern   = var.api_gateway_integration_response_selection_pattern
    response_templates  = var.api_gateway_integration_response_response_templates
    response_parameters = var.api_gateway_integration_response_response_parameters
    content_handling    = var.api_gateway_integration_response_content_handling

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_api_gateway_rest_api.api_gateway_rest_api,
        aws_api_gateway_resource.api_gateway_resource,
        aws_api_gateway_method.api_gateway_method,
        aws_api_gateway_method_response.api_gateway_method_response
    ]
}
