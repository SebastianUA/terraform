#---------------------------------------------------
# AWS cloud9 environment ec2
#---------------------------------------------------
resource "aws_cloud9_environment_ec2" "cloud9_environment_ec2" {
  count = var.enable_cloud9_environment_ec2 ? 1 : 0

  name          = var.cloud9_environment_ec2_name != "" ? lower(var.cloud9_environment_ec2_name) : "${lower(var.name)}-cloud9-env-ec2-${lower(var.environment)}"
  instance_type = var.cloud9_environment_ec2_instance_type

  automatic_stop_time_minutes = var.cloud9_environment_ec2_automatic_stop_time_minutes
  description                 = var.cloud9_environment_ec2_description
  owner_arn                   = var.cloud9_environment_ec2_owner_arn
  subnet_id                   = var.cloud9_environment_ec2_subnet_id

  tags = merge(
    {
      "Name" = var.cloud9_environment_ec2_name != "" ? lower(var.cloud9_environment_ec2_name) : "${lower(var.name)}-cloud9-env-ec2-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
