#---------------------------------------------------
# AWS Appsync resolver
#---------------------------------------------------
resource "aws_appsync_resolver" "appsync_resolver" {
  count = var.enable_appsync_resolver ? 1 : 0

  api_id            = var.appsync_resolver_api_id != "" && ! var.enable_appsync_graphql_api ? lower(var.appsync_resolver_api_id) : element(concat(aws_appsync_graphql_api.appsync_graphql_api.*.id, [""]), 0)
  type              = var.appsync_resolver_type
  field             = var.appsync_resolver_field
  request_template  = var.appsync_resolver_request_template
  response_template = var.appsync_resolver_response_template

  data_source = var.appsync_resolver_data_source != "" && ! var.enable_appsync_datasource ? var.appsync_resolver_data_source : element(concat(aws_appsync_datasource.appsync_datasource.*.name, [""]), 0)
  kind        = var.appsync_resolver_kind != null ? upper(var.appsync_resolver_kind) : var.appsync_resolver_kind

  dynamic "pipeline_config" {
    iterator = pipelineconfig
    for_each = var.appsync_resolver_pipeline_config
    content {
      functions = lookup(pipelineconfig.value, "functions", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_appsync_graphql_api.appsync_graphql_api,
    aws_appsync_datasource.appsync_datasource
  ]
}
