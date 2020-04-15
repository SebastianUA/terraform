#---------------------------------------------------
# AWS Appsync function
#---------------------------------------------------
resource "aws_appsync_function" "appsync_function" {
    count                       = var.enable_appsync_function ? 1 : 0

    name                        = var.appsync_function_name != "" ? lower(var.appsync_function_name) : "${lower(var.name)}-appsync-function-${lower(var.environment)}"
    api_id                      = var.appsync_function_api_id != "" && !var.enable_appsync_graphql_api ? lower(var.appsync_function_api_id) : element(concat(aws_appsync_graphql_api.appsync_graphql_api.*.id, [""]), 0)
    data_source                 = var.appsync_function_data_source != "" && !var.enable_appsync_datasource ? lower(var.appsync_function_data_source) : element(concat(aws_appsync_datasource.appsync_datasource.*.name, [""]), 0)
    request_mapping_template    = var.appsync_function_request_mapping_template
    response_mapping_template   = var.appsync_function_response_mapping_template

    description                 = var.appsync_function_description
    function_version            = var.appsync_function_function_version

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_appsync_graphql_api.appsync_graphql_api,
        aws_appsync_datasource.appsync_datasource
    ]
}
