# Work with FILE via terraform

A terraform module for making FILE.


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


module "local_file" {
  source = "../../modules/file"

  # Generate ramdom UUID
  enable_file   = true
  file_filename = "file_name.txt"

  file_content              = "bla bla bla"
  file_file_permission      = 0777
  file_directory_permission = 0777
}

module "sensitive_file" {
  source = "../../modules/file"

  # Generate ramdom UUID
  enable_sensitive_file   = true
  sensitive_file_filename = "sensitive_file_name.txt"

  sensitive_file_content              = "bla bla bla"
  sensitive_file_file_permission      = 0777
  sensitive_file_directory_permission = 0777
}

```

## Module Input Variables
----------------------
- `enable_file` - Enable file usage (`default = False`)
- `file_filename` - (Required) The path to the file that will be created. Missing parent directories will be created. If the file already exists, it will be overridden with the given content. (`default = null`)
- `file_content` - (Optional) Content to store in the file, expected to be an UTF-8 encoded string. Conflicts with sensitive_content, content_base64 and source. Exactly one of these four arguments must be specified. (`default = null`)
- `file_content_base64` - (Optional) Content to store in the file, expected to be binary encoded as base64 string. Conflicts with content, sensitive_content and source. Exactly one of these four arguments must be specified. (`default = null`)
- `file_source` - (Optional) Path to file to use as source for the one we are creating. Conflicts with content, sensitive_content and content_base64. Exactly one of these four arguments must be specified. (`default = null`)
- `file_file_permission` - (Optional) Permissions to set for the output file, expressed as string in numeric notation. Default value is '0777'. (`default = null`)
- `file_directory_permission` - (Optional) Permissions to set for directories created, expressed as string in numeric notation. Default value is '0777'. (`default = null`)
- `enable_sensitive_file` - Enable sensitive file usage (`default = False`)
- `sensitive_file_filename` - (Required) The path to the file that will be created. Missing parent directories will be created. If the file already exists, it will be overridden with the given content. (`default = null`)
- `sensitive_file_content` - (Optional) Sensitive content to store in the file, expected to be an UTF-8 encoded string. Conflicts with content_base64 and source. Exactly one of these three arguments must be specified. (`default = null`)
- `sensitive_file_content_base64` - (Optional) Sensitive content to store in the file, expected to be binary encoded as base64 string. Conflicts with content and source. Exactly one of these three arguments must be specified. (`default = null`)
- `sensitive_file_source` - (Optional) Path to file to use as source for the one we are creating. Conflicts with content and content_base64. Exactly one of these three arguments must be specified. (`default = null`)
- `sensitive_file_file_permission` - (Optional) Permissions to set for the output file, expressed as string in numeric notation. Default value is '0777'. (`default = null`)
- `sensitive_file_directory_permission` - (Optional) Permissions to set for directories created, expressed as string in numeric notation. Default value is '0777'. (`default = null`)

## Module Output Variables
----------------------
- `file_id` - The ID of file
- `sensitive_file_id` - The ID of sensitive file


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
