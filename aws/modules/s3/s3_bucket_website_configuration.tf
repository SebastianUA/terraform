#---------------------------------------------------
# S3 bucket website configuration
#---------------------------------------------------
resource "aws_s3_bucket_website_configuration" "s3_bucket_website_configuration" {
  count = var.enable_s3_bucket_website_configuration ? 1 : 0

  bucket = var.s3_bucket_website_configuration_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_website_configuration_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  dynamic "index_document" {
    iterator = index_document
    for_each = length(keys(var.s3_bucket_website_configuration_index_document)) > 0 ? [var.s3_bucket_website_configuration_index_document] : []

    content {
      suffix = lookup(index_document.value, "suffix", null)
    }
  }

  dynamic "error_document" {
    iterator = error_document
    for_each = length(keys(var.s3_bucket_website_configuration_error_document)) > 0 ? [var.s3_bucket_website_configuration_error_document] : []

    content {
      key = lookup(error_document.value, "key", null)
    }
  }

  dynamic "routing_rule" {
    iterator = routing_rule
    for_each = var.s3_bucket_website_configuration_routing_rule

    content {
      dynamic "condition" {
        iterator = condition
        for_each = length(keys(lookup(routing_rule.value, "condition", {}))) > 0 ? [lookup(routing_rule.value, "condition", {})] : []

        content {
          key_prefix_equals               = lookup(condition.value, "key_prefix_equals", null)
          http_error_code_returned_equals = lookup(condition.value, "http_error_code_returned_equals", null)
        }
      }
      dynamic "redirect" {
        iterator = redirect
        for_each = length(keys(lookup(routing_rule.value, "redirect", {}))) > 0 ? [lookup(routing_rule.value, "redirect", {})] : []

        content {
          host_name               = lookup(redirect.value, "host_name", null)
          http_redirect_code      = lookup(redirect.value, "http_redirect_code", null)
          protocol                = lookup(redirect.value, "protocol", null)
          replace_key_prefix_with = lookup(redirect.value, "replace_key_prefix_with", null)
          replace_key_with        = lookup(redirect.value, "replace_key_with", null)
        }
      }
    }
  }

  expected_bucket_owner = var.s3_bucket_website_configuration_expected_bucket_owner

  dynamic "redirect_all_requests_to" {
    iterator = redirect_all_requests_to
    for_each = var.s3_bucket_website_configuration_redirect_all_requests_to

    content {
      host_name = lookup(redirect_all_requests_to.value, "host_name", null)

      protocol = lookup(redirect_all_requests_to.value, "protocol", null)
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