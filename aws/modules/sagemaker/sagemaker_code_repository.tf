#---------------------------------------------------
# AWS sagemaker code repository
#---------------------------------------------------
resource "aws_sagemaker_code_repository" "sagemaker_code_repository" {
  count = var.enable_sagemaker_code_repository ? 1 : 0

  code_repository_name = var.sagemaker_code_repository_name != "" ? lower(var.sagemaker_code_repository_name) : "${lower(var.name)}-sagemaker-code-repository-${lower(var.environment)}"

  dynamic "git_config" {
    iterator = git_config
    for_each = var.sagemaker_code_repository_git_config
    content {
      repository_url = lookup(git_config.value, "repository_url", null)

      branch     = lookup(git_config.value, "branch", null)
      secret_arn = lookup(git_config.value, "secret_arn", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}