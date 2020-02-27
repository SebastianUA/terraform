#---------------------------------------------------
# Create S3 bucket inventory
#---------------------------------------------------
resource "aws_s3_bucket_inventory" "s3_bucket_inventory" {
    count                       = var.enable_s3_bucket_inventory ? 1 : 0

    name                        = var.s3_bucket_inventory_name != "" ? lower(var.s3_bucket_inventory_name) : "${lower(var.name)}-s3_inventory-${lower(var.environment)}"
    bucket                      = var.s3_bucket_inventory_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_inventory_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)
    included_object_versions    = var.included_object_versions
    enabled                     = var.s3_bucket_inventory_enabled
    optional_fields             = var.s3_bucket_inventory_optional_fields

    schedule {
        frequency = var.schedule_frequency != null ? var.schedule_frequency : null
    }

    destination {
        bucket {
            format      = var.destination_bucket_format != null ? var.destination_bucket_format : null
            bucket_arn  = var.destination_bucket_bucket_arn != null ? var.destination_bucket_bucket_arn : null
            account_id  = var.destination_bucket_account_id != null ? var.destination_bucket_account_id : null
            prefix      = var.destination_bucket_prefix != null ? var.destination_bucket_prefix : null
            encryption {
                sse_kms {
                    key_id  = var.destination_bucket_encryption_sse_kms_key_id != null ? var.destination_bucket_encryption_sse_kms_key_id : null
                }
                # sse_s3 = var.destination_bucket_encryption_sse_s3 != null ? var.destination_bucket_encryption_sse_s3 : null
            }
        }
    }

    dynamic "filter" {
        for_each    = var.s3_bucket_inventory_filter
        content {
            prefix  = lookup(s3_bucket_inventory_filter.value, "prefix", null)
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = [
        aws_s3_bucket.s3_bucket
    ]
}
