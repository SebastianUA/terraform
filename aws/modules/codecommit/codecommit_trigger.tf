#---------------------------------------------------
# AWS Codecommit trigger
#---------------------------------------------------
resource "aws_codecommit_trigger" "codecommit_trigger" {
  count = var.enable_codecommit_trigger ? 1 : 0

  repository_name = var.codecommit_trigger_repository_name != "" ? var.codecommit_trigger_repository_name : (var.enable_codecommit_repository ? aws_codecommit_repository.codecommit_repository[count.index].repository_name : null)
  // name            = var.codecommit_trigger_name != "" ? var.codecommit_trigger_name : "${lower(var.name)}-codecommit-trigger-${lower(var.environment)}"
  // destination_arn = var.codecommit_trigger_destination_arn
  // events          = var.codecommit_trigger_events

  // branches    = var.codecommit_trigger_branches
  // custom_data = var.codecommit_trigger_custom_data

  dynamic "trigger" {
    iterator = trigger
    for_each = var.codecommit_trigger_triggers

    content {
      name            = lookup(trigger.value, "name", "${lower(var.name)}-codecommit-trigger-${lower(var.environment)}")
      destination_arn = lookup(trigger.value, "destination_arn", null)

      branches    = lookup(trigger.value, "branches", null)
      events      = lookup(trigger.value, "events", null)
      custom_data = lookup(trigger.value, "custom_data", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codecommit_repository.codecommit_repository
  ]
}
