#---------------------------------------------------
# Provisioner file
#---------------------------------------------------
resource "null_resource" "provisioner_file" {
  count = var.enable_provisioner_file ? 1 : 0

  provisioner "file" {
    source      = var.provisioner_file_source
    destination = var.provisioner_file_destination

    connection {
      type = var.provisioner_file_connection_type
      user = var.provisioner_file_connection_user

      # using password to conenct to a host by login & password
      password = var.provisioner_file_connection_password

      # using these params to connect to a host by RSA key
      private_key    = var.provisioner_file_connection_private_key
      agent          = var.provisioner_file_connection_agent
      agent_identity = var.provisioner_file_connection_agent_identity
      host_key       = var.provisioner_file_connection_host_key

      host        = var.provisioner_file_connection_host
      port        = var.provisioner_file_connection_port
      timeout     = var.provisioner_file_connection_timeout
      script_path = var.provisioner_file_connection_script_path
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
