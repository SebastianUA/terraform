#---------------------------------------------------
# AWS athena named query
#---------------------------------------------------
resource "aws_athena_named_query" "athena_named_query" {
    count           = var.enable_athena_named_query ? 1 : 0

    name            = var.athena_named_query_name != "" ? lower(var.athena_named_query_name) : "${lower(var.name)}-athena-query-${lower(var.environment)}"
    description     = var.athena_named_query_description != "" ? var.athena_named_query_description : null
    workgroup       = var.athena_named_query_workgroup != "" && !var.enable_athena_workgroup ? var.athena_named_query_workgroup : element(concat(aws_athena_workgroup.athena_workgroup.*.id, [""]), 0)
    database        = var.athena_named_query_database != "" && !var.enable_athena_database ? var.athena_named_query_database : element(concat(aws_athena_database.athena_database.*.name, [""]), 0)
    query           = var.athena_named_query_query

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_athena_workgroup.athena_workgroup,
        aws_athena_database.athena_database
    ]
}