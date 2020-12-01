#---------------------------------------------------
# AWS organizations policy
#---------------------------------------------------
resource "aws_organizations_policy" "organizations_policy" {
  count = var.enable_organizations_policy ? 1 : 0

  name    = var.organizations_policy_name != "" ? var.organizations_policy_name : "${lower(var.name)}-org-policy-${lower(var.environment)}"
  content = var.organizations_policy_content

  description = var.organizations_policy_description
  type        = upper(var.organizations_policy_type)

  tags = merge(
    {
      Name = var.organizations_policy_name != "" ? var.organizations_policy_name : "${lower(var.name)}-org-policy-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = []
}