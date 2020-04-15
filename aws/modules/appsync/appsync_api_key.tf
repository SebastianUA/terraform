#---------------------------------------------------
# AWS Appsync api key
#---------------------------------------------------
resource "aws_appsync_api_key" "appsync_api_key" {
    count       = var.enable_appsync_api_key ? 1 : 0

    api_id      = var.appsync_api_key_api_id != "" && !var.enable_appsync_graphql_api ? lower(var.appsync_api_key_api_id) : element(concat(aws_appsync_graphql_api.appsync_graphql_api.*.id, [""]), 0)

    description = var.appsync_api_key_description
    expires     = var.appsync_api_key_expires

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = [
        aws_appsync_graphql_api.appsync_graphql_api
    ]
}
