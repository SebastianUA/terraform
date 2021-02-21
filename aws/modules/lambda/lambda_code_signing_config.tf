#---------------------------------------------------
# AWS lambda code signing config
#---------------------------------------------------
resource "aws_lambda_code_signing_config" "lambda_code_signing_config" {
  count = var.enable_code_signing_config ? 1 : 0

  dynamic "allowed_publishers" {
    iterator = allowed_publishers
    for_each = var.code_signing_config_allowed_publishers
    content {
      signing_profile_version_arns = lookup(allowed_publishers.value, "signing_profile_version_arns", null)
    }
  }

  description = var.code_signing_config_description

  dynamic "policies" {
    iterator = policies
    for_each = var.code_signing_config_policies
    content {
      untrusted_artifact_on_deployment = lookup(policies.value, "untrusted_artifact_on_deployment", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}