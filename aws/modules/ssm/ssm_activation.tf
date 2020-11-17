#-----------------------------------------------------------
# AWS SSM activation
#-----------------------------------------------------------
resource "aws_ssm_activation" "ssm_activation" {
  count = var.enable_ssm_activation ? 1 : 0

  name     = var.ssm_activation_name != "" ? lower(var.ssm_activation_name) : "${lower(var.name)}-activation-${lower(var.environment)}"
  iam_role = var.ssm_activation_iam_role

  expiration_date    = var.ssm_activation_expiration_date
  description        = var.ssm_activation_description
  registration_limit = var.ssm_activation_registration_limit

  tags = merge(
    {
      "Name" = var.ssm_activation_name != "" ? lower(var.ssm_activation_name) : "${lower(var.name)}-activation-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
