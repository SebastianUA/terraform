#---------------------------------------------------
# AWS directory service log subscription
#---------------------------------------------------
resource "aws_directory_service_log_subscription" "directory_service_log_subscription" {
  count = var.enable_directory_service_log_subscription ? 1 : 0

  directory_id   = var.directory_service_log_subscription_directory_id != "" ? var.directory_service_log_subscription_directory_id : element(aws_directory_service_directory.directory_service_directory.*.id, 0)
  log_group_name = var.directory_service_log_subscription_log_group_name

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_directory_service_directory.directory_service_directory
  ]
}