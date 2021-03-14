#---------------------------------------------------
# AWS codepipeline webhook
#---------------------------------------------------
resource "aws_codepipeline_webhook" "codepipeline_webhook" {
  count = var.enable_codepipeline_webhook ? length(var.codepipeline_stack) : 0

  name            = lookup(var.codepipeline_webhook_stack[count.index], "name", "${lower(var.name)}-codepipeline-webhook-${count.index + 1}-${lower(var.environment)}")
  authentication  = lookup(var.codepipeline_webhook_stack[count.index], "authentication", null)
  target_action   = lookup(var.codepipeline_webhook_stack[count.index], "target_action", null)
  target_pipeline = lookup(var.codepipeline_webhook_stack[count.index], "authentication", (var.enable_codepipeline ? aws_codepipeline.codepipeline[count.index].name : null))

  dynamic "filter" {
    iterator = filter
    for_each = length(keys(lookup(var.codepipeline_webhook_stack[count.index], "filter", {}))) > 0 ? [lookup(var.codepipeline_webhook_stack[count.index], "filter", {})] : []

    content {
      json_path    = lookup(filter.value, "json_path", null)
      match_equals = lookup(filter.value, "match_equals", null)
    }
  }

  dynamic "authentication_configuration" {
    iterator = authconf
    for_each = lookup(var.codepipeline_webhook_stack[count.index], "authentication_configuration", [])

    content {
      secret_token     = lookup(authconf.value, "secret_token", null)
      allowed_ip_range = lookup(authconf.value, "allowed_ip_range", null)
    }
  }

  tags = merge(
    {
      Name = lookup(var.codepipeline_webhook_stack[count.index], "name", "${lower(var.name)}-codepipeline-webhook-${count.index + 1}-${lower(var.environment)}")
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codepipeline.codepipeline
  ]
}
