# Work with NULL_RESOURCE via terraform

A terraform module for making NULL_RESOURCE.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
  max_retries             = 3
}

module "provisioner_file" {
  source = "../../modules/null_resource"

  enable_provisioner_file      = true
  provisioner_file_source      = "additional_files/provisioner_file.txt"
  provisioner_file_destination = "/home/captain/provisioner_file.txt"

  provisioner_file_connection_type = "ssh"
  provisioner_file_connection_user = "captain"

  # if you wish to use login & password, then use
  # provisioner_file_connection_password       = "password_here"
  # or you can use RSA key to conncetion
  provisioner_file_connection_private_key    = file("/Users/captain/.ssh/id_rsa")
  provisioner_file_connection_agent          = false
  provisioner_file_connection_agent_identity = null
  provisioner_file_connection_host_key       = null

  provisioner_file_connection_host        = "12.17.17.66"
  provisioner_file_connection_port        = 22
  provisioner_file_connection_timeout     = 60
  provisioner_file_connection_script_path = "./additional_files"

}

module "provisioner_local_exec" {
  source = "../../modules/null_resource"

  enable_provisioner_local_exec      = true
  provisioner_local_exec_working_dir = "./additional_files"
  provisioner_local_exec_command     = "pwd && ls -alh ."
  provisioner_local_exec_interpreter = []
  provisioner_local_exec_environment = {
    FOO = "bar"
    BAR = 1
    BAZ = "true"
  }
}

module "provisioner_remote_exec" {
  source = "../../modules/null_resource"

  enable_provisioner_remote_exec_inline = true

  provisioner_remote_exec_connection_type = "ssh"
  provisioner_remote_exec_connection_user = "captain"

  provisioner_remote_exec_inline = ["echo 'its working fine' > /home/captain/provisioner_remote_exec.txt"]
  # provisioner_remote_exec_script                      = "some_script_here.sh"
  # provisioner_remote_exec_scripts                    = ["some_script_here.sh", "some_script_here.sh args"]

  # if you wish to use login & password, then use
  # provisioner_remote_exec_connection_password        = "password_here"
  # or you can use RSA key to conncetion
  provisioner_remote_exec_connection_private_key    = file("/Users/captain/.ssh/id_rsa")
  provisioner_remote_exec_connection_agent          = false
  provisioner_remote_exec_connection_agent_identity = null
  provisioner_remote_exec_connection_host_key       = null

