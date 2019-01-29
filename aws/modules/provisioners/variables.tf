#---------------------------------------------------
# Provisioner file with SSH use by login/key  
#---------------------------------------------------
variable "enable_file_provisioner" {
    description = "Enable file provisioner usage"
    default     = false
}

variable "enable_connection_by_login" {
    description = "Enable connection with login usage"
    default     = false
}

variable "enable_connection_by_key" {
    description = "Enable connection through key"
    default     = true
}

variable "source_path_to_file" {
    description = "Source path to the file. Ex: /home/captain/some_file.conf"
    default     = ""
}

variable "destination_path_to_file" {
    description = "Destination path to the file. Ex: /home/captain/some_file.conf"
    default     = ""
}

variable "connection_user" {
    description = "The user that we should use for the connection"
    default     = "root"
}

variable "connection_password" {
    description = "The password we should use for the connection. In some cases this is specified by the provider."
    default     = ""
}

variable "connection_type" {
    description = "Set type for the connection. The connection type that should be used. Valid types are ssh and winrm Defaults to ssh."
    default     = "ssh"
}

variable "connection_host" {
    description = "The address of the resource to connect to. This is usually specified by the provider."
    default     = ""
}

variable "connection_port" {
    description = "The port to connect to. Defaults to 22 when using type ssh and defaults to 5985 when using type winrm."
    default     = "22"
}

variable "connection_timeout" {
    description = "The timeout to wait for the connection to become available. This defaults to 5 minutes. Should be provided as a string like 30s or 5m."
    default     = "5m"
}

variable "connection_script_path" {
    description = "The path used to copy scripts meant for remote execution."
    default     = ""
}

variable "connection_private_key" {
    description = "The contents of an SSH key to use for the connection. These can be loaded from a file on disk using the file() interpolation function. This takes preference over the password if provided."
    default     = ""
}

variable "connection_agent" {
    description = "Set to false to disable using ssh-agent to authenticate. On Windows the only supported SSH authentication agent is Pageant."
    default     = "false"
}

#variable "connection_agent_identity" {
#    description = "The preferred identity from the ssh agent for authentication."
#    default     = "false"
#}
#
#variable "connection_host_key" {
#    description = "The public key from the remote host or the signing CA, used to verify the connection."
#    default     = ""
#}

#---------------------------------------------------
# Provisioner remote-exec
#---------------------------------------------------
variable "enable_provisioner_remote_exec_inline" {
    description = "Enable remote-exec provisioner"
    default     = false
}

variable "provisioner_remote_exec_inline_command" {
    description = "This is a list of command strings. They are executed in the order they are provided. This cannot be provided with script or scripts."
    default     = []
}

#---------------------------------------------------
# Provisioner local-exec
#---------------------------------------------------
variable "enable_provisioner_local_exec_command" { 
    description = "Enable remote-exec provisioner by command"
    default     = false
}

variable "provisioner_local_exec_command_working_dir" {
    description = "(Optional) If provided, specifies the working directory where command will be executed. It can be provided as as a relative path to the current working directory or as an absolute path. The directory must exist."
    default     = ""
}

variable "provisioner_local_exec_command_command" {
    description = "(Required) This is the command to execute. It can be provided as a relative path to the current working directory or as an absolute path. It is evaluated in a shell, and can use environment variables or Terraform variables."
    default     = "echo 'test text' >> test.txt"
}

variable "provisioner_local_exec_command_interpreter" {
    description = "(Optional) If provided, this is a list of interpreter arguments used to execute the command. The first argument is the interpreter itself. It can be provided as a relative path to the current working directory or as an absolute path. The remaining arguments are appended prior to the command. This allows building command lines of the form '/bin/bash', '-c', 'echo foo'. If interpreter is unspecified, sensible defaults will be chosen based on the system OS."
    type        = "list"
    default     = []
}

variable "provisioner_local_exec_command_environment" {
    description = "(Optional) block of key value pairs representing the environment of the executed command. inherits the current process environment."
    type        = "list"
    default     = []
}

