#-----------------------------------------------------------
# IAM service linked role
#-----------------------------------------------------------
resource "aws_iam_service_linked_role" "iam_service_linked_role" {
  count = var.enable_iam_service_linked_role ? 1 : 0

  aws_service_name = var.iam_service_linked_role_aws_service_name

  custom_suffix = var.iam_service_linked_role_custom_suffix
  description   = var.iam_service_linked_role_description

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
