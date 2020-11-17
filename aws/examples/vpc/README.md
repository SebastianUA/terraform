# Work with AWS VPC via terraform

A terraform module for making VPC.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#---------------------------------------------------------------
# VPC
#---------------------------------------------------------------
module "vpc" {
  source      = "../../modules/vpc"
  name        = "vpc"
  environment = "dev"

  # VPC
  enable_vpc = true
  vpc_name   = "vpc"

  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  vpc_cidr             = "12.6.0.0/16"
  private_subnet_cidrs = ["12.6.1.0/24"]
  public_subnet_cidrs  = ["12.6.2.0/24", "12.6.3.0/24"]

  #Internet-GateWay
  enable_internet_gateway = true
  #NAT
  enable_nat_gateway = true
  single_nat_gateway = true

  #DHCP
  enable_dhcp                      = true
  dhcp_options_domain_name         = "ec2.internal"
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  tags = map("Env", "stage", "Orchestration", "Terraform")
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
- `availability_zones` - A list of Availability zones in the region (`default = {'us-east-1': ['us-east-1a', 'us-east-1b', 'us-east-1c', 'us-east-1d', 'us-east-1e', 'us-east-1f'], 'us-east-2': ['us-east-2a', 'eu-east-2b', 'eu-east-2c'], 'us-west-1': ['us-west-1a', 'us-west-1c'], 'us-west-2': ['us-west-2a', 'us-west-2b', 'us-west-2c'], 'ca-central-1': ['ca-central-1a', 'ca-central-1b'], 'eu-west-1': ['eu-west-1a', 'eu-west-1b', 'eu-west-1c'], 'eu-west-2': ['eu-west-2a', 'eu-west-2b'], 'eu-central-1': ['eu-central-1a', 'eu-central-1b', 'eu-central-1c'], 'ap-south-1': ['ap-south-1a', 'ap-south-1b'], 'sa-east-1': ['sa-east-1a', 'sa-east-1c'], 'ap-northeast-1': ['ap-northeast-1a', 'ap-northeast-1c', ['ap-northeast-1a', 'ap-northeast-1c']], 'ap-southeast-1': ['ap-southeast-1a', 'ap-southeast-1b'], 'ap-southeast-2': ['ap-southeast-2a', 'ap-southeast-2b', 'ap-southeast-2c'], 'ap-northeast-2': ['ap-northeast-2a', 'ap-northeast-2c']}`)
- `availability_zone_id` - (Optional) The AZ ID of the subnet. (`default = null`)
- `private_subnet_ipv6_cidrs` - (Optional) The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length. (`default = null`)
- `private_subnets_name` - Name for private subnets (`default = ""`)
- `assign_ipv6_address_on_creation` - (Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false (`default = ""`)
- `public_subnet_cidrs` - CIDR for the Public Subnet (`default = ""`)
- `map_public_ip_on_launch` - should be false if you do not want to auto-assign public IP on launch (`default = True`)
- `public_subnet_ipv6_cidrs` - (Optional) The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length. (`default = null`)
- `public_subnets_name` - Name for private subnets (`default = ""`)
- `subnet_timeouts_create` - (Default 10m) How long to wait for a subnet to be created. (`default = 10m`)
- `subnet_timeouts_delete` - (Default 20m) How long to retry on DependencyViolation errors during subnet deletion from lingering ENIs left by certain AWS services such as Elastic Load Balancing. NOTE: Lambda ENIs can take up to 45 minutes to delete, which is not affected by changing this customizable timeout (in version 2.31.0 and later of the Terraform AWS Provider) unless it is increased above 45 minutes. (`default = 20m`)
- `enable_vpn_gateway` - Should be true if you want to create a new VPN Gateway resource and attach it to the VPC (`default = ""`)
- `vpn_gw_availability_zone` - (Optional) The Availability Zone for the virtual private gateway. (`default = null`)
- `vpn_gw_amazon_side_asn` - (Optional) The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN. (`default = null`)
- `vpn_gw_name` - Set name for VPC GW (`default = ""`)
- `vpn_gw_attachment_vpn_gateway_id` - The ID of the Virtual Private Gateway. (`default = ""`)
- `vpn_gw_route_propagation_route_table_id` - The id of the aws_route_table to propagate routes into. (`default = ""`)
- `vpn_connection_customer_gateway_id` - The ID of the customer gateway. (`default = ""`)
- `vpn_connection_name` - Set name for VPC vpn connection (`default = ""`)
- `vpn_connection_type` - (Required) The type of VPN connection. The only type AWS supports at this time is 'ipsec.1'. (`default = ipsec.1`)
- `vpn_connection_transit_gateway_id` - (Optional) The ID of the EC2 Transit Gateway. (`default = null`)
- `vpn_connection_vpn_gateway_id` - (Optional) The ID of the Virtual Private Gateway. (`default = null`)
- `vpn_connection_static_routes_only` - (Optional, Default false) Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP. (`default = ""`)
- `vpn_connection_tunnel1_inside_cidr` - (Optional) The CIDR block of the inside IP addresses for the first VPN tunnel. (`default = null`)
- `vpn_connection_tunnel2_inside_cidr` - (Optional) The CIDR block of the inside IP addresses for the second VPN tunnel. (`default = null`)
- `vpn_connection_tunnel1_preshared_key` - (Optional) The preshared key of the first VPN tunnel. (`default = null`)
- `vpn_connection_tunnel2_preshared_key` - (Optional) The preshared key of the second VPN tunnel. (`default = null`)
- `vpn_connection_route_cidr_block` - (Required) The CIDR block associated with the local subnet of the customer network. (`default = null`)
- `vpn_connection_route_vpn_connection_id` - The ID of the VPN connection. (`default = ""`)
- `customer_gateway_bgp_asn` - (Required) The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). (`default = 65000`)
- `customer_gateway_name` - Set name for VPC customer gateway (`default = ""`)
- `customer_gateway_ip_address` - (Required) The IP address of the gateway's Internet-routable external interface. (`default = ""`)
- `customer_gateway_type` - (Required) The type of customer gateway. The only type AWS supports at this time is 'ipsec.1'. (`default = ipsec.1`)
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
- `nat_eip_instance` - (Optional) EC2 instance ID. (`default = null`)
- `nat_eip_network_interface` - (Optional) Network interface ID to associate with. (`default = null`)
- `nat_eip_associate_with_private_ip` - (Optional) A user specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address. (`default = null`)
- `nat_eip_public_ipv4_pool` - (Optional) EC2 IPv4 address pool identifier or amazon. This option is only available for VPC EIPs. (`default = null`)
- `nat_eip_name` - Set name for NAT EIP (`default = ""`)
- `private_custom_peering_destination_cidr_block` - Set CIDR block for private custom routing (`default = null`)
- `private_custom_gateway_id` - Set gateway ID for private custom routing (`default = null`)
- `public_custom_peering_destination_cidr_block` - Set CIDR block for public custom routing (`default = null`)
- `public_custom_gateway_id` - Set gateway ID for public custom routing (`default = null`)
- `timeouts_create` - (Default 2 minutes) Used for route creation (`default = 2m`)
- `timeouts_delete` - (Default 5 minutes) Used for route deletion (`default = 5m`)
- `private_propagating_vgws` - A list of VGWs the private route table should propagate. (`default = ""`)
- `private_route_tables_name` - Set name for private route tables (`default = ""`)
- `public_propagating_vgws` - A list of VGWs the public route table should propagate. (`default = ""`)
- `public_route_tables_name` - Set name for public route tables (`default = ""`)
- `enable_flow_log` - Enable VPC flow log usage (`default = ""`)
- `flow_log_name` - Set name for VPC flow log (`default = ""`)
- `flow_log_traffic_type` - (Required) The type of traffic to capture. Valid values: ACCEPT,REJECT, ALL. (`default = ALL`)
- `flow_log_eni_id` - (Optional) Elastic Network Interface ID to attach to (`default = null`)
- `flow_log_iam_role_arn` - (Optional) The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group (`default = null`)
- `flow_log_log_destination_type` - (Optional) The type of the logging destination. Valid values: cloud-watch-logs, s3. Default: cloud-watch-logs (`default = cloud-watch-logs`)
- `flow_log_log_destination` - (Optional) The ARN of the logging destination. (`default = null`)
- `flow_log_subnet_id` - (Optional) Subnet ID to attach to (`default = null`)
- `flow_log_log_format` - (Optional) The fields to include in the flow log record, in the order in which they should appear. (`default = null`)
- `flow_log_max_aggregation_interval` - (Optional) The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: 60 seconds (1 minute) or 600 seconds (10 minutes). Default: 600. (`default = 600`)
- `enable_network_acl` - Enable network acl for VPC usage (`default = ""`)
- `network_acl_subnet_ids` - (Optional) A list of Subnet IDs to apply the ACL to (`default = null`)
- `network_acl_name` - Set name for VPC network acl (`default = ""`)
- `network_acl_ingress` - (Optional) Specifies an ingress rule. Parameters defined below. This argument is processed in attribute-as-blocks mode. (`default = ""`)
- `network_acl_egress` - (Optional) Specifies an egress rule. Parameters defined below. This argument is processed in attribute-as-blocks mode. (`default = ""`)
- `enable_network_acl_rule` - Enable VPC network acl rule usage (`default = ""`)
- `network_acl_rule_network_acl_id` - The ID of the network ACL. (`default = ""`)
- `network_acl_rule_rule_number` - (Required) The rule number for the entry (for example, 100). ACL entries are processed in ascending order by rule number. (`default = 100`)
- `network_acl_rule_protocol` - (Required) The protocol. A value of -1 means all protocols. (`default = all`)
- `network_acl_rule_rule_action` - (Required) Indicates whether to allow or deny the traffic that matches the rule. Accepted values: allow | deny (`default = allow`)
- `network_acl_rule_egress` - (Optional, bool) Indicates whether this is an egress rule (rule is applied to traffic leaving the subnet). Default false. (`default = ""`)
- `network_acl_rule_cidr_block` - (Optional) The network range to allow or deny, in CIDR notation (for example 172.16.0.0/24 ). (`default = null`)
- `network_acl_rule_ipv6_cidr_block` - (Optional) The IPv6 CIDR block to allow or deny. (`default = null`)
- `network_acl_rule_from_port` - (Optional) The from port to match. (`default = null`)
- `network_acl_rule_to_port` - (Optional) The to port to match. (`default = null`)
- `network_acl_rule_icmp_type` - (Optional) ICMP protocol: The ICMP type. Required if specifying ICMP for the protocol. e.g. -1 (`default = null`)
- `network_acl_rule_icmp_code` - (Optional) ICMP protocol: The ICMP code. Required if specifying ICMP for the protocol. e.g. -1 (`default = null`)
- `enable_vpc_ipv4_cidr_block_association` - Enable VPC IPv4 cidr block association usage. (`default = ""`)
- `vpc_ipv4_cidr_block_association_cidr_block` - (Required) The additional IPv4 CIDR block to associate with the VPC. (`default = ""`)
- `vpc_ipv4_cidr_block_association_timeouts_create` - (Default 10 minutes) Used for creating the association (`default = 10m`)
- `vpc_ipv4_cidr_block_association_timeouts_delete` - (Default 10 minutes) Used for destroying the association (`default = 10m`)
- `enable_egress_only_internet_gateway` - Enable VPC egress only internet gateway usage. Creates an egress-only Internet gateway for your VPC. An egress-only Internet gateway is used to enable outbound communication over IPv6 from instances in your VPC to the Internet, and prevents hosts outside of your VPC from initiating an IPv6 connection with your instance. (`default = ""`)
- `enable_main_route_table_association` - Enable VPC main route table association usage. (`default = ""`)
- `main_route_table_association_route_table_id` - (Required) The ID of the Route Table to set as the new main route table for the target VPC (`default = ""`)
- `enable_vpc_peering` - Enable VPC peering usage (`default = ""`)
- `vpc_peering_connection_name` - Set name for VPC peering connection (`default = ""`)
- `peering_destination_cidr_block` - Set CIDR block for peering (`default = null`)
- `peering_gateway_id` - Set Gateway ID of VPC peering (`default = null`)
- `vpc_peering_connection_peer_vpc_id` - (Required) The ID of the VPC with which you are creating the VPC Peering Connection. (`default = null`)
- `vpc_peering_connection_peer_owner_id` - (Optional) The AWS account ID of the owner of the peer VPC. Defaults to the account ID the AWS provider is currently connected to. (`default = null`)
- `vpc_peering_connection_auto_accept` - (Optional) Accept the peering (both VPCs need to be in the same AWS account). (`default = null`)
- `vpc_peering_connection_peer_region` - (Optional) The region of the accepter VPC of the [VPC Peering Connection]. auto_accept must be false, and use the aws_vpc_peering_connection_accepter to manage the accepter side. (`default = null`)
- `accepter_allow_remote_vpc_dns_resolution` - (Optional) Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. This is not supported for inter-region VPC peering. (`default = True`)
- `accepter_allow_classic_link_to_remote_vpc` - (Optional) Allow a local linked EC2-Classic instance to communicate with instances in a peer VPC. This enables an outbound communication from the local ClassicLink connection to the remote VPC. (`default = null`)
- `accepter_allow_vpc_to_remote_classic_link` - (Optional) Allow a local VPC to communicate with a linked EC2-Classic instance in a peer VPC. This enables an outbound communication from the local VPC to the remote ClassicLink connection. (`default = null`)
- `requester_allow_remote_vpc_dns_resolution` - (Optional) Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. This is not supported for inter-region VPC peering. (`default = True`)
- `requester_allow_classic_link_to_remote_vpc` - (Optional) Allow a local linked EC2-Classic instance to communicate with instances in a peer VPC. This enables an outbound communication from the local ClassicLink connection to the remote VPC. (`default = null`)
- `requester_allow_vpc_to_remote_classic_link` - (Optional) Allow a local VPC to communicate with a linked EC2-Classic instance in a peer VPC. This enables an outbound communication from the local VPC to the remote ClassicLink connection. (`default = null`)
- `vpc_peering_connection_timeouts_create` - (Default 1 minute) Used for creating a peering connection (`default = 1m`)
- `vpc_peering_connection_timeouts_update` - (Default 1 minute) Used for peering connection modifications (`default = 1m`)
- `vpc_peering_connection_timeouts_delete` - (Default 1 minute) Used for destroying peering connections (`default = 1m`)
- `enable_vpc_peering_connection_options` - Enable VPC peering connection options usage (`default = ""`)
- `vpc_peering_connection_id` - The ID of the requester VPC peering connection. (`default = ""`)
- `accepter_options_allow_remote_vpc_dns_resolution` - (Optional) Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. (`default = True`)
- `accepter_options_allow_classic_link_to_remote_vpc` - (Optional) Allow a local linked EC2-Classic instance to communicate with instances in a peer VPC. This enables an outbound communication from the local ClassicLink connection to the remote VPC. This option is not supported for inter-region VPC peering. (`default = null`)
- `accepter_options_allow_vpc_to_remote_classic_link` - (Optional) Allow a local VPC to communicate with a linked EC2-Classic instance in a peer VPC. This enables an outbound communication from the local VPC to the remote ClassicLink connection. This option is not supported for inter-region VPC peering. (`default = null`)
- `requester_options_allow_remote_vpc_dns_resolution` - (Optional) Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. (`default = True`)
- `requester_options_allow_classic_link_to_remote_vpc` - (Optional) Allow a local linked EC2-Classic instance to communicate with instances in a peer VPC. This enables an outbound communication from the local ClassicLink connection to the remote VPC. This option is not supported for inter-region VPC peering. (`default = null`)
- `requester_options_allow_vpc_to_remote_classic_link` - (Optional) Allow a local VPC to communicate with a linked EC2-Classic instance in a peer VPC. This enables an outbound communication from the local VPC to the remote ClassicLink connection. This option is not supported for inter-region VPC peering. (`default = null`)
- `vpc_peering_connection_accepter_name` - Set name for VPC peering connection accepter (`default = ""`)
- `vpc_peering_connection_accepter_auto_accept` - (Optional) Whether or not to accept the peering request. Defaults to false. (`default = ""`)
- `enable_vpc_endpoint` - description (`default = ""`)
- `vpc_endpoint_name` - Set name for VPC endpoint (`default = ""`)
- `vpc_endpoint_service_name` - (Required) The service name. For AWS services the service name is usually in the form com.amazonaws.<region>.<service> (the SageMaker Notebook service is an exception to this rule, the service name is in the form aws.sagemaker.<region>.notebook). (`default = null`)
- `vpc_endpoint_auto_accept` - (Optional) Accept the VPC endpoint (the VPC endpoint and service need to be in the same AWS account). (`default = null`)
- `vpc_endpoint_policy` - (Optional) A policy to attach to the endpoint that controls access to the service. Defaults to full access. All Gateway and some Interface endpoints support policies - see the relevant AWS documentation for more details. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. (`default = null`)
- `vpc_endpoint_private_dns_enabled` - (Optional; AWS services and AWS Marketplace partner services only) Whether or not to associate a private hosted zone with the specified VPC. Applicable for endpoints of type Interface. Defaults to false. (`default = ""`)
- `vpc_endpoint_route_table_ids` - (Optional) One or more route table IDs. Applicable for endpoints of type Gateway. (`default = null`)
- `vpc_endpoint_subnet_ids` - (Optional) The ID of one or more subnets in which to create a network interface for the endpoint. Applicable for endpoints of type Interface. (`default = null`)
- `vpc_endpoint_security_group_ids` - (Optional) The ID of one or more security groups to associate with the network interface. Required for endpoints of type Interface. (`default = null`)
- `vpc_endpoint_vpc_endpoint_type` - (Optional) The VPC endpoint type, Gateway or Interface. Defaults to Gateway. (`default = Gateway`)
- `vpc_endpoint_timeouts_create` - (Default 10 minutes) Used for creating a VPC endpoint (`default = 10m`)
- `vpc_endpoint_timeouts_update` - (Default 10 minutes) Used for VPC endpoint modifications (`default = 10m`)
- `vpc_endpoint_timeouts_delete` - (Default 10 minutes) Used for destroying VPC endpoints (`default = 10m`)
- `vpc_endpoint_subnet_association_subnet_id` - The ID of the subnet to be associated with the VPC endpoint. (`default = ""`)
- `vpc_endpoint_id` - The ID of the VPC endpoint with which the subnet will be associated. (`default = ""`)
- `vpc_endpoint_subnet_association_timeouts_create` - (Default 10 minutes) Used for creating the association (`default = 10m`)
- `vpc_endpoint_subnet_association_timeouts_delete` - (Default 10 minutes) Used for destroying the association (`default = 10m`)
- `vpc_endpoint_route_table_association_route_table_id` - Identifier of the EC2 Route Table to be associated with the VPC Endpoint. (`default = ""`)
- `vpc_endpoint_service_acceptance_required` - (Required) Whether or not VPC endpoint connection requests to the service must be accepted by the service owner - true or false. (`default = ""`)
- `vpc_endpoint_service_network_load_balancer_arns` - (Required) The ARNs of one or more Network Load Balancers for the endpoint service. (`default = ""`)
- `vpc_endpoint_service_allowed_principals` - (Optional) The ARNs of one or more principals allowed to discover the endpoint service. (`default = null`)
- `vpc_endpoint_service_allowed_principal_principal_arn` - (Required) The ARN of the principal to allow permissions. (`default = ""`)
- `vpc_endpoint_service_id` - The ID of the VPC endpoint service to allow permission. (`default = ""`)
- `vpc_endpoint_connection_notification_connection_notification_arn` - (Required) The ARN of the SNS topic for the notifications. (`default = ""`)
- `vpc_endpoint_connection_notification_connection_events` - (Required) One or more endpoint events for which to receive notifications. (`default = ['Accept', 'Reject']`)

## Module Output Variables
----------------------


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
