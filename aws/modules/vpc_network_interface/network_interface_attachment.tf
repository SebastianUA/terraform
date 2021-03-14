#---------------------------------------------------
# AWS VPC network interface attachment
#---------------------------------------------------
resource "aws_network_interface_attachment" "network_interface_attachment" {
  count = var.enable_network_interface_attachment ? 1 : 0

  instance_id          = var.network_interface_attachment_instance_id
  network_interface_id = var.network_interface_attachment_network_interface_id != "" && ! var.enable_network_interface ? var.network_interface_attachment_network_interface_id : element(concat(aws_network_interface.network_interface.*.id, [""]), 0)
  device_index         = var.network_interface_attachment_device_index

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_network_interface.network_interface
  ]
}