  provisioner_remote_exec_connection_host        = "12.17.17.66"
  provisioner_remote_exec_connection_port        = 22
  provisioner_remote_exec_connection_timeout     = 60
  provisioner_remote_exec_connection_script_path = "./"

}
```

## Module Input Variables
----------------------
- `enable_provisioner_file` - Enable file provisioner usage (`default = False`)
- `provisioner_file_source` - Source path to the file. Ex: /home/captain/some_file.conf (`default = ""`)
- `provisioner_file_destination` - Destination path to the file. Ex: /home/captain/some_file.conf (`default = ""`)
- `provisioner_file_connection_user` - The user that we should use for the connection (`default = root`)
- `provisioner_file_connection_password` - The password we should use for the connection. In some cases this is specified by the provider. (`default = null`)
- `provisioner_file_connection_type` - Set type for the connection. The connection type that should be used. Valid types are ssh and winrm Defaults to ssh. (`default = ssh`)
- `provisioner_file_connection_host` - The address of the resource to connect to. This is usually specified by the provider. (`default = ""`)
- `provisioner_file_connection_port` - The port to connect to. Defaults to 22 when using type ssh and defaults to 5985 when using type winrm. (`default = 22`)
- `provisioner_file_connection_timeout` - The timeout to wait for the connection to become available. This defaults to 5 minutes. Should be provided as a string like 30s or 5m. (`default = 5m`)
- `provisioner_file_connection_script_path` - The path used to copy scripts meant for remote execution. (`default = ""`)
- `provisioner_file_connection_private_key` - The contents of an SSH key to use for the connection. These can be loaded from a file on disk using the file() interpolation function. This takes preference over the password if provided. (`default = null`)
- `provisioner_file_connection_agent` - Set to false to disable using ssh-agent to authenticate. On Windows the only supported SSH authentication agent is Pageant. (`default = null`)
- `provisioner_file_connection_agent_identity` - The preferred identity from the ssh agent for authentication. (`default = null`)
- `provisioner_file_connection_host_key` - The public key from the remote host or the signing CA, used to verify the connection. (`default = null`)
- `enable_provisioner_remote_exec_inline` - Enable remote-exec provisioner with inline (`default = False`)
- `enable_provisioner_remote_exec_script` - Enable remote-exec provisioner with script (`default = False`)
- `enable_provisioner_remote_exec_scripts` - Enable remote-exec provisioner with scripts (`default = False`)
- `provisioner_remote_exec_inline` - This is a list of command strings. They are executed in the order they are provided. This cannot be provided with script or scripts. (`default = null`)
- `provisioner_remote_exec_script` - This is a path (relative or absolute) to a local script that will be copied to the remote resource and then executed. This cannot be provided with inline or scripts. (`default = null`)
- `provisioner_remote_exec_scripts` - This is a list of paths (relative or absolute) to local scripts that will be copied to the remote resource and then executed. They are executed in the order they are provided. This cannot be provided with inline or script. (`default = null`)
- `provisioner_remote_exec_connection_type` - Set type for the connection. The connection type that should be used. Valid types are ssh and winrm Defaults to ssh. (`default = ssh`)
- `provisioner_remote_exec_connection_host` - The address of the resource to connect to. This is usually specified by the provider. (`default = ""`)
- `provisioner_remote_exec_connection_port` - The port to connect to. Defaults to 22 when using type ssh and defaults to 5985 when using type winrm. (`default = 22`)
- `provisioner_remote_exec_connection_timeout` - The timeout to wait for the connection to become available. This defaults to 5 minutes. Should be provided as a string like 30s or 5m. (`default = 5m`)
- `provisioner_remote_exec_connection_script_path` - The path used to copy scripts meant for remote execution. (`default = ""`)
- `provisioner_remote_exec_connection_private_key` - The contents of an SSH key to use for the connection. These can be loaded from a file on disk using the file() interpolation function. This takes preference over the password if provided. (`default = null`)
- `provisioner_remote_exec_connection_agent` - Set to false to disable using ssh-agent to authenticate. On Windows the only supported SSH authentication agent is Pageant. (`default = null`)
- `provisioner_remote_exec_connection_agent_identity` - The preferred identity from the ssh agent for authentication. (`default = null`)
- `provisioner_remote_exec_connection_host_key` - The public key from the remote host or the signing CA, used to verify the connection. (`default = null`)
- `provisioner_remote_exec_connection_user` - The user that we should use for the connection (`default = root`)
- `provisioner_remote_exec_connection_password` - The password we should use for the connection. In some cases this is specified by the provider. (`default = null`)
- `enable_provisioner_local_exec` - Enable remote-exec provisioner by command (`default = False`)
- `provisioner_local_exec_working_dir` - (Optional) If provided, specifies the working directory where command will be executed. It can be provided as as a relative path to the current working directory or as an absolute path. The directory must exist. (`default = ""`)
- `provisioner_local_exec_command` - (Required) This is the command to execute. It can be provided as a relative path to the current working directory or as an absolute path. It is evaluated in a shell, and can use environment variables or Terraform variables. (`default = echo 'test text' >> test.txt`)
- `provisioner_local_exec_interpreter` - (Optional) If provided, this is a list of interpreter arguments used to execute the command. The first argument is the interpreter itself. It can be provided as a relative path to the current working directory or as an absolute path. The remaining arguments are appended prior to the command. This allows building command lines of the form '/bin/bash', '-c', 'echo foo'. If interpreter is unspecified, sensible defaults will be chosen based on the system OS. (`default = []`)
- `provisioner_local_exec_environment` - (Optional) block of key value pairs representing the environment of the executed command. inherits the current process environment. (`default = {}`)
- `enable_depends_on` - Enable depends_on (`default = False`)
- `depends_on_var` - List with resources which can be used as depends_on (`default = []`)

## Module Output Variables
----------------------
- `depends_on_id` - The ID for depends_on
- `provisioner_file_id` - An arbitrary value that changes each time the resource is replaced. Can be used to cause other resources to be updated or replaced in response to null_resource changes.
- `provisioner_local_exec_id` - The ID
- `provisioner_remote_exec_id` - The ID


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
