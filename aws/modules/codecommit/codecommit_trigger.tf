#---------------------------------------------------
# AWS Codecommit trigger
#---------------------------------------------------
resource "aws_codecommit_trigger" "codecommit_trigger" {
  count = var.enable_codecommit_trigger ? 1 : 0

  repository_name = var.codecommit_repository_name != "" && ! var.enable_codecommit_repository ? var.codecommit_repository_name : element(concat(aws_codecommit_repository.codecommit_repository.*.repository_name, [""]), 0)

  // Maybe can be used dynamic here
  trigger {
    name            = var.codecommit_trigger_name != "" ? lower(var.codecommit_trigger_name) : "${lower(var.name)}-codecommit-trigger-${lower(var.environment)}"
    destination_arn = var.codecommit_trigger_destination_arn

    branches    = var.codecommit_trigger_branches
    events      = var.codecommit_trigger_events
    custom_data = var.codecommit_trigger_custom_data
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codecommit_repository.codecommit_repository
  ]
}
