# Work with AWS VPC via terraform
=======================

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
- `name` -
- `region` -
- `environment` -


Authors
=======

Created and maintained by [Vitaliy Natrov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.