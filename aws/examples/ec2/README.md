# Work with EC2 via terraform

A terraform module for making EC2.


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
  region  = "us-west-2"
  profile = "default"
}

module "ec2" {
  source = "../../modules/ec2"

  region      = "us-west-2"
  environment = "dev"


  enable_instance                      = true
  instance_name                        = "ec2-test-machine-dev"
  instance_type                        = "t2.micro"
  instance_associate_public_ip_address = true
  instance_disk_size                   = 8
  instance_tenancy                     = "default"
  instance_iam_instance_profile        = ""
  instance_subnet_id                   = ""
  instance_vpc_security_group_ids      = []

  instance_monitoring = true

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `ami` - Default AMIs by region (`default = {'us-east-1': 'ami-46c1b650', 'us-west-2': 'ami-50d1d929', 'eu-west-1': 'ami-6e28b517'}`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch. (`default = {}`)
- `enable_instance` - Enable instance usage (`default = False`)
- `instance_name` - Name for AWS EC2 node(s) (`default = ""`)
- `instance_ami` - Set AMI ID for AWS EC2 instance (`default = ""`)
- `instance_availability_zone` - (Optional) The AZ to start the instance in. (`default = null`)
- `instance_type` - Type of instance t2.micro, m1.xlarge, c1.medium etc (`default = t2.micro`)
- `instance_disk_size` - disk size for EC2 instance (`default = 8`)
- `instance_tenancy` - (Optional) The tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of dedicated runs on single-tenant hardware. The host tenancy is not supported for the import-instance command. Available values: default, dedicated, host. (`default = default`)
- `instance_host_id` - (Optional) The Id of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host. (`default = null`)
- `instance_cpu_core_count` - (Optional) Sets the number of CPU cores for an instance. This option is only supported on creation of instance type that support CPU Options CPU Cores and Threads Per CPU Core Per Instance Type - specifying this option for unsupported instance types will return an error from the EC2 API. (`default = null`)
- `instance_cpu_threads_per_core` - (Optional - has no effect unless cpu_core_count is also set) If set to to 1, hyperthreading is disabled on the launched instance. Defaults to 2 if not set. See Optimizing CPU Options for more information. (`default = 2`)
- `instance_ebs_optimized` - (Optional) If true, the launched EC2 instance will be EBS-optimized. Note that if this is not set on an instance type that is optimized by default then this will show as disabled but if the instance type is optimized by default then there is no need to set this and there is no effect to disabling it. See the EBS Optimized section of the AWS User Guide for more information. If true, the launched EC2 instance will be EBS-optimized (`default = null`)
- `instance_disable_api_termination` -  (Optional) If true, enables EC2 Instance Termination Protection (`default = null`)
- `instance_initiated_shutdown_behavior` - (Optional) Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instances. See Shutdown Behavior for more information. (`default = null`)
- `instance_key_name` - (Optional) The key name of the instance (`default = null`)
- `instance_get_password_data` - (Optional) If true, wait for password data to become available and retrieve it. Useful for getting the administrator password for instances running Microsoft Windows. The password data is exported to the password_data attribute. See GetPasswordData for more information. (`default = null`)
- `instance_security_groups` - (Optional, EC2-Classic and default VPC only) A list of security group names (EC2-Classic) or IDs (default VPC) to associate with. (`default = []`)
- `instance_associate_public_ip_address` - (Optional) Associate a public ip address with an instance in a VPC. (`default = null`)
- `instance_source_dest_check` - (Optional) Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true. (`default = True`)
- `instance_subnet_id` - (Optional) The VPC Subnet ID to launch in. (`default = null`)
- `instance_vpc_security_group_ids` - The associated security groups in non-default VPC (`default = []`)
- `instance_monitoring` - (Optional) If true, the launched EC2 instance will have detailed monitoring enabled. If true, the launched EC2 instance will have detailed monitoring enabled (`default = null`)
- `instance_user_data` - (Optional) The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead. (`default = null`)
- `instance_user_data_base64` - (Optional) Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. (`default = null`)
- `instance_iam_instance_profile` - (Optional) The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. Ensure your credentials have the correct permission to assign the instance profile according to the EC2 documentation, notably iam:PassRole. (`default = null`)
- `instance_placement_group` - (Optional) The Placement Group to start the instance in. (`default = null`)
- `instance_placement_partition_number` - (Optional) The number of the partition the instance is in. Valid only if the aws_placement_group resource's strategy argument is set to 'partition'. (`default = null`)
- `instance_private_ip` - (Optional) Private IP address to associate with the instance in a VPC. (`default = null`)
- `instance_ipv6_address_count` - (Optional) A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet. (`default = null`)
- `instance_ipv6_addresses` - (Optional) Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface (`default = null`)
- `instance_volume_tags` - A mapping of tags to assign to the devices created by the instance at launch time (`default = {}`)
- `instance_root_block_device` - Customize details about the root block device of the instance. See Block Devices below for details (`default = []`)
- `instance_ebs_block_device` - Additional EBS block devices to attach to the instance (`default = []`)
- `instance_ephemeral_block_device` - Customize Ephemeral (also known as Instance Store) volumes on the instance (`default = []`)
- `instance_network_interface` - Customize network interfaces to be attached at instance boot time (`default = []`)
- `instance_timeouts` - Set timeout for EC2 instance (`default = {}`)
- `instance_capacity_reservation_specification` - (Optional) Describes an instance's Capacity Reservation targeting option. (`default = []`)
- `instance_credit_specification` - (Optional) Configuration block for customizing the credit specification of the instance. See Credit Specification below for more details. Terraform will only perform drift detection of its value when present in a configuration. Removing this configuration on existing instances will only stop managing it. It will not change the configuration back to the default for the instance type. (`default = []`)
- `instance_enclave_options` - (Optional) Enable Nitro Enclaves on launched instances. (`default = {}`)
- `instance_hibernation` - (Optional) If true, the launched EC2 instance will support hibernation. (`default = null`)
- `instance_secondary_private_ips` - (Optional) A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e., referenced in a network_interface block. Refer to the Elastic network interfaces documentation to see the maximum number of private IP addresses allowed per instance type. (`default = null`)

## Module Output Variables
----------------------
- `instance_ids` - ""
- `availability_zone` - List of availability zones of instances
- `key_name` - List of key names of instances
- `public_dns` - List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC
- `public_ip` - List of public IP addresses assigned to the instances, if applicable
- `primary_network_interface_id` - List of IDs of the primary network interface of instances
- `private_dns` - List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC
- `private_ip` - List of private IP addresses assigned to the instances
- `security_groups` - List of associated security groups of instances
- `vpc_security_group_ids` - List of associated security groups of instances, if running in non-default VPC
- `subnet_id` - List of IDs of VPC subnets of instances
- `tags` - List of tags of instances


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
