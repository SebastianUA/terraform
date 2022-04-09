#---------------------------------------------------
# AWS S3 bucket acl
#---------------------------------------------------
resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  count = var.enable_s3_bucket_acl ? 1 : 0

  bucket = var.s3_bucket_acl_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_acl_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  acl                   = var.s3_bucket_acl_acl
  expected_bucket_owner = var.s3_bucket_acl_expected_bucket_owner

  dynamic "access_control_policy" {
    iterator = access_control_policy
    for_each = var.s3_bucket_acl_access_control_policy

    content {
      dynamic "owner" {
        iterator = owner
        for_each = lookup(access_control_policy.value, "owner", [])

        content {
          id = lookup(owner.value, "id", null)

          display_name = lookup(owner.value, "display_name", null)
        }
      }

      dynamic "grant" {
        iterator = grant
        for_each = lookup(access_control_policy.value, "grant", [])

        content {
          permission = lookup(grant.value, "permission", null)

          dynamic "grantee" {
            iterator = grantee
            for_each = lookup(grant.value, "grantee", [])

            content {
              type = lookup(grantee.value, "type", null)

              id            = lookup(grantee.value, "id", null)
              email_address = lookup(grantee.value, "email_address", null)
              uri           = lookup(grantee.value, "uri", null)
            }
          }
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}


