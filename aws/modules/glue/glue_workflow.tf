#---------------------------------------------------
# AWS Glue workflow
#---------------------------------------------------
resource "aws_glue_workflow" "glue_workflow" {
  count = var.enable_glue_workflow ? 1 : 0

  name = var.glue_workflow_name != "" ? lower(var.glue_workflow_name) : "${lower(var.name)}-glue-workflow-${lower(var.environment)}"

  description            = var.glue_workflow_description
  default_run_properties = var.glue_workflow_default_run_properties
  max_concurrent_runs    = var.glue_workflow_max_concurrent_runs

  tags = merge(
    {
      Name = var.glue_workflow_name != "" ? lower(var.glue_workflow_name) : "${lower(var.name)}-glue-workflow-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
