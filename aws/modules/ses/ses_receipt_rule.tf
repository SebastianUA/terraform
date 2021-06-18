#---------------------------------------------------
# AWS ses receipt rule
#---------------------------------------------------
resource "aws_ses_receipt_rule" "ses_receipt_rule" {
  count = var.enable_ses_receipt_rule ? 1 : 0

  name          = var.ses_receipt_rule_name != "" ? var.ses_receipt_rule_name : "${lower(var.name)}-ses-receipt-rule-${lower(var.environment)}"
  rule_set_name = var.ses_receipt_rule_rule_set_name != "" ? var.ses_receipt_rule_rule_set_name : (var.enable_ses_receipt_rule_set ? element(aws_ses_receipt_rule_set.ses_receipt_rule_set.*.id, 0) : null)

  recipients   = var.ses_receipt_rule_recipients
  enabled      = var.ses_receipt_rule_enabled
  scan_enabled = var.ses_receipt_rule_scan_enabled
  after        = var.ses_receipt_rule_after
  tls_policy   = var.ses_receipt_rule_tls_policy

  dynamic "add_header_action" {
    iterator = add_header_action
    for_each = var.ses_receipt_rule_add_header_action

    content {
      header_name  = lookup(add_header_action.value, "header_name", null)
      header_value = lookup(add_header_action.value, "header_value", null)
      position     = lookup(add_header_action.value, "position", null)
    }
  }

  dynamic "bounce_action" {
    iterator = bounce_action
    for_each = var.ses_receipt_rule_bounce_action

    content {
      message         = lookup(bounce_action.value, "message", null)
      sender          = lookup(bounce_action.value, "sender", null)
      smtp_reply_code = lookup(bounce_action.value, "smtp_reply_code", null)
      position        = lookup(bounce_action.value, "position", null)

      status_code = lookup(bounce_action.value, "status_code", null)
      topic_arn   = lookup(bounce_action.value, "topic_arn", null)
    }
  }

  dynamic "lambda_action" {
    iterator = lambda_action
    for_each = var.ses_receipt_rule_lambda_action

    content {
      function_arn = lookup(lambda_action.value, "function_arn", null)
      position     = lookup(lambda_action.value, "position", null)

      invocation_type = lookup(lambda_action.value, "invocation_type", null)
      topic_arn       = lookup(lambda_action.value, "topic_arn", null)
    }
  }

  dynamic "s3_action" {
    iterator = s3_action
    for_each = var.ses_receipt_rule_s3_action

    content {
      bucket_name = lookup(s3_action.value, "bucket_name", null)
      position    = lookup(s3_action.value, "position", null)

      kms_key_arn       = lookup(s3_action.value, "kms_key_arn", null)
      object_key_prefix = lookup(s3_action.value, "object_key_prefix", null)
      topic_arn         = lookup(s3_action.value, "topic_arn", null)
    }
  }

  dynamic "sns_action" {
    iterator = sns_action
    for_each = var.ses_receipt_rule_sns_action

    content {
      topic_arn = lookup(sns_action.value, "topic_arn", null)
      position  = lookup(sns_action.value, "position", null)

      encoding = lookup(sns_action.value, "encoding", null)
    }
  }

  dynamic "stop_action" {
    iterator = stop_action
    for_each = var.ses_receipt_rule_stop_action

    content {
      scope    = lookup(stop_action.value, "scope", null)
      position = lookup(stop_action.value, "position", null)

      topic_arn = lookup(stop_action.value, "topic_arn", null)
    }
  }

  dynamic "workmail_action" {
    iterator = workmail_action
    for_each = var.ses_receipt_rule_workmail_action

    content {
      organization_arn = lookup(workmail_action.value, "organization_arn", null)
      position         = lookup(workmail_action.value, "position", null)

      topic_arn = lookup(workmail_action.value, "topic_arn", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ses_receipt_rule_set.ses_receipt_rule_set
  ]
}
