#---------------------------------------------------
# KSM grant
#---------------------------------------------------
resource "aws_kms_grant" "kms_grant" {
  count = var.enable_kms_grant ? 1 : 0

  name              = var.kms_grant_name != "" ? var.kms_grant_name : "${var.name}-kms-grant-${var.environment}"
  key_id            = var.kms_grant_key_id != "" ? var.kms_grant_key_id : (var.enable_kms_key ? element(aws_kms_key.kms_key.*.key_id, 0) : null)
  grantee_principal = var.kms_grant_grantee_principal
  operations        = var.kms_grant_operations

  retiring_principal    = var.kms_grant_retiring_principal
  grant_creation_tokens = var.kms_grant_grant_creation_tokens
  retire_on_delete      = var.kms_grant_retire_on_delete

  dynamic "constraints" {
    iterator = constraints
    for_each = var.kms_grant_constraints
    content {
      encryption_context_equals = lookup(constraints.value, "encryption_context_equals", null)
      encryption_context_subset = lookup(constraints.value, "encryption_context_subset", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_kms_key.kms_key
  ]
}
