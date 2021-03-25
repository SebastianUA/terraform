#---------------------------------------------------
# AWS CodeArtifact domain
#---------------------------------------------------
resource "aws_codeartifact_domain" "codeartifact_domain" {
  count = var.enable_codeartifact_domain ? 1 : 0

  domain = var.codeartifact_domain != "" ? lower(var.codeartifact_domain) : "${lower(var.name)}-codeartifact-domain-${lower(var.environment)}"

  encryption_key = var.codeartifact_domain_encryption_key

  tags = merge(
    {
      Name = var.codeartifact_domain != "" ? lower(var.codeartifact_domain) : "${lower(var.name)}-codeartifact-domain-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}