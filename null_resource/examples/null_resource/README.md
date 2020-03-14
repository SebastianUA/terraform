# Work with Null Resource via terraform

A terraform module for null resource.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 0.12.12"
}

provider "aws" {
    version                 = "~> 2.36"
    region                  = "us-west-2"
    shared_credentials_file = pathexpand("~/.aws/credentials")
    profile                 = "default"
    max_retries             = 3
}

module "provisioners" {
    source                                      = "../../modules/null_resource"

    #
    enable_file_provisioner                     = true
    enable_connection_by_login                  = true
    # or
    # enable_connection_by_key                  = true


    enable_provisioner_local_exec_command       = true
    provisioner_local_exec_command_command      = "echo 'test text' >> test.txt"
    provisioner_local_exec_command_interpreter  = []
    provisioner_local_exec_command_environment  = {
        FOO = "bar"
        BAR = 1
        BAZ = "true"
    }
}
```

## Module Input Variables
----------------------
- `enable_file_provisioner` - Enable file provisioner usage (`default = ""`)
- `enable_connection_by_login` - Enable connection with login usage (`default = ""`)
- `enable_connection_by_key` - Enable connection through key (`default = True`)
- `source_path_to_file` - Source path to the file. Ex: /home/captain/some_file.conf (`default = ""`)
- `destination_path_to_file` - Destination path to the file. Ex: /home/captain/some_file.conf (`default = ""`)
- `connection_user` - The user that we should use for the connection (`default = root`)
- `connection_password` - The password we should use for the connection. In some cases this is specified by the provider. (`default = ""`)
- `connection_type` - Set type for the connection. The connection type that should be used. Valid types are ssh and winrm Defaults to ssh. (`default = ssh`)
- `connection_host` - The address of the resource to connect to. This is usually specified by the provider. (`default = ""`)
- `connection_port` - The port to connect to. Defaults to 22 when using type ssh and defaults to 5985 when using type winrm. (`default = 22`)
- `connection_timeout` - The timeout to wait for the connection to become available. This defaults to 5 minutes. Should be provided as a string like 30s or 5m. (`default = 5m`)
- `connection_script_path` - The path used to copy scripts meant for remote execution. (`default = ""`)
- `connection_private_key` - The contents of an SSH key to use for the connection. These can be loaded from a file on disk using the file() interpolation function. This takes preference over the password if provided. (`default = ""`)
- `connection_agent` - Set to false to disable using ssh-agent to authenticate. On Windows the only supported SSH authentication agent is Pageant. (`default = ""`)
- `connection_agent_identity` - The preferred identity from the ssh agent for authentication. (`default = ""`)
- `connection_host_key` - The public key from the remote host or the signing CA, used to verify the connection. (`default = ""`)
- `enable_provisioner_remote_exec_inline` - Enable remote-exec provisioner (`default = ""`)
- `provisioner_remote_exec_inline_command` - This is a list of command strings. They are executed in the order they are provided. This cannot be provided with script or scripts. (`default = ""`)
- `enable_provisioner_local_exec_command` - Enable remote-exec provisioner by command (`default = ""`)
- `provisioner_local_exec_command_working_dir` - (Optional) If provided, specifies the working directory where command will be executed. It can be provided as as a relative path to the current working directory or as an absolute path. The directory must exist. (`default = ""`)
- `provisioner_local_exec_command_command` - (Required) This is the command to execute. It can be provided as a relative path to the current working directory or as an absolute path. It is evaluated in a shell, and can use environment variables or Terraform variables. (`default = echo 'test text' >> test.txt`)
- `provisioner_local_exec_command_interpreter` - (Optional) If provided, this is a list of interpreter arguments used to execute the command. The first argument is the interpreter itself. It can be provided as a relative path to the current working directory or as an absolute path. The remaining arguments are appended prior to the command. This allows building command lines of the form '/bin/bash', '-c', 'echo foo'. If interpreter is unspecified, sensible defaults will be chosen based on the system OS. (`default = ""`)
- `provisioner_local_exec_command_environment` - (Optional) block of key value pairs representing the environment of the executed command. inherits the current process environment. (`default = {'FOO': 'bar', 'BAR': 1, 'BAZ': 'true'}`)
- `enable_depends_on` - Enable depends_on (`default = ""`)
- `depends_on_var` - List with resources which can be used as depends_on (`default = ""`)


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
