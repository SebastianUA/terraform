#---------------------------------------------------
# AWS CodeArtifact repository permissions policy
#---------------------------------------------------
resource "aws_codeartifact_repository_permissions_policy" "codeartifact_repository_permissions_policy" {
  count = var.enable_codeartifact_repository_permissions_policy ? 1 : 0

  repository      = var.codeartifact_repository_permissions_policy_repository != "" ? var.codeartifact_repository_permissions_policy_repository : (var.enable_codeartifact_repository ? aws_codeartifact_repository.codeartifact_repository[0].repository : null)
  domain          = var.codeartifact_repository_permissions_policy_domain != "" ? var.codeartifact_repository_permissions_policy_domain : (var.enable_codeartifact_domain ? aws_codeartifact_domain.codeartifact_domain[0].domain : null)
  policy_document = var.codeartifact_repository_permissions_policy_document

  domain_owner    = var.codeartifact_repository_permissions_policy_domain_owner
  policy_revision = var.codeartifact_repository_permissions_policy_policy_revision


  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codeartifact_repository.codeartifact_repository,
    aws_codeartifact_domain.codeartifact_domain
  ]
}
