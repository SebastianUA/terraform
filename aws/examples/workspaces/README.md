# Work with WORKSPACES via terraform

A terraform module for making WORKSPACES.


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

data "aws_workspaces_bundle" "bundle_windows_10" {
  bundle_id = "wsb-bh8rsxt14" # Value with Windows 10 (English)
}

module "workspaces" {
  source      = "../../modules/workspaces"
  name        = "TEST"
  environment = "stage"

  # workspaces directories
  enable_workspaces_directory        = true
  workspaces_directory_directory_ids = ["workspaces_directory_id1", "workspaces_directory_id2"]
  workspaces_directory_subnet_ids    = null
  workspaces_directory_self_service_permissions = [{
    increase_volume_size = true
    rebuild_workspace    = true
    change_compute_type  = false
    restart_workspace    = true
    switch_running_mode  = false
  }]

  workspaces_directory_workspace_access_properties = [
    {
      device_type_android    = "ALLOW"
      device_type_chromeos   = "ALLOW"
      device_type_ios        = "ALLOW"
      device_type_osx        = "ALLOW"
      device_type_web        = "DENY"
      device_type_windows    = "DENY"
      device_type_zeroclient = "DENY"
    }
  ]

  workspaces_directory_workspace_creation_properties = [
    {
      custom_security_group_id            = ""
      default_ou                          = "OU=AWS,DC=Workgroup,DC=Example,DC=com"
      enable_internet_access              = true
      enable_maintenance_mode             = true
      user_enabled_as_local_administrator = true
    }
  ]

  # workspaces ip group
  enable_workspaces_ip_group      = true
  workspaces_ip_group_name        = ""
  workspaces_ip_group_description = null
  workspaces_ip_group_rules = [{
    source      = "10.0.0.0/16"
    description = "Set 10.0.0.0/16 range"
  }]

  # workspaces workspace
  enable_workspaces_workspace    = true
  workspaces_workspace_name      = "workspace-name"
  workspaces_workspace_bundle_id = data.aws_workspaces_bundle.bundle_windows_10.id
  workspaces_workspace_user_name = "captain.ua"

  workspaces_workspace_root_volume_encryption_enabled = true
  workspaces_workspace_user_volume_encryption_enabled = true
  workspaces_workspace_volume_encryption_key          = "alias/aws/workspaces"

  workspaces_workspace_workspace_properties = [
    {
      compute_type_name                         = "VALUE"
      user_volume_size_gib                      = 10
      root_volume_size_gib                      = 80
      running_mode                              = "AUTO_STOP"
      running_mode_auto_stop_timeout_in_minutes = 60
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    data.aws_workspaces_bundle.bundle_windows_10
  ]
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
- `workspaces_directory_ip_group_ids` - The identifiers of the IP access control groups associated with the directory. (`default = null`)
- `workspaces_directory_self_service_permissions` - (Optional) The permissions to enable or disable self-service capabilities. (`default = []`)
- `workspaces_directory_workspace_access_properties` - (Optional) Specifies which devices and operating systems users can use to access their WorkSpaces. (`default = []`)
- `workspaces_directory_workspace_creation_properties` - (Optional) Default properties that are used for creating WorkSpaces. (`default = []`)
- `workspaces_directory_name` - Name for workplaces directory. Uses for tags. (`default = ""`)
- `enable_workspaces_ip_group` - Enable workspaces ip group usage (`default = False`)
- `workspaces_ip_group_name` - The name of the IP group. (`default = ""`)
- `workspaces_ip_group_description` - (Optional) The description of the IP group. (`default = null`)
- `workspaces_ip_group_rules` - (Optional) One or more pairs specifying the IP group rule (in CIDR format) from which web requests originate. (`default = []`)
- `enable_workspaces_workspace` - Enable workspaces workspace usage (`default = False`)
- `workspaces_workspace_name` - Set name for workplace (`default = ""`)
- `workspaces_workspace_directory_id` - The ID of the directory for the WorkSpace. (`default = ""`)
- `workspaces_workspace_bundle_id` - (Required) The ID of the bundle for the WorkSpace. (`default = null`)
- `workspaces_workspace_user_name` - (Required) The user name of the user for the WorkSpace. This user name must exist in the directory for the WorkSpace. (`default = null`)
- `workspaces_workspace_root_volume_encryption_enabled` - (Optional) Indicates whether the data stored on the root volume is encrypted. (`default = null`)
- `workspaces_workspace_user_volume_encryption_enabled` - (Optional) Indicates whether the data stored on the user volume is encrypted. (`default = null`)
- `workspaces_workspace_volume_encryption_key` - (Optional) The symmetric AWS KMS customer master key (CMK) used to encrypt data stored on your WorkSpace. Amazon WorkSpaces does not support asymmetric CMKs. (`default = null`)
- `workspaces_workspace_workspace_properties` - (Optional) The WorkSpace properties (`default = []`)
- `workspaces_workspace_timeouts` - Set timeouts for workspaces workspace (`default = {}`)

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
- `workspaces_workspace_id` - The workspaces ID.
- `workspaces_workspace_ip_address` - The IP address of the WorkSpace.
- `workspaces_workspace_computer_name` - The name of the WorkSpace, as seen by the operating system.
- `workspaces_workspace_state` - The operational state of the WorkSpace.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
