#---------------------------------------------------
# Provisioner local-exec
#---------------------------------------------------
resource "null_resource" "provisioner_local_exec" {
    count   = var.enable_provisioner_local_exec ? 1 : 0

    provisioner "local-exec" {
        working_dir     = var.provisioner_local_exec_working_dir
        command         = var.provisioner_local_exec_command
        interpreter     = var.provisioner_local_exec_interpreter
        environment     = var.provisioner_local_exec_environment
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = []
}
