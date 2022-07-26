# Work with VPN via terraform

A terraform module for making VPN.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#---------------------------------------------------------------
# VPC VPN
#---------------------------------------------------------------
module "vpc_vpn" {
  source      = "../../modules/vpn"
  name        = "vpn"
  environment = "stage"


  # VPN
  enable_vpn_gateway            = true
  vpn_gateway_vpc_id            = "vpc-1"
  vpn_gateway_name              = "tmp-vpn"
  vpn_gateway_availability_zone = null
  vpn_gateway_amazon_side_asn   = 64512

  enable_vpn_gateway_route_propagation         = false
  vpn_gateway_route_propagation_vpn_gateway_id = ""
  vpn_gateway_route_propagation_route_table_id = "rt-434fdf"

  enable_vpn_connection             = true
  vpn_connection_static_routes_only = true

  enable_vpn_connection_route     = true
  vpn_connection_route_cidr_block = "192.168.113.0/24" # Set IP addr cidr; For example: office's IP subnet.

  enable_customer_gateway     = true
  customer_gateway_bgp_asn    = 65000
  customer_gateway_ip_address = "1.2.3.4" # Set IP addr gateway; For example: office's IP GW.

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
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_vpn_gateway` - Should be true if you want to create a new VPN Gateway resource and attach it to the VPC (`default = False`)
- `vpn_gateway_name` - Set name for VPC GW (`default = ""`)
- `vpn_gateway_vpc_id` - (Optional) The VPC ID to create in. (`default = null`)
- `vpn_gateway_availability_zone` - (Optional) The Availability Zone for the virtual private gateway. (`default = null`)
- `vpn_gateway_amazon_side_asn` - (Optional) The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN. (`default = null`)
- `enable_vpn_gateway_attachment` - Enable vpn gateway attachment usage (`default = False`)
- `vpn_gateway_attachment_vpc_id` - (Required) The ID of the VPC. (`default = ""`)
- `vpn_gateway_attachment_vpn_gateway_id` - (Required) The ID of the Virtual Private Gateway. (`default = ""`)
- `enable_vpn_gateway_route_propagation` - Enable vpn gateway route propagation usage (`default = False`)
- `vpn_gateway_route_propagation_vpn_gateway_id` - The id of the aws_vpn_gateway to propagate routes from. (`default = ""`)
- `vpn_gateway_route_propagation_route_table_id` - The id of the aws_route_table to propagate routes into. (`default = ""`)
- `vpn_gateway_route_propagation_timeouts` - Set timeouts for VPN gateway route propagation (`default = {}`)
- `enable_vpn_connection` - Enable vpn connection usage (`default = False`)
- `vpn_connection_name` - Set name for VPC vpn connection (`default = ""`)
- `vpn_connection_customer_gateway_id` - The ID of the customer gateway. (`default = ""`)
- `vpn_connection_type` - (Required) The type of VPN connection. The only type AWS supports at this time is 'ipsec.1'. (`default = ipsec.1`)
- `vpn_connection_transit_gateway_id` - (Optional) The ID of the EC2 Transit Gateway. (`default = null`)
- `vpn_connection_vpn_gateway_id` - (Optional) The ID of the Virtual Private Gateway. (`default = null`)
- `vpn_connection_static_routes_only` - (Optional, Default false) Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP. (`default = False`)
- `vpn_connection_tunnel1_inside_cidr` - (Optional) The CIDR block of the inside IP addresses for the first VPN tunnel. (`default = null`)
- `vpn_connection_tunnel2_inside_cidr` - (Optional) The CIDR block of the inside IP addresses for the second VPN tunnel. (`default = null`)
- `vpn_connection_tunnel1_preshared_key` - (Optional) The preshared key of the first VPN tunnel. (`default = null`)
- `vpn_connection_tunnel2_preshared_key` - (Optional) The preshared key of the second VPN tunnel. (`default = null`)
- `enable_vpn_connection_route` - Enable vpn connection route usage (`default = False`)
- `vpn_connection_route_cidr_block` - (Required) The CIDR block associated with the local subnet of the customer network. (`default = null`)
- `vpn_connection_route_vpn_connection_id` - The ID of the VPN connection. (`default = ""`)
- `enable_customer_gateway` - Enable customer gateway usage (`default = False`)
- `customer_gateway_name` - Set name for VPC customer gateway (`default = ""`)
- `customer_gateway_bgp_asn` - (Required) The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). (`default = 65000`)
- `customer_gateway_ip_address` - (Required) The IP address of the gateway's Internet-routable external interface. (`default = ""`)
- `customer_gateway_type` - (Required) The type of customer gateway. The only type AWS supports at this time is 'ipsec.1'. (`default = ipsec.1`)

## Module Output Variables
----------------------
- `vpn_gateway_id` - The ID of the VPN Gateway.
- `vpn_gateway_attachment_id` - The ID of the VPN Gateway attachment.
- `vpn_gateway_attachment_vpc_id` - The ID of the VPC that Virtual Private Gateway is attached to.
- `vpn_gateway_attachment_vpn_gateway_id` - The ID of the Virtual Private Gateway.
- `vpn_gateway_route_propagation_id` - The ID of the VPN Gateway route propagation.
- `vpn_connection_id` - The amazon-assigned ID of the VPN connection.
- `vpn_connection_customer_gateway_configuration` - The configuration information for the VPN connection's customer gateway (in the native XML format).
- `vpn_connection_customer_gateway_id` - The ID of the customer gateway to which the connection is attached.
- `vpn_connection_static_routes_only` - Whether the VPN connection uses static routes exclusively.
- `vpn_connection_tags` - Tags applied to the connection.
- `vpn_connection_transit_gateway_attachment_id` - When associated with an EC2 Transit Gateway (transit_gateway_id argument), the attachment ID.
- `vpn_connection_tunnel1_address` - The public IP address of the first VPN tunnel.
- `vpn_connection_tunnel1_cgw_inside_address` - The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side).
- `vpn_connection_tunnel1_vgw_inside_address` - The RFC 6890 link-local address of the first VPN tunnel (VPN Gateway Side).
- `vpn_connection_tunnel1_preshared_key` - The preshared key of the first VPN tunnel.
- `vpn_connection_tunnel1_bgp_asn` - The bgp asn number of the first VPN tunnel.
- `vpn_connection_tunnel1_bgp_holdtime` - The bgp holdtime of the first VPN tunnel.
- `vpn_connection_tunnel2_address` - The public IP address of the second VPN tunnel.
- `vpn_connection_tunnel2_cgw_inside_address` - The RFC 6890 link-local address of the second VPN tunnel (Customer Gateway Side).
- `vpn_connection_tunnel2_vgw_inside_address` - The RFC 6890 link-local address of the second VPN tunnel (VPN Gateway Side).
- `vpn_connection_tunnel2_preshared_key` - The preshared key of the second VPN tunnel.
- `vpn_connection_tunnel2_bgp_asn` - The bgp asn number of the second VPN tunnel.
- `vpn_connection_tunnel2_bgp_holdtime` - The bgp holdtime of the second VPN tunnel.
- `vpn_connection_type` - The type of VPN connection.
- `vpn_connection_vpn_gateway_id` - The ID of the virtual private gateway to which the connection is attached.
- `vpn_connection_route_destination_cidr_block` - The CIDR block associated with the local subnet of the customer network.
- `vpn_connection_route_vpn_connection_id` - The ID of the VPN connection.
- `customer_gateway_id` - The amazon-assigned ID of the gateway.
- `customer_gateway_bgp_asn` - The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN).
- `customer_gateway_ip_address` - The IP address of the gateway's Internet-routable external interface.
- `customer_gateway_type` - The type of customer gateway.
- `customer_gateway_tags` - Tags applied to the gateway.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
