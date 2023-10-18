#---------------------------------------------------
# AWS Glue dev endpoint
#---------------------------------------------------
resource "aws_glue_dev_endpoint" "glue_dev_endpoint" {
  count = var.enable_glue_dev_endpoint ? 1 : 0

  name     = var.glue_dev_endpoint_name != "" ? lower(var.glue_dev_endpoint_name) : "${lower(var.name)}-glue-dev-endpoint-${lower(var.environment)}"
  role_arn = var.glue_dev_endpoint_role_arn

  arguments                 = var.glue_dev_endpoint_arguments
  extra_jars_s3_path        = var.glue_dev_endpoint_extra_jars_s3_path
  extra_python_libs_s3_path = var.glue_dev_endpoint_extra_python_libs_s3_path
  glue_version              = var.glue_dev_endpoint_glue_version
  number_of_nodes           = var.glue_dev_endpoint_number_of_nodes
  number_of_workers         = var.glue_dev_endpoint_number_of_workers
  public_key                = var.glue_dev_endpoint_public_key
  public_keys               = var.glue_dev_endpoint_public_keys
  security_configuration    = var.glue_dev_endpoint_security_configuration
  security_group_ids        = var.glue_dev_endpoint_security_group_ids
  subnet_id                 = var.glue_dev_endpoint_subnet_id
  worker_type               = var.glue_dev_endpoint_worker_type

  tags = merge(
    {
      Name = var.glue_dev_endpoint_name != "" ? lower(var.glue_dev_endpoint_name) : "${lower(var.name)}-glue-dev-endpoint-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}