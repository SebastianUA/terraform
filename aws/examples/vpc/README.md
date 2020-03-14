# Work with AWS VPC via terraform

A terraform module for making AWS Virtual Private Cloud.

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

module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "mytest"
    environment                         = "stage"

    # VPC
    enable_vpc                          = true
    vpc_name                            = ""

    instance_tenancy                    = "dedicated"
    enable_dns_support                  = true
    enable_dns_hostnames                = true
    assign_generated_ipv6_cidr_block    = false
    # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
    enable_classiclink                  = false

    vpc_cidr                            = "172.32.0.0/16"
    private_subnet_cidrs                = ["172.32.64.0/20"]
    public_subnet_cidrs                 = ["172.32.80.0/20", "172.32.0.0/20"]
    #azs                                 = ["us-east-1a", "us-east-1b"]


    #Internet-GateWay
    enable_internet_gateway             = true
    #NAT
    #enable_nat_gateway                  = true
    single_nat_gateway                  = true
    #VPN
    enable_vpn_gateway                  = false
    #DHCP
    enable_dhcp                         = true
    # EIP
    enable_eip                          = false

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = ""`)
- `enable_vpc` - Enable VPC usage (`default = ""`)
- `vpc_name` - name for VPC (`default = ""`)
- `vpc_cidr` - (Required) The CIDR block for the VPC. (`default = ""`)
- `instance_tenancy` - (Optional) A tenancy option for instances launched into the VPC (`default = default`)
- `enable_dns_support` - (Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true. (`default = True`)
- `enable_dns_hostnames` - (Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false. (`default = ""`)
- `enable_classiclink` - (Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false. Dedicated tenancy VPCs cannot be enabled for ClassicLink by default (`default = ""`)
- `enable_classiclink_dns_support` - (Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic. (`default = True`)
- `assign_generated_ipv6_cidr_block` - (Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false. (`default = ""`)
- `private_subnet_cidrs` - CIDR for the Private Subnet (`default = ""`)
- `vpc_id` - The VPC ID. (`default = ""`)
- `azs` - A list of Availability zones in the region (`default = ""`)
- `availability_zones` - A list of Availability zones in the region (`default = {'us-east-1': ['us-east-1a', 'us-east-1b', 'us-east-1c', 'us-east-1d', 'us-east-1e', 'us-east-1f'], 'us-east-2': ['us-east-2a', 'eu-east-2b', 'eu-east-2c'], 'us-west-1': ['us-west-1a', 'us-west-1c'], 'us-west-2': ['us-west-2a', 'us-west-2b', 'us-west-2c'], 'ca-central-1': ['ca-central-1a', 'ca-central-1b'], 'eu-west-1': ['eu-west-1a', 'eu-west-1b', 'eu-west-1c'], 'eu-west-2': ['eu-west-2a', 'eu-west-2b'], 'eu-central-1': ['eu-central-1a', 'eu-central-1b', 'eu-central-1c'], 'ap-south-1': ['ap-south-1a', 'ap-south-1b'], 'sa-east-1': ['sa-east-1a', 'sa-east-1c'], 'ap-northeast-1': ['ap-northeast-1a', 'ap-northeast-1c'], 'ap-southeast-1': ['ap-southeast-1a', 'ap-southeast-1b'], 'ap-southeast-2': ['ap-southeast-2a', 'ap-southeast-2b', 'ap-southeast-2c'], 'ap-northeast-2': ['ap-northeast-2a', 'ap-northeast-2c']}`)
- `availability_zone_id` - (Optional) The AZ ID of the subnet. (`default = ""`)
- `private_subnet_ipv6_cidrs` - (Optional) The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length. (`default = ""`)
- `private_subnets_name` - Name for private subnets (`default = ""`)
- `assign_ipv6_address_on_creation` - (Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false (`default = ""`)
- `public_subnet_cidrs` - CIDR for the Public Subnet (`default = ""`)
- `map_public_ip_on_launch` - should be false if you do not want to auto-assign public IP on launch (`default = True`)
- `public_subnet_ipv6_cidrs` - (Optional) The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length. (`default = ""`)
- `public_subnets_name` - Name for private subnets (`default = ""`)
- `subnet_timeouts_create` - (Default 10m) How long to wait for a subnet to be created. (`default = 10m`)
- `subnet_timeouts_delete` - (Default 20m) How long to retry on DependencyViolation errors during subnet deletion from lingering ENIs left by certain AWS services such as Elastic Load Balancing. NOTE: Lambda ENIs can take up to 45 minutes to delete, which is not affected by changing this customizable timeout (in version 2.31.0 and later of the Terraform AWS Provider) unless it is increased above 45 minutes. (`default = 20m`)
- `enable_vpn_gateway` - Should be true if you want to create a new VPN Gateway resource and attach it to the VPC (`default = ""`)
- `vpn_gw_availability_zone` - (Optional) The Availability Zone for the virtual private gateway. (`default = ""`)
- `vpn_gw_amazon_side_asn` - (Optional) The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN. (`default = ""`)
- `vpn_gw_name` - Set name for VPC GW (`default = ""`)
- `vpn_gw_attachment_vpn_gateway_id` - The ID of the Virtual Private Gateway. (`default = ""`)
- `vpn_gateway_route_propagation_route_table_id` - The id of the aws_route_table to propagate routes into. (`default = ""`)
- `enable_dhcp` - Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type (`default = ""`)
- `vpc_dhcp_name` - Set name for VPC DHCP (`default = ""`)
- `dhcp_options_domain_name` - (Optional) the suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the search value in the /etc/resolv.conf file. (`default = ""`)
- `dhcp_options_domain_name_servers` - (Optional) List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to AmazonProvidedDNS. (`default = ['AmazonProvidedDNS']`)
- `dhcp_options_ntp_servers` - (Optional) List of NTP servers to configure. (`default = ""`)
- `dhcp_options_netbios_name_servers` - (Optional) List of NETBIOS name servers. (`default = ""`)
- `dhcp_options_netbios_node_type` - (Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. For more information about these node types, see RFC 2132. (`default = ""`)
- `dhcp_options_id` - The ID of the DHCP Options Set to associate to the VPC. (`default = ""`)
- `enable_internet_gateway` - Allow Internet GateWay to/from public network (`default = ""`)
- `internet_gw_name` - Name for internet gw (`default = ""`)
- `enable_nat_gateway` - Allow Nat GateWay to/from private network (`default = ""`)
- `single_nat_gateway` - should be true if you want to provision a single shared NAT Gateway across all of your private networks (`default = ""`)
- `enable_eip` - Allow creation elastic eip (`default = ""`)
- `nat_eip_vpc` - (Optional) Boolean if the EIP is in a VPC or not. (`default = True`)
- `nat_eip_instance` - (Optional) EC2 instance ID. (`default = ""`)
- `nat_eip_network_interface` - (Optional) Network interface ID to associate with. (`default = ""`)
- `nat_eip_associate_with_private_ip` - (Optional) A user specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address. (`default = ""`)
- `nat_eip_public_ipv4_pool` - (Optional) EC2 IPv4 address pool identifier or amazon. This option is only available for VPC EIPs. (`default = ""`)
- `nat_eip_name` - Set name for NAT EIP (`default = ""`)
- `timeouts_create` - (Default 2 minutes) Used for route creation (`default = 2m`)
- `timeouts_delete` - (Default 5 minutes) Used for route deletion (`default = 5m`)
- `private_propagating_vgws` - A list of VGWs the private route table should propagate. (`default = ""`)
- `private_route_tables_name` - Set name for private route tables (`default = ""`)
- `public_propagating_vgws` - A list of VGWs the public route table should propagate. (`default = ""`)
- `public_route_tables_name` - Set name for public route tables (`default = ""`)

## Module Output Variables
----------------------
- `vpc_arn` - Amazon Resource Name (ARN) of VPC
- `vpc_id` - The ID of the VPC
- `vpc_cidr_block` - The CIDR block of the VPC
- `vpc_instance_tenancy` - Tenancy of instances spin up within VPC.
- `vpc_enable_dns_support` - Whether or not the VPC has DNS support
- `vpc_enable_dns_hostnames` - Whether or not the VPC has DNS hostname support
- `vpc_enable_classiclink` - Whether or not the VPC has Classiclink enabled
- `vpc_main_route_table_id` - The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an aws_main_route_table_association.
- `vpc_default_network_acl_id` - The ID of the network ACL created by default on VPC creation
- `vpc_default_security_group_id` - The ID of the security group created by default on VPC creation
- `vpc_default_route_table_id` - The ID of the route table created by default on VPC creation
- `vpc_ipv6_association_id` - The association ID for the IPv6 CIDR block.
- `vpc_ipv6_cidr_block` - The IPv6 CIDR block.
- `vpc_owner_id` - The ID of the AWS account that owns the VPC.
- `private_subnets_id` - The ID of the subnet
- `private_subnets_arn` - The ARN of the subnet.
- `private_subnets_owner_id` - The ID of the AWS account that owns the subnet.
- `public_subnets_id` - The ID of the subnet
- `public_subnets_arn` - The ARN of the subnet.
- `public_subnets_owner_id` - The ID of the AWS account that owns the subnet.
- `vpn_gw_id` - The ID of the VPN Gateway.
- `vpn_gateway_attachment_id` - The ID of the VPN Gateway attachment.
- `vpn_gateway_attachment_vpc_id` - The ID of the VPC that Virtual Private Gateway is attached to.
- `vpn_gateway_attachment_vpn_gateway_id` - The ID of the Virtual Private Gateway.
- `vpc_dhcp_options_id` - The ID of the DHCP Options Set.
- `vpc_dhcp_options_owner_id` - The ID of the AWS account that owns the DHCP options set.
- `vpc_dhcp_options_association_id` - The ID of the DHCP Options Set Association.
- `nat_gw_id` - The ID of the NAT Gateway.
- `nat_gw_allocation_id` - The Allocation ID of the Elastic IP address for the gateway.
- `nat_gw_subnet_id` - The Subnet ID of the subnet in which the NAT gateway is placed.
- `nat_gw_network_interface_id` - The ENI ID of the network interface created by the NAT gateway.
- `nat_gw_private_ip` - The private IP address of the NAT Gateway.
- `nat_gw_public_ip` - The public IP address of the NAT Gateway.
- `nat_eip_id` - The ID of the NAT Gateway.
- `nat_eip_vpc` - (Optional) Boolean if the EIP is in a VPC or not.
- `nat_eip_instance` - (Optional) EC2 instance ID.
- `nat_eip_network_interface` - (Optional) Network interface ID to associate with.
- `nat_eip_associate_with_private_ip` - (Optional) A user specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address.
- `nat_eip_tags` - (Optional) A mapping of tags to assign to the resource.
- `nat_eip_public_ipv4_pool` - (Optional) EC2 IPv4 address pool identifier or amazon. This option is only available for VPC EIPs.
- `private_nat_gateway_id` - Route Table identifier and destination
- `public_internet_gateway_id` - Route Table identifier and destination
- `private_route_tables_id` - The ID of the routing table.
- `private_route_tables_owner_id` - The ID of the AWS account that owns the route table.
- `public_route_tables_id` - The ID of the routing table.
- `public_route_tables_owner_id` - The ID of the AWS account that owns the route table.
- `private_route_table_associations_id` - The ID of the association
- `public_route_table_associations_id` - The ID of the association


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
