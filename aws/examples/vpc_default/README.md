# Work with VPC_DEFAULT via terraform

A terraform module for making VPC_DEFAULT.


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

module "vpc_default" {
  source = "../../modules/vpc_default"

  # Default VPC
  enable_default_vpc               = true
  default_vpc_enable_dns_support   = true
  default_vpc_enable_dns_hostnames = true
  default_vpc_enable_classiclink   = false

  # Default VPC subnet
  default_subnet_azs = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]

  # Default VPC SG


  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `availability_zones` - A list of Availability zones in the region (`default = {'us-east-1': ['us-east-1a', 'us-east-1b', 'us-east-1c', 'us-east-1d', 'us-east-1e', 'us-east-1f'], 'us-east-2': ['us-east-2a', 'eu-east-2b', 'eu-east-2c'], 'us-west-1': ['us-west-1a', 'us-west-1c'], 'us-west-2': ['us-west-2a', 'us-west-2b', 'us-west-2c'], 'ca-central-1': ['ca-central-1a', 'ca-central-1b'], 'eu-west-1': ['eu-west-1a', 'eu-west-1b', 'eu-west-1c'], 'eu-west-2': ['eu-west-2a', 'eu-west-2b'], 'eu-central-1': ['eu-central-1a', 'eu-central-1b', 'eu-central-1c'], 'ap-south-1': ['ap-south-1a', 'ap-south-1b'], 'sa-east-1': ['sa-east-1a', 'sa-east-1c'], 'ap-northeast-1': ['ap-northeast-1a', 'ap-northeast-1c'], 'ap-southeast-1': ['ap-southeast-1a', 'ap-southeast-1b'], 'ap-southeast-2': ['ap-southeast-2a', 'ap-southeast-2b', 'ap-southeast-2c'], 'ap-northeast-2': ['ap-northeast-2a', 'ap-northeast-2c']}`)
- `enable_default_vpc` - Enable default VPC usage (`default = False`)
- `default_vpc_name` - Set custom name for default VPC (`default = ""`)
- `default_vpc_enable_dns_support` - (Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true. (`default = True`)
- `default_vpc_enable_dns_hostnames` - (Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults true. (`default = True`)
- `default_vpc_enable_classiclink` - (Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false. (`default = False`)
- `default_subnet_name` - Default subnet name for the region (`default = ""`)
- `default_subnet_map_public_ip_on_launch` - (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. (`default = null`)
- `default_subnet_azs` - A list of Availability zones in the region (`default = []`)
- `default_vpc_dhcp_options_name` - Set name for DHCP (`default = ""`)
- `default_vpc_dhcp_options_netbios_name_servers` - (Optional) List of NETBIOS name servers. (`default = null`)
- `default_vpc_dhcp_options_netbios_node_type` - (Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. For more information about these node types, see RFC 2132. (`default = null`)
- `default_security_group_name` - Set name for default SG (`default = default`)
- `default_network_acl_name` - Set name for default network ACL (`default = default`)
- `default_route_table_name` - Set default table name (`default = default table`)
- `default_route_table_propagating_vgws` - (Optional) A list of virtual gateways for propagation. (`default = null`)

## Module Output Variables
----------------------
- `default_vpc_arn` - Amazon Resource Name (ARN) of VPC
- `default_vpc_id` - The ID of the VPC
- `default_vpc_cidr_block` - The CIDR block of the VPC
- `default_vpc_instance_tenancy` - Tenancy of instances spin up within VPC.
- `default_vpc_enable_dns_support` - Whether or not the VPC has DNS support
- `default_vpc_enable_dns_hostnames` - Whether or not the VPC has DNS hostname support
- `default_vpc_enable_classiclink` - Whether or not the VPC has Classiclink enabled
- `default_vpc_main_route_table_id` - The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an aws_main_route_table_association.
- `default_vpc_default_network_acl_id` - The ID of the network ACL created by default on VPC creation
- `default_vpc_default_security_group_id` - The ID of the security group created by default on VPC creation
- `default_vpc_default_route_table_id` - The ID of the route table created by default on VPC creation
- `default_vpc_ipv6_association_id` - The association ID for the IPv6 CIDR block.
- `default_vpc_ipv6_cidr_block` - The IPv6 CIDR block.
- `default_vpc_owner_id` - The ID of the AWS account that owns the VPC.
- `default_subnet_id` - The ID of the subnet
- `default_subnet_availability_zone` - The AZ for the subnet.
- `default_subnet_availability_zone_id` - The AZ ID of the subnet.
- `default_cidr_block` - The CIDR block for the subnet.
- `default_subnet_vpc_id` - The VPC ID.
- `default_subnet_ipv6_cidr_block` - The IPv6 CIDR block.
- `default_subnet_owner_id` - The ID of the AWS account that owns the subnet.
- `default_vpc_dhcp_options_id` - The ID of the DHCP Options Set.
- `default_vpc_dhcp_options_owner_id` - The ID of the AWS account that owns the DHCP options set.
- `default_security_group_id` - The ID of the security group
- `default_security_group_vpc_id` - The VPC ID.
- `default_security_group_owner_id` - The owner ID.
- `default_security_group_name` - The name of the security group
- `default_security_group_description` - The description of the security group
- `default_security_group_ingress` - The ingress rules. See above for more.
- `default_security_group_egress` - The egress rules. See above for more.
- `default_network_acl_id` - The ID of the Default Network ACL
- `default_network_acl_vpc_id` - The ID of the associated VPC
- `default_network_acl_ingress` - Set of ingress rules
- `default_network_acl_egress` - Set of egress rules
- `default_network_acl_subnet_ids` - IDs of associated Subnets
- `default_network_acl_owner_id` - The ID of the AWS account that owns the Default Network ACL
- `default_route_table_id` - The ID of the routing table
- `default_route_table_owner_id` - The ID of the AWS account that owns the route table


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
