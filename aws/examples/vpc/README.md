# Work with AWS VPC via terraform

A terraform module for making VPC.

## Usage
----------------------

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
    # alias = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "main"
    environment                         = "PROD"
    # VPC
    instance_tenancy                    = "dedicated"
    enable_dns_support                  = "true"
    enable_dns_hostnames                = "true"
    assign_generated_ipv6_cidr_block    = "false"
    enable_classiclink                  = "false"
    vpc_cidr                            = "172.31.0.0/16"
    private_subnet_cidrs                = ["172.31.64.0/20"]
    public_subnet_cidrs                 = ["172.31.80.0/20"]
    availability_zones                  = ["us-east-1a"]
    allowed_ports                       = ["80", "3272", "8888", "8444"]
    
    #Internet-GateWay
    enable_internet_gateway             = "true" 
    #NAT
    enable_nat_gateway                  = "true"
    single_nat_gateway                  = "false"
    #VPN
    enable_vpn_gateway                  = "true"
    #DHCP
    enable_dhcp_options                 = "true"
    # EIP
    enable_eip                          = "true"   
}

```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix" (`default = "TEST"`).
- `instance_tenancy` - instance tenancy (`default = default`).
- `enable_dns_support` - Enabling dns support (`default = true`).
- `enable_dns_hostnames` - Enabling dns hostnames (`default = true`).
- `assign_generated_ipv6_cidr_block` - Generation IPv6" (`default = false`).
- `enable_classiclink` - Enabling classiclink (`default = false`).
- `environment` - Environment for service (`default = stage`). Just uses for tag.
- `orchestration` - Type of orchestration (`default = Terraform`). Just uses for tag.
- `createdby` - Created by (`default = Vitaliy Natarov`). Just uses for tag.
- `allowed_ports` - Allowed ports from/to host.
- `enable_all_egress_ports` - Allows all ports from host (`default = false`).
- `vpc_cidr` - CIDR for the whole VPC.
- `public_subnet_cidrs` - CIDR for the Public Subnet.
- `private_subnet_cidrs` - CIDR for the Private Subnet.
- `availability_zones` - A list of Availability zones in the region.
- `enable_internet_gateway` - Allow Internet GateWay to/from public network (`default = false`).
- `private_propagating_vgws` - A list of VGWs the private route table should propagate.
- `public_propagating_vgws` - A list of VGWs the public route table should propagate.
- `enable_vpn_gateway` - Should be true if you want to create a new VPN Gateway resource and attach it to the VPC (`default = false`). 
- `enable_nat_gateway` - Allow Nat GateWay to/from private network (`default = false`). 
- `single_nat_gateway` - Should be true if you want to provision a single shared NAT Gateway across all of your private networks (`default = false`). 
- `enable_eip` - Allow creation elastic eip (`default = false`). 
- `map_public_ip_on_launch` - Should be false if you do not want to auto-assign public IP on launch (`default = true`). 
- `enable_dhcp_options` - Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type (`default = false`).
- `dhcp_options_domain_name` - Specifies DNS name for DHCP options set (`default = ""`).
- `dhcp_options_domain_name_servers` - Specify a list of DNS server addresses for DHCP options set, default to AWS provided (`default = ["AmazonProvidedDNS"]`).
- `dhcp_options_ntp_servers` - Specify a list of NTP servers for DHCP options set (`default = []`).
- `dhcp_options_netbios_name_servers` - Specify a list of netbios servers for DHCP options set (`default = []`).
- `dhcp_options_netbios_node_type` - Specify netbios node_type for DHCP options set (`default = ""`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
