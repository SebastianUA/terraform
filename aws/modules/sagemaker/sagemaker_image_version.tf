#---------------------------------------------------
# AWS sagemaker image version
#---------------------------------------------------
resource "aws_sagemaker_image_version" "sagemaker_image_version" {
  count = var.enable_sagemaker_image_version ? 1 : 0

  image_name = var.sagemaker_image_version_image_name != "" ? var.sagemaker_image_version_image_name : (var.enable_sagemaker_image ? aws_sagemaker_image.sagemaker_image.0.id : null)
  base_image = var.sagemaker_image_version_base_image

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_image.sagemaker_image
  ]
}