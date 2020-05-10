# Work with AWS workspaces via terraform

A terraform module for making workspaces.


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
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "workspaces" {
    source                                          = "../../modules/workspaces"
    name                                            = "TEST"
    environment                                     = "stage"

    # workspaces directories
    enable_workspaces_directory                     = true
    workspaces_directory_directory_ids              = ["workspaces_directory_id1", "workspaces_directory_id2"]
    workspaces_directory_subnet_ids                 = null
    workspaces_directory_self_service_permissions   = [{
        increase_volume_size    = true
        rebuild_workspace       = true
        change_compute_type     = false
        restart_workspace       = true
        switch_running_mode     = false
    }]

    # workspaces ip group
    enable_workspaces_ip_group                      = true
    workspaces_ip_group_name                        = ""
    workspaces_ip_group_description                 = null
    workspaces_ip_group_rules                       = [{
        source      = "10.0.0.0/16"
        description = "Set 10.0.0.0/16 range"
    }]
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_workspaces_directory` - Enable workspaces directory usage (`default = False`)
- `workspaces_directory_directory_ids` - (Required) The list of directories identifier for registration in WorkSpaces service. (`default = null`)
- `workspaces_directory_subnet_ids` - (Optional) The identifiers of the subnets where the directory resides. (`default = null`)
- `workspaces_directory_self_service_permissions` - (Optional) The permissions to enable or disable self-service capabilities. (`default = []`)
- `workspaces_directory_name` - Name for workplaces directory. Uses for tags. (`default = ""`)
- `enable_workspaces_ip_group` - Enable workspaces ip group usage (`default = False`)
- `workspaces_ip_group_name` - The name of the IP group. (`default = ""`)
- `workspaces_ip_group_description` - (Optional) The description of the IP group. (`default = null`)
- `workspaces_ip_group_rules` - (Optional) One or more pairs specifying the IP group rule (in CIDR format) from which web requests originate. (`default = []`)

## Module Output Variables
----------------------
- `workspaces_directory_id` - The ID of the workspaces directory.
- `workspaces_directory_workspace_security_group_id` - The identifier of the security group that is assigned to new WorkSpaces.
- `workspaces_directory_iam_role_id` - The identifier of the IAM role. This is the role that allows Amazon WorkSpaces to make calls to other services, such as Amazon EC2, on your behalf.
- `workspaces_directory_registration_code` - The registration code for the directory. This is the code that users enter in their Amazon WorkSpaces client application to connect to the directory.
- `workspaces_directory_directory_name` - The name of the directory.
- `workspaces_directory_directory_type` -  The directory type.
- `workspaces_directory_customer_user_name` - The user name for the service account.
- `workspaces_directory_alias` - The directory alias.
- `workspaces_directory_ip_group_ids` - The identifiers of the IP access control groups associated with the directory.
- `workspaces_directory_dns_ip_addresses` - The IP addresses of the DNS servers for the directory.
- `workspaces_ip_group_id` - The IP group identifier.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
