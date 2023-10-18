#---------------------------------------------------
# AWS Glue resource policy
#---------------------------------------------------
resource "aws_glue_resource_policy" "glue_resource_policy" {
  count = var.enable_glue_resource_policy ? 1 : 0

  policy = var.glue_resource_policy

  enable_hybrid = var.glue_resource_policy_enable_hybrid

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}