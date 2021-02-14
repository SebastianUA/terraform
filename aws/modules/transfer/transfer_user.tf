#---------------------------------------------------
# AWS Transfer user
#---------------------------------------------------
resource "aws_transfer_user" "transfer_user" {
  count = var.enable_transfer_user ? 1 : 0

  server_id = var.transfer_user_server_id != "" && ! var.enable_transfer_server ? var.transfer_user_server_id : element(concat(aws_transfer_server.transfer_server.*.id, [""]), 0)
  user_name = var.transfer_user_name != "" ? lower(var.transfer_user_name) : "${lower(var.name)}-transfer-user-${lower(var.environment)}"
  role      = var.transfer_user_role

  home_directory = var.transfer_user_home_directory
  policy         = var.transfer_user_policy

  tags = merge(
    {
      Name = var.transfer_user_name != "" ? lower(var.transfer_user_name) : "${lower(var.name)}-transfer-user-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_transfer_server.transfer_server
  ]
}
