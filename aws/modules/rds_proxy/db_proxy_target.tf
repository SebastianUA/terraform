#---------------------------------------------------
# AWS DB proxy target
#---------------------------------------------------
resource "aws_db_proxy_target" "db_proxy_target" {
  count = var.enable_db_proxy_target ? 1 : 0

  db_proxy_name     = var.db_proxy_target_db_proxy_name != "" ? var.db_proxy_target_db_proxy_name : (var.enable_db_proxy ? element(aws_db_proxy.db_proxy.*.name, 0) : null)
  target_group_name = var.db_proxy_target_target_group_name != "" ? var.db_proxy_target_target_group_name : (var.enable_db_proxy_default_target_group ? element(aws_db_proxy_default_target_group.db_proxy_default_target_group.*.db_proxy_name, 0) : null)

  db_instance_identifier = var.db_proxy_target_db_instance_identifier
  db_cluster_identifier  = var.db_proxy_target_db_cluster_identifier

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_db_proxy.db_proxy,
    aws_db_proxy_default_target_group.db_proxy_default_target_group
  ]
}
