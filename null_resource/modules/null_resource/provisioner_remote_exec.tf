#---------------------------------------------------
# Provisioner remote-exec "inline" by login
#---------------------------------------------------
resource "null_resource" "remote_exec_by_login" {
    count               = var.enable_provisioner_remote_exec_inline && var.enable_connection_by_login ? 1 : 0

    provisioner "remote-exec" {
        inline          = var.provisioner_remote_exec_inline_command

        connection {
            type        = var.connection_type
            user        = var.connection_user
            password    = var.connection_password

            host        = var.connection_host
            port        = var.connection_port
            timeout     = var.connection_timeout
        }
    }
}

#---------------------------------------------------
# Provisioner remote-exec "inline" by key
#---------------------------------------------------
resource "null_resource" "remote_exec_by_key" {
    count                   = var.enable_provisioner_remote_exec_inline && var.enable_connection_by_key ? 1 : 0

    provisioner "remote-exec" {
        inline              = var.provisioner_remote_exec_inline_command

        connection {
            type            = var.connection_type
            user            = var.connection_user
            private_key     = var.connection_private_key
            agent           = var.connection_agent
            agent_identity  = var.connection_agent_identity
            host_key        = var.connection_host_key

            host            = var.connection_host
            port            = var.connection_port
            timeout         = var.connection_timeout
        }
    }
}

#---------------------------------------------------
# Provisioner remote-exec "script" by login
#---------------------------------------------------

# https://www.terraform.io/docs/provisioners/remote-exec.html

#---------------------------------------------------
# Provisioner remote-exec "script" by key
#---------------------------------------------------

# https://www.terraform.io/docs/provisioners/remote-exec.html

#---------------------------------------------------
# Provisioner remote-exec "scripts" by login
#---------------------------------------------------

# https://www.terraform.io/docs/provisioners/remote-exec.html

#---------------------------------------------------
# Provisioner remote-exec "scripts" by key
#---------------------------------------------------

# https://www.terraform.io/docs/provisioners/remote-exec.html
