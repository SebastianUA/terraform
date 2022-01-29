#---------------------------------------------------
# AWS dynamodb table
#---------------------------------------------------
resource "aws_dynamodb_table" "dynamodb_table" {
  count = var.enable_dynamodb_table ? 1 : 0

  name     = var.dynamodb_table_name != "" ? lower(var.dynamodb_table_name) : "${lower(var.name)}-dynamodb-table-${lower(var.environment)}"
  hash_key = var.dynamodb_table_hash_key

  dynamic "attribute" {
    iterator = attribute
    for_each = var.dynamodb_table_attribute

    content {
      name = lookup(attribute.value, "name", null)
      type = lookup(attribute.value, "type", null)
    }
  }

  billing_mode     = upper(var.dynamodb_table_billing_mode)
  range_key        = var.dynamodb_table_range_key
  write_capacity   = var.dynamodb_table_write_capacity
  read_capacity    = var.dynamodb_table_read_capacity
  stream_enabled   = var.dynamodb_table_stream_enabled
  stream_view_type = var.dynamodb_table_stream_view_type != null ? upper(var.dynamodb_table_stream_view_type) : var.dynamodb_table_stream_view_type

  dynamic "ttl" {
    iterator = ttl
    for_each = var.dynamodb_table_ttl

    content {
      attribute_name = lookup(ttl.value, "attribute_name", null)
      enabled        = lookup(ttl.value, "enabled", null)
    }
  }

  dynamic "local_secondary_index" {
    iterator = localsecondaryindex
    for_each = var.dynamodb_table_local_secondary_index

    content {
      name            = lookup(localsecondaryindex.value, "name", null)
      range_key       = lookup(localsecondaryindex.value, "range_key", null)
      projection_type = lookup(localsecondaryindex.value, "projection_type", null)

      non_key_attributes = lookup(localsecondaryindex.value, "non_key_attributes", null)
    }
  }

  dynamic "global_secondary_index" {
    iterator = globalsecondaryindex
    for_each = var.dynamodb_table_global_secondary_index

    content {
      name            = lookup(globalsecondaryindex.value, "name", null)
      hash_key        = lookup(globalsecondaryindex.value, "hash_key", null)
      projection_type = lookup(globalsecondaryindex.value, "projection_type", null)

      write_capacity     = lookup(globalsecondaryindex.value, "write_capacity", null)
      read_capacity      = lookup(globalsecondaryindex.value, "read_capacity", null)
      range_key          = lookup(globalsecondaryindex.value, "range_key", null)
      non_key_attributes = lookup(globalsecondaryindex.value, "non_key_attributes", null)
    }
  }

  dynamic "server_side_encryption" {
    iterator = serversideencryption
    for_each = var.dynamodb_table_server_side_encryption

    content {
      enabled = lookup(serversideencryption.value, "enabled", null)

      kms_key_arn = lookup(serversideencryption.value, "kms_key_arn", null)
    }
  }

  dynamic "point_in_time_recovery" {
    iterator = pointintimerecovery
    for_each = var.dynamodb_table_point_in_time_recovery

    content {
      enabled = lookup(pointintimerecovery.value, "enabled", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = var.dynamodb_table_timeouts

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.dynamodb_table_name != "" ? lower(var.dynamodb_table_name) : "${lower(var.name)}-dynamodb-table-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
