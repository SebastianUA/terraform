#---------------------------------------------------
# Provisioner local-exec "command"
#---------------------------------------------------
resource "null_resource" "local-exec_command" {
    count   = "${var.enable_provisioner_local_exec_command ? 1 : 0}"

    provisioner "local-exec" {
        working_dir     = "${var.provisioner_local_exec_command_working_dir}"
        command         = "${var.provisioner_local_exec_command_command}"
        interpreter     = "${var.provisioner_local_exec_command_interpreter}"
        environment     = "${var.provisioner_local_exec_command_environment}"
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = []
}
