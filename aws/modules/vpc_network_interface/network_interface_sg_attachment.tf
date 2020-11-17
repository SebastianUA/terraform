#---------------------------------------------------
# AWS VPC network interface sg attachment
#---------------------------------------------------
resource "aws_network_interface_sg_attachment" "network_interface_sg_attachment" {
  count = var.enable_network_interface_sg_attachment ? 1 : 0

  security_group_id    = var.network_interface_sg_attachment_security_group_id
  network_interface_id = var.network_interface_sg_attachment_network_interface_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
