#---------------------------------------------------
# AWS S3 bucket
#---------------------------------------------------
resource "aws_s3_bucket" "s3_bucket" {
  count = var.enable_s3_bucket ? 1 : 0

  bucket        = var.s3_bucket_name != null && var.s3_bucket_prefix == null ? lower(var.s3_bucket_name) : null
  bucket_prefix = var.s3_bucket_prefix != null && var.s3_bucket_name == null ? lower(var.s3_bucket_prefix) : null

  force_destroy = var.s3_bucket_force_destroy
  // acl                 = var.s3_bucket_acl
  // policy              = var.s3_bucket_policy
  // acceleration_status = var.s3_bucket_acceleration_status
  // request_payer       = var.s3_bucket_request_payer

  // dynamic "grant" {
  //   iterator = grant
  //   for_each = var.s3_bucket_grant

  //   content {
  //     type        = lookup(grant.value, "type", null)
  //     permissions = lookup(grant.value, "permissions", null)

  //     id  = lookup(grant.value, "id", null)
  //     uri = lookup(grant.value, "uri", null)
  //   }
  // }

  // dynamic "website" {
  //   iterator = website
  //   for_each = length(var.s3_bucket_website) > 0 ? [var.s3_bucket_website] : []

  //   content {
  //     index_document = lookup(website.value, "index_document", null)

  //     error_document           = lookup(website.value, "error_document", null)
  //     redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
  //     routing_rules            = lookup(website.value, "routing_rules", null)
  //   }
  // }

  // dynamic "lifecycle_rule" {
  //   iterator = lifecycle_rule
  //   for_each = var.s3_bucket_lifecycle_rule

  //   content {
  //     enabled = lifecycle_rule.value.enabled

  //     id                                     = lookup(lifecycle_rule.value, "id", null)
  //     prefix                                 = lookup(lifecycle_rule.value, "prefix", null)
  //     abort_incomplete_multipart_upload_days = lookup(lifecycle_rule.value, "abort_incomplete_multipart_upload_days", null)
  //     tags                                   = lookup(lifecycle_rule.value, "tags", null)

  //     // Supports only 1 block
  //     dynamic "expiration" {
  //       iterator = expiration
  //       for_each = length(keys(lookup(lifecycle_rule.value, "expiration", {}))) > 0 ? [lookup(lifecycle_rule.value, "expiration", {})] : []

  //       content {
  //         days = lookup(expiration.value, "days", null)
  //       }
  //     }

  //     // Supports several blocks
  //     dynamic "transition" {
  //       iterator = transition
  //       for_each = lookup(lifecycle_rule.value, "transition", [])
  //       content {
  //         days          = lookup(transition.value, "days", null)
  //         storage_class = lookup(transition.value, "storage_class", null)
  //       }
  //     }

  //     // Supports only 1 block
  //     dynamic "noncurrent_version_expiration" {
  //       iterator = noncurrent_version_expiration
  //       for_each = length(keys(lookup(lifecycle_rule.value, "noncurrent_version_expiration", {}))) > 0 ? [lookup(lifecycle_rule.value, "noncurrent_version_expiration", {})] : []
  //       content {
  //         days = lookup(noncurrent_version_expiration.value, "days", null)
  //       }
  //     }

  //     // Supports several blocks
  //     dynamic "noncurrent_version_transition" {
  //       iterator = noncurrent_version_transition
  //       for_each = lookup(lifecycle_rule.value, "noncurrent_version_transition", [])
  //       content {
  //         days          = lookup(noncurrent_version_transition.value, "days", null)
  //         storage_class = lookup(noncurrent_version_transition.value, "storage_class", null)
  //       }
  //     }

  //   }
  // }

  // Supports only 1 block
  // dynamic "replication_configuration" {
  //   iterator = replication_configuration
  //   for_each = length(var.s3_bucket_replication_configuration) > 0 ? [var.s3_bucket_replication_configuration] : []

  //   content {
  //     role = lookup(replication_configuration.value, "role", null)

  //     dynamic "rules" {
  //       iterator = rules
  //       for_each = replication_configuration.value.rules

  //       content {
  //         prefix   = lookup(rules.value, "rules_prefix", null)
  //         status   = lookup(rules.value, "rules_status", null)
  //         id       = lookup(rules.value, "rules_id", null)
  //         priority = lookup(rules.value, "rules_priority", null)

  //         dynamic "destination" {
  //           iterator = destination
  //           for_each = length(keys(lookup(rules.value, "destination", {}))) > 0 ? [lookup(rules.value, "destination", {})] : []

  //           content {
  //             bucket = lookup(destination.value, "bucket", null)

  //             storage_class      = lookup(destination.value, "storage_class", null)
  //             replica_kms_key_id = lookup(destination.value, "replica_kms_key_id", null)
  //             account_id         = lookup(destination.value, "account_id", null)

  //             dynamic "access_control_translation" {
  //               iterator = access_control_translation
  //               for_each = length(keys(lookup(destination.value, "access_control_translation", {}))) > 0 ? [lookup(destination.value, "access_control_translation", {})] : []

  //               content {
  //                 owner = lookup(access_control_translation.value, "owner", null)
  //               }
  //             }
  //           }
  //         }

  //         dynamic "source_selection_criteria" {
  //           iterator = source_selection_criteria
  //           for_each = length(keys(lookup(rules.value, "source_selection_criteria", {}))) > 0 ? [lookup(rules.value, "source_selection_criteria", {})] : []
  //           content {

  //             dynamic "sse_kms_encrypted_objects" {
  //               iterator = sse_kms_encrypted_objects
  //               for_each = length(keys(lookup(source_selection_criteria.value, "sse_kms_encrypted_objects", {}))) > 0 ? [lookup(source_selection_criteria.value, "sse_kms_encrypted_objects", {})] : []

  //               content {
  //                 enabled = lookup(sse_kms_encrypted_objects.value, "enabled", null)
  //               }
  //             }
  //           }

  //         }

  //         dynamic "filter" {
  //           iterator = filter
  //           for_each = length(keys(lookup(rules.value, "filter", {}))) > 0 ? [lookup(rules.value, "filter", {})] : []

  //           content {
  //             prefix = lookup(filter.value, "filter", null)
  //             tags   = lookup(filter.value, "tags", null)
  //           }
  //         }
  //       }
  //     }
  //   }
  // }

  // // Supports only 1 block
  // dynamic "server_side_encryption_configuration" {
  //   iterator = server_side_encryption_configuration
  //   for_each = length(var.s3_bucket_server_side_encryption_configuration) > 0 ? [var.s3_bucket_server_side_encryption_configuration] : []

  //   content {
  //     dynamic "rule" {
  //       iterator = rule
  //       for_each = length(keys(lookup(server_side_encryption_configuration.value, "rule", {}))) > 0 ? [lookup(server_side_encryption_configuration.value, "rule", {})] : []

  //       content {
  //         apply_server_side_encryption_by_default {
  //           sse_algorithm = lookup(rule.value, "sse_algorithm", null)

  //           kms_master_key_id = lookup(rule.value, "kms_master_key_id", null)
  //         }
  //       }
  //     }
  //   }
  // }

  // Supports only 1 block
  // dynamic "object_lock_configuration" {
  //   iterator = object_lock_configuration
  //   for_each = length(var.s3_bucket_object_lock_configuration) > 0 ? [var.s3_bucket_object_lock_configuration] : []

  //   content {
  //     object_lock_enabled = object_lock_configuration.value.object_lock_enabled

  //     dynamic "rule" {
  //       iterator = rule
  //       for_each = length(keys(lookup(object_lock_configuration.value, "rule", {}))) > 0 ? [lookup(object_lock_configuration.value, "rule", {})] : []

  //       content {
  //         default_retention {
  //           mode  = lookup(rule.value, "mode", null)
  //           days  = lookup(rule.value, "days", null)
  //           years = lookup(rule.value, "years", null)
  //         }
  //       }
  //     }
  //   }
  // }

  tags = merge(
    {
      Name = var.s3_bucket_name != null && var.s3_bucket_prefix == null ? lower(var.s3_bucket_name) : lower(var.s3_bucket_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
