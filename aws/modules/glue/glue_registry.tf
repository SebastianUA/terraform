#---------------------------------------------------
# AWS Glue registry
#---------------------------------------------------
resource "aws_glue_registry" "glue_registry" {
  count = var.enable_glue_registry ? 1 : 0

  registry_name = var.glue_registry_name != "" ? lower(var.glue_registry_name) : "${lower(var.name)}-glue-registry-${lower(var.environment)}"

  description = var.glue_registry_description

  tags = merge(
    {
      Name = var.glue_registry_name != "" ? lower(var.glue_registry_name) : "${lower(var.name)}-glue-registry-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}