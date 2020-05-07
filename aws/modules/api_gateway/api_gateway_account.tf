#---------------------------------------------------
# AWS API Gateway account
#---------------------------------------------------
resource "aws_api_gateway_account" "api_gateway_account" {
    count                       = var.enable_api_gateway_account ? 1 : 0

    cloudwatch_role_arn         = var.api_gateway_account_cloudwatch_role_arn

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = []
}
