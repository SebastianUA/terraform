# Work with TRANSIT_GATEWAY via terraform

A terraform module for making TRANSIT_GATEWAY.


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

module "transit_gateway" {
  source      = "../../modules/transit_gateway"
  name        = "TEST"
  environment = "stage"

  # TGW
  enable_transit_gateway = true
  transit_gateway_name   = ""

  # TGW attachment
  enable_transit_gateway_vpc_attachment                                          = true
  transit_gateway_vpc_attachment_name                                            = ""
  transit_gateway_vpc_attachment_subnet_ids                                      = ["subnet-00db3165c99b03ee0", "subnet-07021252bab163bcf", "subnet-01b817896302a1b98"]
  transit_gateway_vpc_attachment_vpc_id                                          = "vpc-0ea8873ab2bf7900d"
  transit_gateway_default_route_table_association                                = "disable" # disable
  transit_gateway_default_route_table_propagation                                = "disable" # disable
  transit_gateway_dns_support                                                    = "enable"
  transit_gateway_vpn_ecmp_support                                               = "enable"
  transit_gateway_vpc_attachment_transit_gateway_default_route_table_association = false
  transit_gateway_vpc_attachment_transit_gateway_default_route_table_propagation = false
  transit_gateway_vpc_attachment_transit_gateway_id                              = ""

  # TGW route table
  enable_transit_gateway_route_table             = true
  transit_gateway_route_table_name               = ""
  transit_gateway_route_table_transit_gateway_id = ""

  # TGW route 
  enable_transit_gateway_route                         = true
  transit_gateway_route_destination_cidr_blocks        = ["1.2.3.4/32", "10.0.0.0/8"]
  transit_gateway_route_transit_gateway_route_table_id = ""
  transit_gateway_route_transit_gateway_attachment_id  = ""

  # TGW route table propaganation
  enable_transit_gateway_route_table_propagation                         = true
  transit_gateway_route_table_propagation_transit_gateway_attachment_id  = ""
  transit_gateway_route_table_propagation_transit_gateway_route_table_id = ""

  # TGW route table association 
  enable_transit_gateway_route_table_association                         = true
  transit_gateway_route_table_association_transit_gateway_attachment_id  = ""
  transit_gateway_route_table_association_transit_gateway_route_table_id = ""

  # TGW peering attachment
  enable_transit_gateway_peering_attachment = false

