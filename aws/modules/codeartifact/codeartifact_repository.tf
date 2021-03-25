#---------------------------------------------------
# AWS CodeArtifact repository
#---------------------------------------------------
resource "aws_codeartifact_repository" "codeartifact_repository" {
  count = var.enable_codeartifact_repository ? 1 : 0

  repository = var.codeartifact_repository != "" ? lower(var.codeartifact_repository) : "${lower(var.name)}-codeartifact-repository-${lower(var.environment)}"
  domain     = var.codeartifact_repository_domain != "" ? var.codeartifact_repository_domain : (var.enable_codeartifact_domain ? aws_codeartifact_domain.codeartifact_domain[0].domain : null)

  description  = var.codeartifact_repository_description
  domain_owner = var.codeartifact_repository_domain_owner

  dynamic "upstream" {
    iterator = upstream
    for_each = var.codeartifact_repository_upstream

    content {
      repository_name = lookup(upstream.value, "repository_name", null)
    }
  }

  dynamic "external_connections" {
    iterator = external_connections
    for_each = var.codeartifact_repository_external_connections

    content {
      external_connection_name = lookup(external_connections.value, "external_connection_name", null)
    }
  }

  tags = merge(
    {
      Name = var.codeartifact_repository != "" ? lower(var.codeartifact_repository) : "${lower(var.name)}-codeartifact-repository-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codeartifact_domain.codeartifact_domain
  ]
}