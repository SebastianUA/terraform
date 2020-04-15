#---------------------------------------------------
# AWS Appsync api key
#---------------------------------------------------
output "appsync_api_key_id" {
    description = "API Key ID (Formatted as ApiId:Key)"
    value       = element(concat(aws_appsync_api_key.appsync_api_key.*.id, [""]), 0)
}

output "appsync_api_key_key" {
    description = "The API key"
    value       = element(concat(aws_appsync_api_key.appsync_api_key.*.key, [""]), 0)
}

#---------------------------------------------------
# AWS Appsync graphql api
#---------------------------------------------------
output "appsync_graphql_api_id" {
    description = "API ID"
    value       = element(concat(aws_appsync_graphql_api.appsync_graphql_api.*.id, [""]), 0)
}

output "appsync_graphql_api_arn" {
    description = "The ARN"
    value       = element(concat(aws_appsync_graphql_api.appsync_graphql_api.*.arn, [""]), 0)
}

output "appsync_graphql_api_uris" {
    description = "Map of URIs associated with the API. e.g. uris['GRAPHQL'] = https://ID.appsync-api.REGION.amazonaws.com/graphql"
    value       = element(concat(aws_appsync_graphql_api.appsync_graphql_api.*.uris, [""]), 0)
}

#---------------------------------------------------
# AWS Appsync datasource
#---------------------------------------------------
output "appsync_datasource_arn" {
    description = "The ARN"
    value       = element(concat(aws_appsync_datasource.appsync_datasource.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS Appsync function
#---------------------------------------------------
output "appsync_function_id" {
    description = "API Function ID (Formatted as ApiId-FunctionId)"
    value       = element(concat(aws_appsync_function.appsync_function.*.id, [""]), 0)
}

output "appsync_function_arn" {
    description = "The ARN of the Function object."
    value       = element(concat(aws_appsync_function.appsync_function.*.arn, [""]), 0)
}

output "appsync_function_function_id" {
    description = "A unique ID representing the Function object."
    value       = element(concat(aws_appsync_function.appsync_function.*.function_id, [""]), 0)
}

#---------------------------------------------------
# AWS Appsync resolver
#---------------------------------------------------
output "appsync_resolver_arn" {
    description = "The ARN"
    value       = element(concat(aws_appsync_resolver.appsync_resolver.*.arn, [""]), 0)
}
