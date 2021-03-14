#---------------------------------------------------
# AWS Transfer ssh key
#---------------------------------------------------
resource "aws_transfer_ssh_key" "transfer_ssh_key" {
  count = var.enable_transfer_ssh_key ? 1 : 0

  server_id = var.transfer_ssh_key_server_id != "" && ! var.enable_transfer_server ? var.transfer_ssh_key_server_id : element(concat(aws_transfer_server.transfer_server.*.id, [""]), 0)
  user_name = var.transfer_ssh_key_user_name != "" && ! var.enable_transfer_user ? var.transfer_ssh_key_user_name : element(concat(aws_transfer_user.transfer_user.*.user_name, [""]), 0)
  body      = var.transfer_ssh_key_body

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_transfer_server.transfer_server,
    aws_transfer_user.transfer_user
  ]
}
