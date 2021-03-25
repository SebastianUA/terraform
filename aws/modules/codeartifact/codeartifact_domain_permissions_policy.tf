#---------------------------------------------------
# AWS CodeArtifact domain permissions policy
#---------------------------------------------------
resource "aws_codeartifact_domain_permissions_policy" "codeartifact_domain_permissions_policy" {
  count = var.enable_codeartifact_domain_permissions_policy ? 1 : 0

  domain          = var.codeartifact_domain_permissions_policy_domain != "" ? var.codeartifact_domain_permissions_policy_domain : (var.enable_codeartifact_domain ? aws_codeartifact_domain.codeartifact_domain[0].domain : null)
  policy_document = var.codeartifact_domain_permissions_policy_document

  domain_owner    = var.codeartifact_domain_permissions_policy_domain_owner
  policy_revision = var.codeartifact_domain_permissions_policy_revision

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codeartifact_domain.codeartifact_domain
  ]
}
