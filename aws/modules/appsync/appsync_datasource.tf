#---------------------------------------------------
# AWS Appsync datasource
#---------------------------------------------------
resource "aws_appsync_datasource" "appsync_datasource" {
    count               = var.enable_appsync_datasource ? 1 : 0

    name                = var.appsync_datasource_name != "" ? lower(var.appsync_datasource_name) : "${lower(var.name)}-appsync-datasource-${lower(var.environment)}"
    api_id              = var.appsync_datasource_api_id != "" && !var.enable_appsync_graphql_api ? lower(var.appsync_datasource_api_id) : element(concat(aws_appsync_graphql_api.appsync_graphql_api.*.id, [""]), 0)
    type                = upper(var.appsync_datasource_type)

    description         = var.appsync_datasource_description
    service_role_arn    = var.appsync_datasource_service_role_arn

    dynamic "dynamodb_config" {
        iterator = dynamodbconfig
        for_each = var.appsync_datasource_dynamodb_config
        content {
            table_name              = lookup(dynamodbconfig.value, "table_name", null)

            region                  = lookup(dynamodbconfig.value, "region", null)
            use_caller_credentials  = lookup(dynamodbconfig.value, "use_caller_credentials", null)
        }
    }

    dynamic "elasticsearch_config" {
        iterator = elasticsearchconfig
        for_each = var.appsync_datasource_elasticsearch_config
        content {
            endpoint    = lookup(elasticsearchconfig.value, "endpoint", null)

            region      = lookup(elasticsearchconfig.value, "region", null)
        }
    }

    dynamic "http_config" {
        iterator = httpconfig
        for_each = var.appsync_datasource_http_config
        content {
            endpoint    = lookup(httpconfig.value, "endpoint", null)
        }
    }

    dynamic "lambda_config" {
        iterator = lambdaconfig
        for_each = var.appsync_datasource_lambda_config
        content {
            function_arn    = lookup(lambdaconfig.value, "function_arn", null)
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_appsync_graphql_api.appsync_graphql_api
    ]
}
