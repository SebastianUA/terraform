#---------------------------------------------------
# Provisioner remote-exec
#---------------------------------------------------
resource "null_resource" "provisioner_remote_exec" {
    count               = var.enable_provisioner_remote_exec ? 1 : 0

    provisioner "remote-exec" {
        inline          = var.provisioner_remote_exec_inline
        script          = var.provisioner_remote_exec_script
        scripts         = var.provisioner_remote_exec_scripts

        connection {
            type            = var.provisioner_remote_exec_connection_type
            user            = var.provisioner_remote_exec_connection_user

            # using password to conenct to a host by login & password
            password        = var.provisioner_remote_exec_connection_password

            # using these params to connect to a host by RSA key
            private_key     = var.provisioner_remote_exec_connection_private_key
            agent           = var.provisioner_remote_exec_connection_agent
            agent_identity  = var.provisioner_remote_exec_connection_agent_identity
            host_key        = var.provisioner_remote_exec_connection_host_key

            host            = var.provisioner_remote_exec_connection_host
            port            = var.provisioner_remote_exec_connection_port
            timeout         = var.provisioner_remote_exec_connection_timeout
            script_path     = var.provisioner_remote_exec_connection_script_path
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = []
}
