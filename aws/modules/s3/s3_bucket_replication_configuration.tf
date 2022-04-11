#---------------------------------------------------
# S3 bucket replication configuration
#---------------------------------------------------
resource "aws_s3_bucket_replication_configuration" "s3_bucket_replication_configuration" {
  count = var.enable_s3_bucket_replication_configuration ? 1 : 0

  bucket = var.s3_bucket_replication_configuration_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_replication_configuration_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)
  role   = var.s3_bucket_replication_configuration_role

  dynamic "rule" {
    iterator = rule
    for_each = var.s3_bucket_replication_configuration_rule

    content {
      status = lookup(rule.value, "status", null)

      dynamic "destination" {
        iterator = destination
        for_each = length(keys(lookup(rule.value, "destination", {}))) > 0 ? [lookup(rule.value, "destination", {})] : []

        content {
          bucket = lookup(destination.value, "bucket", null)

          account       = lookup(destination.value, "account", null)
          storage_class = lookup(destination.value, "storage_class", null)
        }
      }

      id       = lookup(rule.value, "id", null)
      prefix   = lookup(rule.value, "prefix", null)
      priority = lookup(rule.value, "priority", null)

      // dynamic "access_control_translation" {
      //   iterator = access_control_translation
      //   for_each = length(keys(lookup(rule.value, "access_control_translation", {}))) > 0 ? [lookup(rule.value, "access_control_translation", {})] : []

      //   content {
      //     owner = lookup(access_control_translation.value, "owner", null)
      //   }
      // }

      // dynamic "encryption_configuration" {
      //   iterator = encryption_configuration
      //   for_each = length(keys(lookup(rule.value, "encryption_configuration", {}))) > 0 ? [lookup(rule.value, "encryption_configuration", {})] : []

      //   content {
      //     replica_kms_key_id = lookup(encryption_configuration.value, "replica_kms_key_id", null)
      //   }
      // }

      // dynamic "metrics" {
      //   iterator = metrics
      //   for_each = length(keys(lookup(rule.value, "metrics", {}))) > 0 ? [lookup(rule.value, "metrics", {})] : []

      //   content {
      //     dynamic "event_threshold" {
      //       iterator = event_threshold
      //       for_each = length(keys(lookup(metrics.value, "event_threshold", {}))) > 0 ? [lookup(metrics.value, "event_threshold", {})] : []

      //       content {
      //         minutes = lookup(event_threshold.value, "minutes", null)
      //       }
      //     }
      //     status = lookup(metrics.value, "status", null)
      //   }
      // }

      // dynamic "replication_time" {
      //   iterator = replication_time
      //   for_each = length(keys(lookup(rule.value, "replication_time", {}))) > 0 ? [lookup(rule.value, "replication_time", {})] : []

      //   content {
      //     status = lookup(replication_time.value, "status", null)

      //     dynamic "time" {
      //       iterator = time
      //       for_each = length(keys(lookup(replication_time.value, "time", {}))) > 0 ? [lookup(replication_time.value, "time", {})] : []

      //       content {
      //         minutes = lookup(time.value, "minutes", null)
      //       }
      //     }
      //   }
      // }

      dynamic "existing_object_replication" {
        iterator = existing_object_replication
        for_each = length(keys(lookup(rule.value, "existing_object_replication", {}))) > 0 ? [lookup(rule.value, "existing_object_replication", {})] : []

        content {
          status = lookup(existing_object_replication.value, "status", null)
        }
      }

      dynamic "delete_marker_replication" {
        iterator = delete_marker_replication
        for_each = length(keys(lookup(rule.value, "delete_marker_replication", {}))) > 0 ? [lookup(rule.value, "delete_marker_replication", {})] : []

        content {
          status = lookup(delete_marker_replication.value, "status", null)
        }
      }

      dynamic "filter" {
        iterator = filter
        for_each = length(keys(lookup(rule.value, "filter", {}))) > 0 ? [lookup(rule.value, "filter", {})] : []

        content {
          dynamic "and" {
            iterator = and
            for_each = lookup(filter.value, "and", [])

            content {
              prefix = lookup(and.value, "prefix", null)
              tags   = lookup(and.value, "tags", null)
            }
          }
          prefix = lookup(filter.value, "prefix", null)

          dynamic "tag" {
            iterator = tag
            for_each = lookup(filter.value, "tag", {})

            content {
              key   = lookup(tag.value, "key", null)
              value = lookup(tag.value, "value", null)
            }
          }
        }
      }

      dynamic "source_selection_criteria" {
        iterator = source_selection_criteria
        for_each = length(keys(lookup(rule.value, "source_selection_criteria", {}))) > 0 ? [lookup(rule.value, "source_selection_criteria", {})] : []

        content {
          dynamic "replica_modifications" {
            iterator = replica_modifications
            for_each = length(keys(lookup(source_selection_criteria.value, "replica_modifications", {}))) > 0 ? [lookup(source_selection_criteria.value, "replica_modifications", {})] : []

            content {
              status = lookup(replica_modifications.value, "status", null)
            }
          }
          dynamic "sse_kms_encrypted_objects" {
            iterator = sse_kms_encrypted_objects
            for_each = length(keys(lookup(source_selection_criteria.value, "sse_kms_encrypted_objects", {}))) > 0 ? [lookup(source_selection_criteria.value, "sse_kms_encrypted_objects", {})] : []

            content {
              status = lookup(sse_kms_encrypted_objects.value, "status", null)
            }
          }
        }
      }

    }
  }

  token = var.s3_bucket_replication_configuration_token

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}