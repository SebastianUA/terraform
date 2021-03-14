#---------------------------------------------------
# AWS Codebuild webhook
#---------------------------------------------------
resource "aws_codebuild_webhook" "codebuild_webhook" {
  count = var.enable_codebuild_webhook ? 1 : 0

  project_name = var.codebuild_webhook_project_name != "" && ! var.enable_codebuild_project ? var.codebuild_webhook_project_name : element(concat(aws_codebuild_project.codebuild_project.*.name, [""]), 0)

  branch_filter = var.codebuild_webhook_branch_filter

  dynamic "filter_group" {
    iterator = filter_group
    for_each = var.codebuild_webhook_filter_group
    content {

      dynamic "filter" {
        iterator = filter
        for_each = length(keys(lookup(filter_group.value, "filter", {}))) > 0 ? [lookup(filter_group.value, "filter", {})] : []

        content {
          type    = lookup(filter.value, "type", null)
          pattern = lookup(filter.value, "pattern", null)

          exclude_matched_pattern = lookup(filter.value, "exclude_matched_pattern", null)
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codebuild_project.codebuild_project
  ]
}
