#---------------------------------------------------
# AWS DB instance role association
#---------------------------------------------------
resource "aws_db_instance_role_association" "db_instance_role_association" {
  count = var.enable_db_instance_role_association ? 1 : 0

  db_instance_identifier = var.db_instance_role_association_db_instance_identifier != "" && !var.enable_db_instance ? var.db_instance_role_association_db_instance_identifier : element(concat(aws_db_instance.db_instance.*.id, [""]), 0)
  feature_name           = var.db_instance_role_association_feature_name
  role_arn               = var.db_instance_role_association_role_arn

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_db_instance.db_instance
  ]
}
