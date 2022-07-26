# Work with DIRECTORY_SERVICE via terraform

A terraform module for making DIRECTORY_SERVICE.


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
}

module "directory_service" {
  source = "../../modules/directory_service"

  # directory service directory
  enable_directory_service_directory   = true
  directory_service_directory_name     = "corp.ad.linux-notes.org"
  directory_service_directory_password = "SuperSecretPassw0rd"
  directory_service_directory_edition  = "Standard"
  directory_service_directory_type     = "MicrosoftAD"

  # directory service log subscription
  enable_directory_service_log_subscription         = false
  directory_service_log_subscription_log_group_name = "cloudwatch_name_here"

  # directory service conditional forwarder
  enable_directory_service_conditional_forwarder             = false
  directory_service_conditional_forwarder_remote_domain_name = "linux-notes.org"
  directory_service_conditional_forwarder_dns_ips = [
    "8.8.8.8",
    "8.8.4.4"
  ]


  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_directory_service_directory` - Enable directory_service directory usage (`default = False`)
- `directory_service_directory_name` - (Required) The fully qualified name for the directory, such as corp.example.com (`default = ""`)
- `directory_service_directory_password` - (Required) The password for the directory administrator or connector user. (`default = null`)
- `directory_service_directory_size` - (Required for SimpleAD and ADConnector) The size of the directory (Small or Large are accepted values). (`default = null`)
- `directory_service_directory_alias` - (Optional) The alias for the directory (must be unique amongst all aliases in AWS). Required for enable_sso (`default = null`)
- `directory_service_directory_description` - (Optional) A textual description for the directory. (`default = null`)
- `directory_service_directory_short_name` - (Optional) The short name of the directory, such as CORP. (`default = null`)
- `directory_service_directory_enable_sso` - (Optional) Whether to enable single-sign on for the directory. Requires alias. Defaults to false (`default = False`)
- `directory_service_directory_type` - (Optional) - The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values). Defaults to SimpleAD (`default = null`)
- `directory_service_directory_edition` - Optional) The MicrosoftAD edition (Standard or Enterprise). Defaults to Enterprise (applies to MicrosoftAD type only). (`default = null`)
- `directory_service_directory_vpc_settings` - (Required for SimpleAD and MicrosoftAD) VPC related information about the directory. (`default = []`)
- `directory_service_directory_connect_settings` - (Required for ADConnector) Connector related information about the directory.  (`default = []`)
- `enable_directory_service_log_subscription` - Enable directory_service log subscription usage (`default = False`)
- `directory_service_log_subscription_directory_id` - The id of directory. (`default = ""`)
- `directory_service_log_subscription_log_group_name` - (Required) Name of the cloudwatch log group to which the logs should be published. The log group should be already created and the directory service principal should be provided with required permission to create stream and publish logs. Changing this value would delete the current subscription and create a new one. A directory can only have one log subscription at a time. (`default = null`)
- `enable_directory_service_conditional_forwarder` - Enable directory_service conditional forwarder usage (`default = False`)
- `directory_service_conditional_forwarder_directory_id` - The id of directory. (`default = ""`)
- `directory_service_conditional_forwarder_remote_domain_name` - (Required) The fully qualified domain name of the remote domain for which forwarders will be used. (`default = null`)
- `directory_service_conditional_forwarder_dns_ips` - (Required) A list of forwarder IP addresses. (`default = null`)

## Module Output Variables
----------------------
- `directory_service_directory_id` - The directory identifier.
- `directory_service_directory_access_url` - The access URL for the directory, such as http://alias.awsapps.com.
- `directory_service_directory_dns_ip_addresses` - A list of IP addresses of the DNS servers for the directory or connector.
- `directory_service_directory_security_group_id` - The ID of the security group created by the directory.
- `directory_service_directory_connect_settings` - connect_settings: The IP addresses of the AD Connector servers.
- `directory_service_log_subscription_id` - The directory identifier for log subscription.
- `directory_service_conditional_forwarder_id` - The directory identifier for conditional forwarder


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
