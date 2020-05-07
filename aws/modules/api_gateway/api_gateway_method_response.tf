#---------------------------------------------------
# AWS API Gateway method response
#---------------------------------------------------
resource "aws_api_gateway_method_response" "api_gateway_method_response" {
    count               = var.enable_api_gateway_method_response ? 1 : 0

    rest_api_id         = var.api_gateway_method_response_rest_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_method_response_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
    resource_id         = var.api_gateway_method_response_resource_id != "" && !var.enable_api_gateway_resource ? var.api_gateway_method_response_resource_id : element(concat(aws_api_gateway_resource.api_gateway_resource.*.id, [""]), 0)
    http_method         = var.api_gateway_method_response_http_method != "" && !var.enable_api_gateway_method ? var.api_gateway_method_response_http_method : element(concat(aws_api_gateway_method.api_gateway_method.*.http_method, [""]), 0)
    status_code         = var.api_gateway_method_response_status_code

    response_models     = var.api_gateway_method_response_response_models
    response_parameters = var.api_gateway_method_response_response_parameters

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_api_gateway_rest_api.api_gateway_rest_api,
        aws_api_gateway_resource.api_gateway_resource,
        aws_api_gateway_method.api_gateway_method
    ]
}
