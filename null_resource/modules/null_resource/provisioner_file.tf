#---------------------------------------------------
# Provisioner file by SSH with user and password usage
#---------------------------------------------------
resource "null_resource" "provisioner_file_by_login" {
    count           = "${var.enable_file_provisioner && var.enable_connection_by_login ? 1 : 0}"

    provisioner "file" {
        source          = "${var.source_path_to_file}"
        destination     = "${var.destination_path_to_file}"
        
        connection {
            type        = "${var.connection_type}"
            user        = "${var.connection_user}"
            password    = "${var.connection_password}"

            host        = "${var.connection_host}"
            port        = "${var.connection_port}"
            timeout     = "${var.connection_timeout}"
            script_path = "${var.connection_script_path}"
        }
    }
}

#---------------------------------------------------
# Provisioner file by SSH with RSA usage
#---------------------------------------------------
resource "null_resource" "provisioner_file_by_key" {
    count       = "${var.enable_file_provisioner && var.enable_connection_by_key ? 1 : 0}"
    
    provisioner "file" {
        source              = "${var.source_path_to_file}"
        destination         = "${var.destination_path_to_file}"
        
        connection {
            type            = "${var.connection_type}"
            user            = "${var.connection_user}"
            private_key     = "${file("${var.connection_private_key}")}"
            agent           = "${var.connection_agent}"
            #agent_identity  = "${var.connection_agent_identity}"
            #host_key        = "${file("${var.connection_host_key}")}"
            
            host            = "${var.connection_host}"
            port            = "${var.connection_port}"
            timeout         = "${var.connection_timeout}"
            script_path     = "${var.connection_script_path}"
        }
    }
}
