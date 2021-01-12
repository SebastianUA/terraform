#---------------------------------------------------
# AWS directory service conditional forwarder
#---------------------------------------------------
resource "aws_directory_service_conditional_forwarder" "directory_service_conditional_forwarder" {
  count = var.enable_directory_service_conditional_forwarder ? 1 : 0

  directory_id       = var.directory_service_conditional_forwarder_directory_id != "" ? var.directory_service_conditional_forwarder_directory_id : element(aws_directory_service_directory.directory_service_directory.*.id, 0)
  remote_domain_name = var.directory_service_conditional_forwarder_remote_domain_name
  dns_ips            = var.directory_service_conditional_forwarder_dns_ips

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_directory_service_directory.directory_service_directory
  ]
}