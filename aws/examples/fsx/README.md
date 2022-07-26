# Work with FSX via terraform

A terraform module for making FSX.


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

module "fsx" {
  source      = "../../modules/fsx"
  name        = "TEST"
  environment = "stage"

  # FSX lustre file system
  enable_fsx_lustre_file_system           = true
  fsx_lustre_file_system_storage_capacity = 1200
  fsx_lustre_file_system_subnet_ids       = ["sub-4344c4d"]

  fsx_lustre_file_system_import_path = "s3://my-test-bucket-here"

  #
  enable_fsx_windows_file_system              = true
  fsx_windows_file_system_storage_capacity    = 1200
  fsx_windows_file_system_subnet_ids          = ["sub-4344c4d"]
  fsx_windows_file_system_throughput_capacity = 32
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_fsx_lustre_file_system` - Enable fsx lustre file system usage (`default = False`)
- `fsx_lustre_file_system_storage_capacity` - (Required) The storage capacity (GiB) of the file system. Minimum of 1200. Storage capacity is provisioned in increments of 3,600 GiB. (`default = 1200`)
- `fsx_lustre_file_system_subnet_ids` - (Required) A list of IDs for the subnets that the file system will be accessible from. File systems currently support only one subnet. The file server is also launched in that subnet's Availability Zone. (`default = []`)
- `fsx_lustre_file_system_export_path` - (Optional) S3 URI (with optional prefix) where the root of your Amazon FSx file system is exported. Can only be specified with import_path argument and the path must use the same Amazon S3 bucket as specified in import_path. Set equal to import_path to overwrite files on export. Default to s3://{IMPORT BUCKET}/FSxLustre{CREATION TIMESTAMP} (`default = null`)
- `fsx_lustre_file_system_import_path` - (Optional) S3 URI (with optional prefix) that you're using as the data repository for your FSx for Lustre file system. For example, s3://example-bucket/optional-prefix/ (`default = null`)
- `fsx_lustre_file_system_imported_file_chunk_size` - (Optional) For files imported from a data repository, this value determines the stripe count and maximum amount of data per file (in MiB) stored on a single physical disk. Can only be specified with import_path argument. Defaults to 1024. Minimum of 1 and maximum of 512000 (`default = 1024`)
- `fsx_lustre_file_system_security_group_ids` - (Optional) A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces. (`default = null`)
- `fsx_lustre_file_system_weekly_maintenance_start_time` - (Optional) The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone. (`default = null`)
- `fsx_lustre_file_system_timeouts` - Set timeouts for resource (`default = {}`)
- `fsx_lustre_file_system_name` - Set name for fsx lustre file system (`default = ""`)
- `enable_fsx_windows_file_system` - Enable fsx windows file system usage (`default = False`)
- `fsx_windows_file_system_storage_capacity` - (Required) Storage capacity (GiB) of the file system. Minimum of 32 and maximum of 65536. (`default = 32`)
- `fsx_windows_file_system_subnet_ids` - (Required) A list of IDs for the subnets that the file system will be accessible from. File systems support only one subnet. The file server is also launched in that subnet's Availability Zone. (`default = []`)
- `fsx_windows_file_system_throughput_capacity` - (Required) Throughput (megabytes per second) of the file system in power of 2 increments. Minimum of 8 and maximum of 2048. (`default = 8`)
- `fsx_windows_file_system_active_directory_id` - (Optional) The ID for an existing Microsoft Active Directory instance that the file system should join when it's created. Cannot be specified with self_managed_active_directory (`default = null`)
- `fsx_windows_file_system_automatic_backup_retention_days` - (Optional) The number of days to retain automatic backups. Minimum of 0 and maximum of 35. Defaults to 7. Set to 0 to disable. (`default = 7`)
- `fsx_windows_file_system_copy_tags_to_backups` - (Optional) A boolean flag indicating whether tags on the file system should be copied to backups. Defaults to false. (`default = False`)
- `fsx_windows_file_system_daily_automatic_backup_start_time` - (Optional) The preferred time (in HH:MM format) to take daily automatic backups, in the UTC time zone. (`default = null`)
- `fsx_windows_file_system_kms_key_id` - (Optional) ARN for the KMS Key to encrypt the file system at rest. Defaults to an AWS managed KMS Key. (`default = null`)
- `fsx_windows_file_system_security_group_ids` - (Optional) A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces. (`default = null`)
- `fsx_windows_file_system_skip_final_backup` - (Optional) When enabled, will skip the default final backup taken when the file system is deleted. This configuration must be applied separately before attempting to delete the resource to have the desired behavior. Defaults to false. (`default = False`)
- `fsx_windows_file_system_weekly_maintenance_start_time` - (Optional) The preferred start time (in d:HH:MM format) to perform weekly maintenance, in the UTC time zone. (`default = null`)
- `fsx_windows_file_system_self_managed_active_directory` - (Optional) Configuration block that Amazon FSx uses to join the Windows File Server instance to your self-managed (including on-premises) Microsoft Active Directory (AD) directory. Cannot be specified with active_directory_id (`default = []`)
- `fsx_windows_file_system_timeouts` - Set timeouts for fsx windows file system (`default = {}`)
- `fsx_windows_file_system_name` - Set name for fsx windows file system (`default = ""`)

## Module Output Variables
----------------------
- `fsx_lustre_file_system_id` - Identifier of the file system, e.g. fs-12345678
- `fsx_lustre_file_system_arn` - Amazon Resource Name of the file system.
- `fsx_lustre_file_system_dns_name` - DNS name for the file system, e.g. fs-12345678.fsx.us-west-2.amazonaws.com
- `fsx_lustre_file_system_network_interface_ids` - Set of Elastic Network Interface identifiers from which the file system is accessible.
- `fsx_lustre_file_system_owner_id` - AWS account identifier that created the file system.
- `fsx_lustre_file_system_vpc_id` - Identifier of the Virtual Private Cloud for the file system.
- `fsx_windows_file_system_id` - Identifier of the file system, e.g. fs-12345678
- `fsx_windows_file_system_arn` - Amazon Resource Name of the file system.
- `fsx_windows_file_system_dns_name` - DNS name for the file system, e.g. fs-12345678.corp.example.com (domain name matching the Active Directory domain name)
- `fsx_windows_file_system_network_interface_ids` - Set of Elastic Network Interface identifiers from which the file system is accessible.
- `fsx_windows_file_system_owner_id` - AWS account identifier that created the file system.
- `fsx_windows_file_system_vpc_id` - Identifier of the Virtual Private Cloud for the file system.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
