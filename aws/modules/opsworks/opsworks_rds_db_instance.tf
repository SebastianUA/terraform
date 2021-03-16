#---------------------------------------------------
# AWS opsworks RDS db instance
#---------------------------------------------------
resource "aws_opsworks_rds_db_instance" "opsworks_rds_db_instance" {
  count = var.enable_opsworks_rds_db_instance ? 1 : 0

  stack_id            = var.opsworks_rds_db_instance_stack_id != "" && !var.enable_opsworks_stack ? var.opsworks_rds_db_instance_stack_id : element(concat(aws_opsworks_stack.opsworks_stack.*.id, [""]), 0)
  rds_db_instance_arn = var.opsworks_rds_db_instance_rds_db_instance_arn
  db_user             = var.opsworks_rds_db_instance_db_user
  db_password         = var.opsworks_rds_db_instance_db_password

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_opsworks_stack.opsworks_stack
  ]
}
