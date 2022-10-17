#---------------------------------------------------
# AWS Sagemaker human task ui
#---------------------------------------------------
resource "aws_sagemaker_human_task_ui" "sagemaker_human_task_ui" {
  count = var.enable_sagemaker_human_task_ui ? 1 : 0

  human_task_ui_name = var.sagemaker_human_task_ui_name != "" ? var.sagemaker_human_task_ui_name : "${lower(var.name)}-human-task-ui-${lower(var.environment)}"

  dynamic "ui_template" {
    iterator = ui_template
    for_each = var.sagemaker_human_task_ui_template

    content {
      content = lookup(ui_template.value, "content", null)
    }
  }

  tags = merge(
    {
      Name = var.sagemaker_human_task_ui_name != "" ? var.sagemaker_human_task_ui_name : "${lower(var.name)}-human-task-ui-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}