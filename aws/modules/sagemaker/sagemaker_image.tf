#---------------------------------------------------
# AWS sagemaker image
#---------------------------------------------------
resource "aws_sagemaker_image" "sagemaker_image" {
  count = var.enable_sagemaker_image ? 1 : 0

  image_name = var.sagemaker_image_name != "" ? lower(var.sagemaker_image_name) : "${lower(var.name)}-sagemaker-image-${lower(var.environment)}"
  role_arn   = var.sagemaker_image_role_arn

  display_name = var.sagemaker_image_display_name
  description  = var.sagemaker_image_description

  tags = merge(
    {
      Name = var.sagemaker_image_name != "" ? lower(var.sagemaker_image_name) : "${lower(var.name)}-sagemaker-image-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}