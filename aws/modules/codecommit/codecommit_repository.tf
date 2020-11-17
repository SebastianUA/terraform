#---------------------------------------------------
# AWS Codecommit repository
#---------------------------------------------------
resource "aws_codecommit_repository" "codecommit_repository" {
  count = var.enable_codecommit_repository ? 1 : 0

  repository_name = var.codecommit_repository_name != "" ? lower(var.codecommit_repository_name) : "${lower(var.name)}-codecommit-repo-${lower(var.environment)}"

  description    = var.codecommit_repository_description
  default_branch = var.codecommit_repository_default_branch

  tags = merge(
    {
      "Name" = var.codecommit_repository_name != "" ? lower(var.codecommit_repository_name) : "${lower(var.name)}-codecommit-repo-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
