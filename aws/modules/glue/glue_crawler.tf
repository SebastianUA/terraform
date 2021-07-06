#---------------------------------------------------
# AWS Glue crawler
#---------------------------------------------------
resource "aws_glue_crawler" "glue_crawler" {
  count = var.enable_glue_crawler ? 1 : 0

  name          = var.glue_crawler_name != "" ? lower(var.glue_crawler_name) : "${lower(var.name)}-glue-crawler-${lower(var.environment)}"
  database_name = var.glue_crawler_database_name != "" && !var.enable_glue_catalog_database ? var.glue_crawler_database_name : element(concat(aws_glue_catalog_database.glue_catalog_database.*.name, [""]), 0)
  role          = var.glue_crawler_role

  description            = var.glue_crawler_description
  classifiers            = var.glue_crawler_classifiers
  configuration          = var.glue_crawler_configuration
  schedule               = var.glue_crawler_schedule
  security_configuration = var.glue_crawler_security_configuration != "" && !var.enable_glue_security_configuration ? var.glue_crawler_security_configuration : element(concat(aws_glue_security_configuration.glue_security_configuration.*.id, [""]), 0)
  table_prefix           = var.glue_crawler_table_prefix

  dynamic "dynamodb_target" {
    iterator = dynamodb_target
    for_each = var.glue_crawler_dynamodb_target

    content {
      path = lookup(dynamodb_target.value, "path", null)
    }
  }

  dynamic "jdbc_target" {
    iterator = jdbc_target
    for_each = var.glue_crawler_jdbc_target

    content {
      connection_name = lookup(jdbc_target.value, "connection_name", null)
      path            = lookup(jdbc_target.value, "path", null)
      exclusions      = lookup(jdbc_target.value, "exclusions", null)
    }
  }

  dynamic "s3_target" {
    iterator = s3_target
    for_each = var.glue_crawler_s3_target

    content {
      path       = lookup(s3_target.value, "path", null)
      exclusions = lookup(s3_target.value, "exclusions", null)
    }
  }

  dynamic "catalog_target" {
    iterator = catalog_target
    for_each = length(var.glue_crawler_catalog_target) > 0 ? [var.glue_crawler_catalog_target] : []

    content {
      database_name = lookup(catalog_target.value, "database_name", element(concat(aws_glue_catalog_database.glue_catalog_database.*.id, [""]), 0))
      tables        = lookup(catalog_target.value, "tables", element(concat(aws_glue_catalog_table.glue_catalog_table.*.id, [""]), 0))
    }
  }

  dynamic "schema_change_policy" {
    iterator = schema_change_policy
    for_each = var.glue_crawler_schema_change_policy

    content {
      delete_behavior = lookup(schema_change_policy.value, "delete_behavior", "DEPRECATE_IN_DATABASE")
      update_behavior = lookup(schema_change_policy.value, "update_behavior", "UPDATE_IN_DATABASE")
    }
  }

  dynamic "mongodb_target" {
    iterator = mongodb_target
    for_each = var.glue_crawler_mongodb_target

    content {
      connection_name = lookup(mongodb_target.value, "connection_name", null)

      path     = lookup(mongodb_target.value, "path", null)
      scan_all = lookup(mongodb_target.value, "scan_all", null)
    }
  }

  dynamic "lineage_configuration" {
    iterator = lineage_configuration
    for_each = var.glue_crawler_lineage_configuration

    content {
      crawler_lineage_settings = lookup(lineage_configuration.value, "crawler_lineage_settings", null)
    }
  }

  dynamic "recrawl_policy" {
    iterator = recrawl_policy
    for_each = var.glue_crawler_recrawl_policy

    content {
      recrawl_behavior = lookup(recrawl_policy.value, "recrawl_behavior", null)
    }
  }

  dynamic "schema_change_policy" {
    iterator = schema_change_policy
    for_each = var.glue_crawler_schema_change_policy

    content {
      recrawl_behavior = lookup(schema_change_policy.value, "recrawl_behavior", null)
    }
  }

  tags = merge(
    {
      Name = var.glue_crawler_name != "" ? lower(var.glue_crawler_name) : "${lower(var.name)}-glue-crawler-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_glue_catalog_database.glue_catalog_database,
    aws_glue_security_configuration.glue_security_configuration,
    aws_glue_catalog_table.glue_catalog_table
  ]
}
