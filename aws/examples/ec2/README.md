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
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-east-1"
    profile = "default"
}
module "iam" {
    source                          = "../../modules/iam"
    name                            = "TEST-AIM"
    region                          = "us-east-1"
    environment                     = "PROD"

    aws_iam_role-principals         = [
        "ec2.amazonaws.com",
    ]
    aws_iam_policy-actions           = [
        "cloudwatch:GetMetricStatistics",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents",
        "elasticache:Describe*",
        "rds:Describe*",
        "rds:ListTagsForResource",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs",
        "ec2:Owner",
    ]
}
module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "TEST-VPC"
    environment                         = "PROD"
    # VPC
    instance_tenancy                    = "default"
    enable_dns_support                  = "true"
    enable_dns_hostnames                = "true"
    assign_generated_ipv6_cidr_block    = "false"
    enable_classiclink                  = "false"
    vpc_cidr                            = "172.31.0.0/16"
    private_subnet_cidrs                = ["172.31.64.0/20"]
    public_subnet_cidrs                 = ["172.31.0.0/20"]
    availability_zones                  = ["us-east-1a", "us-east-1b"]
    enable_all_egress_ports             = "true"
    allowed_ports                       = ["9300", "3272", "8888", "8444"]

    map_public_ip_on_launch             = "true"

    #Internet-GateWay
    enable_internet_gateway             = "true"
    #NAT
    enable_nat_gateway                  = "false"
    single_nat_gateway                  = "true"
    #VPN
    enable_vpn_gateway                  = "false"
    #DHCP
    enable_dhcp_options                 = "false"
    # EIP
    enable_eip                          = "false"
}
module "ec2" {
    source                              = "../../modules/ec2"
    name                                = "TEST-Machine"    
    region                              = "us-east-1"
    environment                         = "PROD"
    ec2_instance_type                   = "t2.micro"
    enable_associate_public_ip_address  = "true"
    disk_size                           = "8"
    tenancy                             = "${module.vpc.instance_tenancy}"
    iam_instance_profile                = "${module.iam.instance_profile_id}"
    subnet_id                           = "${element(module.vpc.vpc-publicsubnet-ids, 0)}"
    #subnet_id                           = "${element(module.vpc.vpc-privatesubnet-ids, 0)}"
    #subnet_id                           = ["${element(module.vpc.vpc-privatesubnet-ids)}"]
    vpc_security_group_ids              = ["${module.vpc.security_group_id}"]

    monitoring                          = "true"
}
```

Module Input Variables
----------------------

- `name`- Name to be used on all resources as prefix (`default = TEST-EC2`).
- `environment` - Environment for service (`default = stage`). Just uses for tag.
- `orchestration` - Type of orchestration (`default = Terraform`). Just uses for tag.
- `createdby` - Created by (`default = Vitaliy Natarov`). Just uses for tag.
- `ami` - I added only 3 regions to show the map feature but you can add all (`default     = {
        us-east-1 = "ami-46c1b650"
        us-west-2 = "ami-46c1b650"
        eu-west-1 = "ami-6e28b517"
    }
`).
- `number_of_instances` - Number of instances to make(`default = 1`).
- `ec2_instance_type` - Type of instance t2.micro, m1.xlarge, c1.medium etc (`default = t2.micro`).
- `disk_size` - disk size for EC2 instance (`default = 8`).
- `tenancy` - The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host (`default = default`).
- `ebs_optimized` - If true, the launched EC2 instance will be EBS-optimized (`default = false`).
- `disable_api_termination` - If true, enables EC2 Instance Termination Protection (`default = false`).
- `instance_initiated_shutdown_behavior` - Shutdown behavior for the instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior (`default = false`).
- `public_key` - Key path to your RSA|DSA public key (`default = /Users/captain/.ssh/id_rsa.pub`).
- `private_key` - Private key (`default = /Users/captain/.ssh/id_rsa`).
- `enable_associate_public_ip_address` - Enabling associate public ip address (`default = true`).
- `source_dest_check` - (Optional) Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true (`default = false`).
- `subnet_id` - Public subnet ID
- `vpc_security_group_ids` - SG for EC2.
- `monitoring` - If true, the launched EC2 instance will have detailed monitoring enabled (`default = false`).
- `user_data` - The user data to provide when launching the instance (`default = ""`).
- `iam_instance_profile` - The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile (`default = ""`).
- `placement_group` - The Placement Group to start the instance in (`default = ""`).
- `private_ip` - Private IP address to associate with the instance in a VPC (`default = ""`).
- `ipv6_address_count` - A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet (`default = 0`).
- `ipv6_addresses` - Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface (`default = []`).
- `volume_tags` - A mapping of tags to assign to the devices created by the instance at launch time (`default = {}`).
- `root_block_device` - Customize details about the root block device of the instance. See Block Devices below for details (`default = []`).
- `ebs_block_device` - Additional EBS block devices to attach to the instance (`default = []`).
- `ephemeral_block_device` - Customize Ephemeral (also known as Instance Store) volumes on the instance (`default = []`).
- `network_interface` - Customize network interfaces to be attached at instance boot time (`default = []`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