  # TGW peering attachment accepter
  enable_transit_gateway_peering_attachment_accepter                        = false
  transit_gateway_peering_attachment_accepter_transit_gateway_attachment_id = ""

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
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_transit_gateway` - Enable transit gateway (`default = False`)
- `transit_gateway_name` - Set name for TGW (`default = ""`)
- `transit_gateway_amazon_side_asn` - (Optional) Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASNs. Default value: 64512. (`default = 64512`)
- `transit_gateway_auto_accept_shared_attachments` - (Optional) Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable (`default = disable`)
- `transit_gateway_default_route_table_association` - (Optional) Whether resource attachments are automatically associated with the default association route table. Valid values: disable, enable. Default value: enable (`default = enable`)
- `transit_gateway_default_route_table_propagation` - (Optional) Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: disable, enable. Default value: enable (`default = enable`)
- `transit_gateway_description` - (Optional) Description of the EC2 Transit Gateway. (`default = null`)
- `transit_gateway_dns_support` - (Optional) Whether DNS support is enabled. Valid values: disable, enable. Default value: enable (`default = enable`)
- `transit_gateway_vpn_ecmp_support` - (Optional) Whether VPN Equal Cost Multipath Protocol support is enabled. Valid values: disable, enable. Default value: enable (`default = enable`)
- `enable_transit_gateway_vpc_attachment` - Enable TGW vpc attachment usage (`default = False`)
- `transit_gateway_vpc_attachment_name` - Set name for TGW VPC attachment (`default = ""`)
- `transit_gateway_vpc_attachment_subnet_ids` - (Required) Identifiers of EC2 Subnets. (`default = []`)
- `transit_gateway_vpc_attachment_transit_gateway_id` - Identifier of EC2 Transit Gateway. (`default = ""`)
- `transit_gateway_vpc_attachment_vpc_id` - (Required) Identifier of EC2 VPC. (`default = ""`)
- `transit_gateway_vpc_attachment_appliance_mode_support` - (Optional) Whether Appliance Mode support is enabled. If enabled, a traffic flow between a source and destination uses the same Availability Zone for the VPC attachment for the lifetime of that flow. Valid values: disable, enable. Default value: disable. (`default = disable`)
- `transit_gateway_vpc_attachment_dns_support` - (Optional) Whether DNS support is enabled. Valid values: disable, enable. Default value: enable. (`default = enable`)
- `transit_gateway_vpc_attachment_ipv6_support` - (Optional) Whether IPv6 support is enabled. Valid values: disable, enable. Default value: disable. (`default = disable`)
- `transit_gateway_vpc_attachment_transit_gateway_default_route_table_association` - (Optional) Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true (`default = True`)
- `transit_gateway_vpc_attachment_transit_gateway_default_route_table_propagation` - (Optional) Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true (`default = True`)
- `enable_transit_gateway_vpc_attachment_accepter` - Enable TGW vpc attachment accepter usage (`default = False`)
- `transit_gateway_vpc_attachment_accepter_name` - Set name for TGW VPC attachment acceper (`default = ""`)
- `transit_gateway_vpc_attachment_accepter_transit_gateway_attachment_id` - The ID of the EC2 Transit Gateway Attachment to manage. (`default = ""`)
- `transit_gateway_vpc_attachment_accepter_transit_gateway_default_route_table_association` - (Optional) Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. Default value: true. (`default = True`)
- `transit_gateway_vpc_attachment_accepter_transit_gateway_default_route_table_propagation` - (Optional) Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. Default value: true. (`default = True`)
- `enable_transit_gateway_route_table` - Enable TGW route table usage (`default = False`)
- `transit_gateway_route_table_name` - Set name for TGV route table (`default = ""`)
- `transit_gateway_route_table_transit_gateway_id` - Set an identifier of EC2 Transit Gateway. (`default = ""`)
- `enable_transit_gateway_route` - Enable TGW route usage (`default = False`)
- `transit_gateway_route_destination_cidr_blocks` - (Required) IPv4 or IPv6 RFC1924 CIDR list used for destination matches. Routing decisions are based on the most specific match. (`default = ['0.0.0.0/0']`)
- `transit_gateway_route_transit_gateway_route_table_id` - Set an identifier of EC2 Transit Gateway Route Table. (`default = ""`)
- `transit_gateway_route_transit_gateway_attachment_id` - (Optional) Identifier of EC2 Transit Gateway Attachment (required if blackhole is set to false). (`default = ""`)
- `transit_gateway_route_blackhole` - (Optional) Indicates whether to drop traffic that matches this route (default to false). (`default = False`)
- `enable_transit_gateway_route_table_propagation` - Enable TGE route table propagation usage (`default = False`)
- `transit_gateway_route_table_propagation_transit_gateway_attachment_id` - Set an identifier of EC2 Transit Gateway Attachment. (`default = ""`)
- `transit_gateway_route_table_propagation_transit_gateway_route_table_id` - Set an identifier of EC2 Transit Gateway Route Table. (`default = ""`)
- `enable_transit_gateway_route_table_association` - Enable TGW route table association usage (`default = False`)
- `transit_gateway_route_table_association_transit_gateway_attachment_id` - Set an identifier of EC2 Transit Gateway Attachment. (`default = ""`)
- `transit_gateway_route_table_association_transit_gateway_route_table_id` - Set an identifier of EC2 Transit Gateway Route Table. (`default = ""`)
- `enable_transit_gateway_peering_attachment` - Enable TGW peering attachment usage (`default = False`)
- `transit_gateway_peering_attachment_peer_account_id` - (Optional) Account ID of EC2 Transit Gateway to peer with. Defaults to the account ID the AWS provider is currently connected to. (`default = null`)
- `transit_gateway_peering_attachment_peer_transit_gateway_id` - Set an identifier of EC2 Transit Gateway to peer with. (`default = ""`)
- `transit_gateway_peering_attachment_name` - Set name for TGW peering attachment (`default = ""`)
- `transit_gateway_peering_attachment_peer_region` - (Required) Region of EC2 Transit Gateway to peer with. (`default = null`)
- `transit_gateway_peering_attachment_transit_gateway_id` - (Required) Identifier of EC2 Transit Gateway. (`default = null`)
- `enable_transit_gateway_peering_attachment_accepter` - Enable TGW peering attachment accepter usage (`default = False`)
- `transit_gateway_peering_attachment_accepter_name` - Set name for TGW peering attachment accepter (`default = ""`)
- `transit_gateway_peering_attachment_accepter_transit_gateway_attachment_id` - The ID of the EC2 Transit Gateway Peering Attachment to manage. (`default = ""`)

## Module Output Variables
----------------------
- `transit_gateway_id` - EC2 Transit Gateway identifier
- `transit_gateway_arn` - EC2 Transit Gateway Amazon Resource Name (ARN)
- `transit_gateway_association_default_route_table_id` - Identifier of the default association route table
- `transit_gateway_owner_id` - Identifier of the AWS account that owns the EC2 Transit Gateway
- `transit_gateway_propagation_default_route_table_id` - Identifier of the default propagation route table
- `transit_gateway_vpc_attachment_id` - EC2 Transit Gateway Attachment identifier
- `transit_gateway_vpc_attachment_vpc_owner_id` - Identifier of the AWS account that owns the EC2 VPC.
- `transit_gateway_vpc_attachment_accepter_id` - EC2 Transit Gateway Attachment identifier
- `transit_gateway_vpc_attachment_accepter_appliance_mode_support` - Whether Appliance Mode support is enabled. Valid values: disable, enable.
- `transit_gateway_vpc_attachment_accepter_dns_support` - Whether DNS support is enabled. Valid values: disable, enable.
- `transit_gateway_vpc_attachment_accepter_ipv6_support` - Whether IPv6 support is enabled. Valid values: disable, enable.
- `transit_gateway_vpc_attachment_accepter_subnet_ids` - Identifiers of EC2 Subnets.
- `transit_gateway_vpc_attachment_accepter_transit_gateway_id` - Identifier of EC2 Transit Gateway.
- `transit_gateway_vpc_attachment_accepter_vpc_id` - Identifier of EC2 VPC.
- `transit_gateway_vpc_attachment_accepter_vpc_owner_id` - Identifier of the AWS account that owns the EC2 VPC.
- `transit_gateway_route_table_id` - EC2 Transit Gateway Route Table identifier
- `transit_gateway_route_table_arn` - EC2 Transit Gateway Route Table Amazon Resource Name (ARN).
- `transit_gateway_route_table_default_association_route_table` - Boolean whether this is the default association route table for the EC2 Transit Gateway.
- `transit_gateway_route_table_default_propagation_route_table` - Boolean whether this is the default propagation route table for the EC2 Transit Gateway.
- `transit_gateway_route_id` - EC2 Transit Gateway Route Table identifier combined with destination
- `transit_gateway_route_table_propagation_id` - EC2 Transit Gateway Route Table identifier combined with EC2 Transit Gateway Attachment identifier
- `transit_gateway_route_table_propagation_resource_type` - Type of the resource
- `transit_gateway_route_table_propagation_resource_id` - Identifier of the resource
- `transit_gateway_route_table_association_id` - EC2 Transit Gateway Route Table identifier combined with EC2 Transit Gateway Attachment identifier
- `transit_gateway_route_table_association_resource_id` - Identifier of the resource
- `transit_gateway_route_table_association_resource_type` - Type of the resource
- `transit_gateway_peering_attachment_id` - EC2 Transit Gateway Attachment identifier
- `transit_gateway_peering_attachment_accepter_id` - EC2 Transit Gateway Attachment identifier
- `transit_gateway_peering_attachment_accepter_transit_gateway_id` - Identifier of EC2 Transit Gateway.
- `transit_gateway_peering_attachment_accepter_peer_transit_gateway_id` - Identifier of EC2 Transit Gateway to peer with.
- `transit_gateway_peering_attachment_accepter_peer_account_id` - Identifier of the AWS account that owns the EC2 TGW peering.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
