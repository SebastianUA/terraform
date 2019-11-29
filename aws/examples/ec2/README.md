# Work with AWS EC2 via terraform

A terraform module for making ec2 instances.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "> 0.12.12"
}

provider "aws" {
    region  = "us-west-2"
    profile = "default"
}

module "ec2" {
    source                              = "../../modules/ec2"
    name                                = "TEST-Machine"    
    region                              = "us-west-2"

    enable_instance                     = true
    environment                         = "dev"
    instance_type                   = "t2.micro"
    enable_associate_public_ip_address  = true
    disk_size                           = 8
    tenancy                             = "default"
    iam_instance_profile                = ""
    subnet_id                           = ""
    vpc_security_group_ids              = []

    monitoring                          = true
}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST-EC2"`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default     = "us-east-1"`) 
- `environment` - Environment for service (`default     = "STAGE"`)
- `orchestration` - Type of orchestration (`default     = "Terraform"`)
- `createdby` - Created by (`default     = "Vitaliy Natarov"`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch. (`default     = {}`)
- `enable_instance` - Enable instance usage (`default       = false`)
- `instance_name` - Name for AWS EC2 node(s) (`default       = ""`)
- `ami` - I added only 3 regions to show the map feature but you can add all
- `availability_zone` - (Optional) The AZ to start the instance in. (`default       = ""`)
- `instance_type` - Type of instance t2.micro, m1.xlarge, c1.medium etc (`default     = "t2.micro"`)
- `disk_size` - disk size for EC2 instance (`default     = 8`)
- `tenancy` - The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host. (`default     = "default"`)
- `host_id` - (optional) The Id of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host. (`default       = ""`)
- `cpu_core_count` - (Optional) Sets the number of CPU cores for an instance. This option is only supported on creation of instance type that support CPU Options CPU Cores and Threads Per CPU Core Per Instance Type - specifying this option for unsupported instance types will return an error from the EC2 API. (`default       = 0`)
- `cpu_threads_per_core` - (Optional - has no effect unless cpu_core_count is also set) If set to to 1, hyperthreading is disabled on the launched instance. Defaults to 2 if not set. See Optimizing CPU Options for more information. (`default       = 2`)
- `ebs_optimized` - If true, the launched EC2 instance will be EBS-optimized (`default     = false`)
- `disable_api_termination` - If true, enables EC2 Instance Termination Protection (`default     = false`)
- `instance_initiated_shutdown_behavior` - Shutdown behavior for the instance (`default     = ""`)
- `key_name` - (Optional) The name for the key pair. (`default     = ""`)
- `get_password_data` - (Optional) If true, wait for password data to become available and retrieve it. Useful for getting the administrator password for instances running Microsoft Windows. The password data is exported to the password_data attribute. See GetPasswordData for more information. (`default     = false`)
- `security_groups` - (Optional, EC2-Classic and default VPC only) A list of security group names (EC2-Classic) or IDs (default VPC) to associate with. (`default       = []`)
- `enable_associate_public_ip_address` - Enabling associate public ip address (Associate a public ip address with an instance in a VPC) (`default     = true`)
- `source_dest_check` -  (Optional) Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true. (`default     = false`)
- `subnet_id` - Public subnet ID (`default     = ""`)
- `vpc_security_group_ids` -  SG for EC2 (`default     = []`)
- `monitoring` - If true, the launched EC2 instance will have detailed monitoring enabled (`default     = false`)
- `user_data` - The user data to provide when launching the instance (`default     = ""`)
- `iam_instance_profile` - The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. (`default     = ""`)
- `placement_group` - The Placement Group to start the instance in (`default     = ""`)
- `private_ip` - Private IP address to associate with the instance in a VPC (`default     = ""`)
- `ipv6_address_count` - A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet. (`default     = 0`)
- `ipv6_addresses` - Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface (`default     = []`)
- `volume_tags` - A mapping of tags to assign to the devices created by the instance at launch time (`type        = map(string)
    default     = {}`)
- `root_block_device` - Customize details about the root block device of the instance. See Block Devices below for details (`default     = []`)
- `ebs_block_device` - Additional EBS block devices to attach to the instance (`default     = []`)
- `ephemeral_block_device` - Customize Ephemeral (also known as Instance Store) volumes on the instance (`default     = []`)
- `network_interface` - Customize network interfaces to be attached at instance boot time (`default     = []`)
- `timeouts_create` - (Defaults to 10 mins) Used when launching the instance (until it reaches the initial running state) (`default       = "10m"`)
- `timeouts_update` - (Defaults to 10 mins) Used when stopping and starting the instance when necessary during update - e.g. when changing instance type (`default       = "10m"`)
- `timeouts_delete` - (Defaults to 20 mins) Used when terminating the instance (`default       = "20m"`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
