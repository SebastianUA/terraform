#---------------------------------------------------
# AWS API Gateway usage plan key
#---------------------------------------------------
resource "aws_api_gateway_usage_plan_key" "api_gateway_usage_plan_key" {
    count           = var.enable_api_gateway_usage_plan_key ? 1 : 0

    key_id          = var.api_gateway_usage_plan_key_key_id != "" && !var.enable_api_gateway_api_key ? var.api_gateway_usage_plan_key_key_id : element(concat(aws_api_gateway_api_key.api_gateway_api_key.*.id, [""]), 0)
    key_type        = upper(var.api_gateway_usage_plan_key_key_type)
    usage_plan_id   = var.api_gateway_usage_plan_key_usage_plan_id != "" && !var.enable_api_gateway_usage_plan ? var.api_gateway_usage_plan_key_usage_plan_id : element(concat(aws_api_gateway_usage_plan.api_gateway_usage_plan.*.id, [""]), 0)

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = [
        aws_api_gateway_api_key.api_gateway_api_key,
        aws_api_gateway_usage_plan.api_gateway_usage_plan
    ]
}
