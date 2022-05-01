#---------------------------------------------------------------
# Global or/and default variables
#---------------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "azs" {
  description = "A list of Availability zones in the region"
  default     = []
}

variable "availability_zones" {
  description = "A list of Availability zones in the region"
  default = {
    us-east-1      = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
    us-east-2      = ["us-east-2a", "eu-east-2b", "eu-east-2c"]
    us-west-1      = ["us-west-1a", "us-west-1c"]
    us-west-2      = ["us-west-2a", "us-west-2b", "us-west-2c"]
    ca-central-1   = ["ca-central-1a", "ca-central-1b"]
    eu-west-1      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
    eu-west-2      = ["eu-west-2a", "eu-west-2b"]
    eu-central-1   = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
    ap-south-1     = ["ap-south-1a", "ap-south-1b"]
    sa-east-1      = ["sa-east-1a", "sa-east-1c"]
    ap-northeast-1 = ["ap-northeast-1a", "ap-northeast-1c"]
    ap-southeast-1 = ["ap-southeast-1a", "ap-southeast-1b"]
    ap-southeast-2 = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
    ap-northeast-1 = ["ap-northeast-1a", "ap-northeast-1c"]
    ap-northeast-2 = ["ap-northeast-2a", "ap-northeast-2c"]
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR for the Public Subnet"
  default     = []
}

variable "private_subnet_cidrs" {
  description = "CIDR for the Private Subnet"
  default     = []
}

variable "k8s_private_subnets_name" {
  description = "Set name for private subnets of K8S"
  default     = ""
}

variable "k8s_private_subnet_cidrs" {
  description = "CIDR for the Private Subnet for K8S"
  default     = []
}

variable "k8s_public_subnets_name" {
  description = "Set name for private subnets of K8S"
  default     = ""
}

variable "k8s_public_subnet_cidrs" {
  description = "CIDR for the Public Subnet for K8S"
  default     = []
}

variable "k8s_tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------------------
# AWS VPC
#---------------------------------------------------------------
variable "enable_vpc" {
  description = "Enable VPC usage"
  default     = false
}

variable "vpc_name" {
  description = "name for VPC"
  default     = ""
}

variable "vpc_cidr_block" {
  description = "(Required) The CIDR block for the VPC."
  default     = ""
}

variable "vpc_instance_tenancy" {
  description = "(Optional) A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "vpc_enable_dns_support" {
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  default     = true
}

variable "vpc_enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  default     = false
}

variable "vpc_enable_classiclink" {
  description = "(Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false. Dedicated tenancy VPCs cannot be enabled for ClassicLink by default"
  default     = false
}

variable "vpc_enable_classiclink_dns_support" {
  description = "(Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  default     = true
}

variable "vpc_assign_generated_ipv6_cidr_block" {
  description = "(Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false."
  default     = false
}

#---------------------------------------------------------------
# AWS subnets
#---------------------------------------------------------------
variable "vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "availability_zone_id" {
  description = "(Optional) The AZ ID of the subnet."
  default     = null
}

variable "private_subnet_ipv6_cidrs" {
  description = "(Optional) The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length."
  default     = null
}

variable "private_subnets_name" {
  description = "Name for private subnets"
  default     = ""
}

variable "assign_ipv6_address_on_creation" {
  description = "(Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false"
  default     = false
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "public_subnet_ipv6_cidrs" {
  description = "(Optional) The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length."
  default     = null
}

variable "public_subnets_name" {
  description = "Name for private subnets"
  default     = ""
}

variable "subnet_timeouts" {
  description = "Set to how long to wait for a subnet to be created or deleted."
  default     = {}
}

#---------------------------------------------------------------
# AWS VPN gateway
#---------------------------------------------------------------
variable "enable_vpn_gateway" {
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
  default     = false
}

variable "vpn_gateway_name" {
  description = "Set name for VPC GW"
  default     = ""
}

variable "vpn_gateway_vpc_id" {
  description = "(Optional) The VPC ID to create in."
  default     = ""
}

variable "vpn_gateway_availability_zone" {
  description = "(Optional) The Availability Zone for the virtual private gateway."
  default     = null
}

variable "vpn_gateway_amazon_side_asn" {
  description = "(Optional) The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN."
  default     = null
}

#---------------------------------------------------------------
# AWS VPN gateway attachment
#---------------------------------------------------------------
variable "enable_vpn_gateway_attachment" {
  description = "Enable vpn gateway attachment usage"
  default     = false
}

variable "vpn_gateway_attachment_vpn_gateway_id" {
  description = "The ID of the Virtual Private Gateway."
  default     = ""
}

variable "vpn_gateway_attachment_vpc_id" {
  description = "Set vpc_id for vpn gateway attachment"
  default     = ""
}

#---------------------------------------------------------------
# AWS VPN gateway route propagation
#---------------------------------------------------------------
variable "enable_vpn_gateway_route_propagation" {
  description = "Enable vpn gateway route propagation usage"
  default     = false
}

variable "vpn_gateway_route_propagation_vpn_gateway_id" {
  description = "The id of the aws_vpn_gateway to propagate routes from."
  default     = ""
}

variable "vpn_gateway_route_propagation_route_table_id" {
  description = "The id of the aws_route_table to propagate routes into."
  default     = ""
}

#---------------------------------------------------
# AWS VPN connection
#---------------------------------------------------
variable "enable_vpn_connection" {
  description = "Enable vpn connection usage"
  default     = false
}

variable "vpn_connection_name" {
  description = "Set name for VPC vpn connection"
  default     = ""
}

variable "vpn_connection_customer_gateway_id" {
  description = "The ID of the customer gateway."
  default     = ""
}

variable "vpn_connection_type" {
  description = "(Required) The type of VPN connection. The only type AWS supports at this time is 'ipsec.1'."
  default     = "ipsec.1"
}

variable "vpn_connection_transit_gateway_id" {
  description = "(Optional) The ID of the EC2 Transit Gateway."
  default     = null
}

variable "vpn_connection_vpn_gateway_id" {
  description = "(Optional) The ID of the Virtual Private Gateway."
  default     = null
}

variable "vpn_connection_static_routes_only" {
  description = "(Optional, Default false) Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP."
  default     = false
}

variable "vpn_connection_tunnel1_inside_cidr" {
  description = "(Optional) The CIDR block of the inside IP addresses for the first VPN tunnel."
  default     = null
}

variable "vpn_connection_tunnel2_inside_cidr" {
  description = "(Optional) The CIDR block of the inside IP addresses for the second VPN tunnel."
  default     = null
}

variable "vpn_connection_tunnel1_preshared_key" {
  description = "(Optional) The preshared key of the first VPN tunnel."
  default     = null
}

variable "vpn_connection_tunnel2_preshared_key" {
  description = "(Optional) The preshared key of the second VPN tunnel."
  default     = null
}

#---------------------------------------------------
# AWS VPN connection route
#---------------------------------------------------
variable "enable_vpn_connection_route" {
  description = "Enable vpn connection route usage"
  default     = false
}

variable "vpn_connection_route_cidr_block" {
  description = "(Required) The CIDR block associated with the local subnet of the customer network."
  default     = null
}

variable "vpn_connection_route_vpn_connection_id" {
  description = "The ID of the VPN connection."
  default     = ""
}

#---------------------------------------------------------------
# AWS customer gateway
#---------------------------------------------------------------
variable "enable_customer_gateway" {
  description = "Enable customer gateway usage"
  default     = false
}

variable "customer_gateway_name" {
  description = "Set name for VPC customer gateway"
  default     = ""
}

variable "customer_gateway_bgp_asn" {
  description = "(Required) The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
  default     = 65000
}

variable "customer_gateway_ip_address" {
  description = "(Required) The IP address of the gateway's Internet-routable external interface."
  default     = ""
}

variable "customer_gateway_type" {
  description = "(Required) The type of customer gateway. The only type AWS supports at this time is 'ipsec.1'."
  default     = "ipsec.1"
}

#---------------------------------------------------------------
# Create DHCP
#---------------------------------------------------------------
variable "enable_dhcp" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  default     = false
}

variable "vpc_dhcp_name" {
  description = "Set name for VPC DHCP"
  default     = ""
}

variable "vpc_dhcp_options_domain_name" {
  description = "(Optional) the suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the search value in the /etc/resolv.conf file."
  default     = ""
}

variable "vpc_dhcp_options_domain_name_servers" {
  description = "(Optional) List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to AmazonProvidedDNS."
  default     = ["AmazonProvidedDNS"]
}

variable "vpc_dhcp_options_ntp_servers" {
  description = "(Optional) List of NTP servers to configure."
  default     = []
}

variable "vpc_dhcp_options_netbios_name_servers" {
  description = "(Optional) List of NETBIOS name servers."
  default     = []
}

variable "vpc_dhcp_options_netbios_node_type" {
  description = "(Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. For more information about these node types, see RFC 2132."
  default     = ""
}

#---------------------------------------------------------------
# DHCP Options Set Association
#---------------------------------------------------------------
variable "vpc_dhcp_options_association_dhcp_options_id" {
  description = "The ID of the DHCP Options Set to associate to the VPC."
  default     = ""
}

variable "vpc_dhcp_options_association_vpc_id" {
  description = "Set VPC_ID for dhcp options association"
  default     = ""
}

#---------------------------------------------------------------
# Add AWS internet gateway
#---------------------------------------------------------------
variable "enable_internet_gateway" {
  description = "Allow Internet GateWay to/from public network"
  default     = false
}

variable "internet_gateway_vpc_id" {
  description = "The VPC ID to create in."
  default     = ""
}

variable "internet_gateway_name" {
  description = "Name for internet gw"
  default     = ""
}

#---------------------------------------------------
# AWS NAT
#---------------------------------------------------
variable "enable_nat_gateway" {
  description = "Allow Nat GateWay to/from private network"
  default     = false
}

variable "single_nat_gateway" {
  description = "should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = false
}

variable "nat_gateway_name" {
  description = "Set name for NAT GW"
  default     = ""
}

variable "nat_gateway_connectivity_type" {
  description = "(Optional) Connectivity type for the gateway. Valid values are private and public. Defaults to public"
  default     = "public"
}

#---------------------------------------------------------------
# AWS EIP
#---------------------------------------------------------------
variable "enable_eip" {
  description = "Allow creation elastic eip"
  default     = false
}

variable "nat_eip_vpc" {
  description = "(Optional) Boolean if the EIP is in a VPC or not."
  default     = true
}

variable "nat_eip_instance" {
  description = "(Optional) EC2 instance ID."
  default     = null
}

variable "nat_eip_network_interface" {
  description = "(Optional) Network interface ID to associate with."
  default     = null
}

variable "nat_eip_associate_with_private_ip" {
  description = "(Optional) A user specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address."
  default     = null
}

variable "nat_eip_public_ipv4_pool" {
  description = "(Optional) EC2 IPv4 address pool identifier or amazon. This option is only available for VPC EIPs."
  default     = null
}

variable "nat_eip_name" {
  description = "Set name for NAT EIP"
  default     = ""
}

#---------------------------------------------------------------
# AWS route
#---------------------------------------------------------------
variable "peering_destination_cidr_block" {
  description = "Set CIDR block for peering routing"
  default     = null
}

variable "peering_gateway_id" {
  description = "Set gateway_id for peering"
  default     = null
}

variable "private_custom_peering_destination_cidr_block" {
  description = "Set CIDR block for private custom routing"
  default     = null
}

variable "private_custom_gateway_id" {
  description = "Set gateway ID for private custom routing"
  default     = null
}

variable "public_custom_peering_destination_cidr_block" {
  description = "Set CIDR block for public custom routing"
  default     = null
}

variable "public_custom_gateway_id" {
  description = "Set gateway ID for public custom routing"
  default     = null
}

variable "route_timeouts" {
  description = "Set timeouts for route"
  default     = {}
}

variable "enable_custom_route" {
  description = "Enable custom route"
  default     = false
}

variable "custom_route_route_table_id" {
  description = "(Required) The ID of the routing table."
  default     = null
}

variable "custom_route_destination_cidr_block" {
  description = "(Optional) The destination CIDR block."
  default     = null
}

variable "custom_route_destination_ipv6_cidr_block" {
  description = "(Optional) The destination IPv6 CIDR block."
  default     = null
}

variable "custom_route_vpc_peering_connection_id" {
  description = "(Optional) Identifier of a VPC peering connection."
  default     = null
}

variable "custom_route_egress_only_gateway_id" {
  description = "(Optional) Identifier of a VPC Egress Only Internet Gateway."
  default     = null
}

variable "custom_route_gateway_id" {
  description = "(Optional) Identifier of a VPC internet gateway or a virtual private gateway."
  default     = null
}

variable "custom_route_nat_gateway_id" {
  description = "(Optional) Identifier of a VPC NAT gateway."
  default     = null
}

variable "custom_route_local_gateway_id" {
  description = "(Optional) Identifier of a Outpost local gateway."
  default     = null
}

variable "custom_route_network_interface_id" {
  description = "(Optional) Identifier of an EC2 network interface."
  default     = null
}

variable "custom_route_transit_gateway_id" {
  description = "(Optional) Identifier of an EC2 Transit Gateway."
  default     = null
}

variable "custom_route_vpc_endpoint_id" {
  description = "(Optional) Identifier of a VPC Endpoint."
  default     = null
}

#---------------------------------------------------------------
# AWS route table
#---------------------------------------------------------------
# private route tables
variable "private_route_tables_name" {
  description = "Set name for private route tables"
  default     = ""
}

variable "private_route_tables_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  default     = null
}

variable "private_route_tables_vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "private_route_tables_route_ipv4" {
  description = "The CIDR block of the route for IPv4."
  default     = []
}

variable "private_route_tables_route_ipv6" {
  description = "(Optional) The Ipv6 CIDR block of the route."
  default     = []
}

# public route tables
variable "public_route_tables_name" {
  description = "Set name for public route tables"
  default     = ""
}

variable "public_route_tables_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = null
}

variable "public_route_tables_vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "public_route_tables_route_ipv4" {
  description = "The CIDR block of the route for IPv4."
  default     = []
}

variable "public_route_tables_route_ipv6" {
  description = "(Optional) The Ipv6 CIDR block of the route."
  default     = []
}

# private route tables for k8s
variable "k8s_private_route_tables_name" {
  description = "Set name for private route tables"
  default     = ""
}

variable "k8s_private_route_tables_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  default     = null
}

variable "k8s_private_route_tables_vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "k8s_private_route_tables_route_ipv4" {
  description = "The CIDR block of the route for IPv4."
  default     = []
}

variable "k8s_private_route_tables_route_ipv6" {
  description = "(Optional) The Ipv6 CIDR block of the route."
  default     = []
}

# public route tables for k8s
variable "k8s_public_route_tables_name" {
  description = "Set name for public route tables"
  default     = ""
}

variable "k8s_public_route_tables_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = null
}

variable "k8s_public_route_tables_vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "k8s_public_route_tables_route_ipv4" {
  description = "The CIDR block of the route for IPv4."
  default     = []
}

variable "k8s_public_route_tables_route_ipv6" {
  description = "(Optional) The Ipv6 CIDR block of the route."
  default     = []
}

# custom route tables
variable "enable_custom_route_tables" {
  description = "Enable custom RT"
  default     = false
}

variable "custom_route_tables_name" {
  description = "Set name for custom RT"
  default     = ""
}

variable "custom_route_tables_vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "custom_route_tables_propagating_vgws" {
  description = "(Optional) A list of virtual gateways for propagation."
  default     = null
}

variable "custom_route_tables_route_ipv4" {
  description = "The CIDR block of the route for IPv4."
  default     = []
}

variable "custom_route_tables_route_ipv6" {
  description = "(Optional) The Ipv6 CIDR block of the route."
  default     = []
}

#---------------------------------------------------
# AWS Route Table Associations
#---------------------------------------------------
variable "enable_custom_route_table_associations" {
  description = "Enable custom route table associations usage"
  default     = false
}

variable "custom_route_table_associations_stack" {
  description = "Set route table associations"
  default     = []
}

#---------------------------------------------------
# AWS VPC flow log
#---------------------------------------------------
variable "enable_flow_log" {
  description = "Enable VPC flow log usage"
  default     = false
}

variable "flow_log_stack" {
  description = "Set settings for AWS VPC flow log. The all settings can be found: 'https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log'"
  default = [
    {
      traffic_type = "ALL"

      name                     = null
      eni_id                   = null
      iam_role_arn             = null
      log_destination_type     = null
      log_destination          = null
      subnet_id                = null
      vpc_id                   = null
      log_format               = null
      max_aggregation_interval = null
    }
  ]
}

#---------------------------------------------------
# AWS VPC network acl
#---------------------------------------------------
variable "enable_network_acl" {
  description = "Enable network acl for VPC usage"
  default     = false
}

variable "network_acl_name" {
  description = "Set name for VPC network acl"
  default     = ""
}

variable "network_acl_subnet_ids" {
  description = "(Optional) A list of Subnet IDs to apply the ACL to"
  default     = null
}

variable "network_acl_vpc_id" {
  description = "Set vpc_id for NACL"
  default     = ""
}

variable "network_acl_ingress" {
  description = "(Optional) Specifies an ingress rule. Parameters defined below. This argument is processed in attribute-as-blocks mode."
  default     = []
}

variable "network_acl_egress" {
  description = "(Optional) Specifies an egress rule. Parameters defined below. This argument is processed in attribute-as-blocks mode."
  default     = []
}

#---------------------------------------------------
# AWS VPC network acl rule
#---------------------------------------------------
variable "enable_network_acl_rule" {
  description = "Enable VPC network acl rule usage"
  default     = false
}

variable "network_acl_rule_stack" {
  description = "Set NACLs rules. The full documentation is 'https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule'."
  default = [
    {
      network_acl_id = null
      rule_number    = null
      protocol       = null
      rule_action    = null

      egress          = null
      cidr_block      = null
      ipv6_cidr_block = null
      from_port       = null
      to_port         = null
      icmp_type       = null
      icmp_code       = null
    }
  ]
}

#---------------------------------------------------
# AWS VPC ipv4 cidr block association
#---------------------------------------------------
variable "enable_vpc_ipv4_cidr_block_association" {
  description = "Enable VPC IPv4 cidr block association usage."
  default     = false
}

variable "vpc_ipv4_cidr_block_association_cidr_block" {
  description = "(Required) The additional IPv4 CIDR block to associate with the VPC."
  default     = ""
}

variable "vpc_ipv4_cidr_block_association_vpc_id" {
  description = "The ID of the VPC to make the association with."
  default     = ""
}

variable "vpc_ipv4_cidr_block_association_timeouts" {
  description = "Set timeouts used for creating the association"
  default     = {}
}

#---------------------------------------------------
# AWS egress only internet gateway
#---------------------------------------------------
variable "enable_egress_only_internet_gateway" {
  description = "Enable VPC egress only internet gateway usage. Creates an egress-only Internet gateway for your VPC. An egress-only Internet gateway is used to enable outbound communication over IPv6 from instances in your VPC to the Internet, and prevents hosts outside of your VPC from initiating an IPv6 connection with your instance."
  default     = false
}

variable "egress_only_internet_gateway_name" {
  description = "Set name for egress only internet gateway"
  default     = ""
}

variable "egress_only_internet_gateway_vpc_id" {
  description = "The VPC ID to create in."
  default     = ""
}

#---------------------------------------------------
# AWS VPC main route table association
#---------------------------------------------------
variable "enable_main_route_table_association" {
  description = "Enable VPC main route table association usage."
  default     = false
}

variable "main_route_table_association_vpc_id" {
  description = "The ID of the VPC whose main route table should be set"
  default     = ""
}

variable "main_route_table_association_route_table_id" {
  description = "(Required) The ID of the Route Table to set as the new main route table for the target VPC"
  default     = ""
}

#---------------------------------------------------
# AWS VPC peering connection
#---------------------------------------------------
variable "enable_vpc_peering_connection" {
  description = "Enable VPC peering usage"
  default     = false
}

variable "vpc_peering_connection_name" {
  description = "Set name for VPC peering connection"
  default     = ""
}

variable "vpc_peering_connection_vpc_id" {
  description = "Set vpc_id for peering connection"
  default     = ""
}

variable "vpc_peering_connection_peer_vpc_id" {
  description = "(Required) The ID of the VPC with which you are creating the VPC Peering Connection."
  default     = null
}

variable "vpc_peering_connection_peer_owner_id" {
  description = "(Optional) The AWS account ID of the owner of the peer VPC. Defaults to the account ID the AWS provider is currently connected to."
  default     = null
}

variable "vpc_peering_connection_auto_accept" {
  description = "(Optional) Accept the peering (both VPCs need to be in the same AWS account)."
  default     = null
}

variable "vpc_peering_connection_peer_region" {
  description = "(Optional) The region of the accepter VPC of the [VPC Peering Connection]. auto_accept must be false, and use the aws_vpc_peering_connection_accepter to manage the accepter side."
  default     = null
}

variable "vpc_peering_connection_accepter" {
  description = "(Optional) - An optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that accepts the peering connection (a maximum of one)."
  default     = []
}

variable "vpc_peering_connection_requester" {
  description = "(Optional) - A optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that requests the peering connection (a maximum of one)."
  default     = []
}

variable "vpc_peering_connection_timeouts" {
  description = "Set timeouts used for creating a peering connection"
  default     = {}
}

#---------------------------------------------------
# AWS VPC peering connection options
#---------------------------------------------------
variable "enable_vpc_peering_connection_options" {
  description = "Enable VPC peering connection options usage"
  default     = false
}

variable "vpc_peering_connection_options_vpc_peering_connection_id" {
  description = "The ID of the requester VPC peering connection."
  default     = ""
}

variable "vpc_peering_connection_options_accepter" {
  description = "(Optional) - An optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that accepts the peering connection (a maximum of one)."
  default     = []
}

variable "vpc_peering_connection_options_requester" {
  description = "(Optional) - A optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that requests the peering connection (a maximum of one)."
  default     = []
}

#---------------------------------------------------
# AWS VPC peering connection accepter
#---------------------------------------------------
variable "enable_vpc_peering_connection_accepter" {
  description = "Enable VPC endpoint usage"
  default     = false
}

variable "vpc_peering_connection_accepter_name" {
  description = "Set name for VPC peering connection accepter"
  default     = ""
}

variable "vpc_peering_connection_accepter_vpc_peering_connection_id" {
  description = "(Optional) Whether or not to accept the peering request. Defaults to false."
  default     = false
}

variable "vpc_peering_connection_accepter_auto_accept" {
  description = "(Optional) Whether or not to accept the peering request. Defaults to false."
  default     = false
}

#---------------------------------------------------
# AWS VPC endpoint
#---------------------------------------------------
variable "enable_vpc_endpoint" {
  description = "Enable VPC endpoint usage"
  default     = false
}

variable "vpc_endpoint_stack" {
  description = "Set list of endpoints settings"
  default     = []
}

variable "vpc_endpoint_subnet_ids" {
  description = "Set list of subnet_ids for vpc endpoint(s)"
  default     = []
}

variable "vpc_endpoint_timeouts" {
  description = "Set timeouts used for creating a VPC endpoint"
  default     = {}
}

#---------------------------------------------------
# AWS VPC endpoint subnet association
#---------------------------------------------------
variable "enable_vpc_endpoint_subnet_association" {
  description = "Enable VPC endpoint subnet association usage"
  default     = false
}

variable "vpc_endpoint_subnet_association_subnet_id" {
  description = "The ID of the subnet to be associated with the VPC endpoint."
  default     = ""
}

variable "vpc_endpoint_subnet_association_vpc_endpoint_id" {
  description = "The ID of the VPC endpoint with which the subnet will be associated."
  default     = ""
}

variable "vpc_endpoint_subnet_association_timeouts" {
  description = "Set timeouts used for creating the association"
  default     = {}
}

#---------------------------------------------------
# AWS VPC endpoint route table association
#---------------------------------------------------
variable "enable_vpc_endpoint_route_table_association" {
  description = "Enable vpc endpoint route table association usage"
  default     = false
}

variable "vpc_endpoint_route_table_association_route_table_id" {
  description = "Identifier of the EC2 Route Table to be associated with the VPC Endpoint."
  default     = ""
}

variable "vpc_endpoint_route_table_association_vpc_endpoint_id" {
  description = "Identifier of the VPC Endpoint with which the EC2 Route Table will be associated."
  default     = ""
}

#---------------------------------------------------
# AWS VPC endpoint service
#---------------------------------------------------
variable "enable_vpc_endpoint_service" {
  description = "Enable vpc endpoint service usage"
  default     = false
}

variable "vpc_endpoint_service_stack" {
  description = "Set list of endpoint services"
  default     = []
}

variable "vpc_endpoint_service_filter" {
  description = "Set service filter"
  default     = []
}

#---------------------------------------------------
# AWS VPC endpoint service allowed principal
#---------------------------------------------------
variable "enable_vpc_endpoint_service_allowed_principal" {
  description = "Enable vpc endpoint service allowed principal usage"
  default     = false
}

variable "vpc_endpoint_service_allowed_principal_principal_arn" {
  description = "(Required) The ARN of the principal to allow permissions."
  default     = ""
}

variable "vpc_endpoint_service_allowed_principal_vpc_endpoint_service_id" {
  description = "The ID of the VPC endpoint service to allow permission."
  default     = ""
}

#---------------------------------------------------
# AWS VPC endpoint connection notification
#---------------------------------------------------
variable "enable_vpc_endpoint_connection_notification" {
  description = "Enable vpc endpoint connection notification usage"
  default     = false
}

variable "vpc_endpoint_connection_notification_connection_notification_arn" {
  description = "(Required) The ARN of the SNS topic for the notifications."
  default     = ""
}

variable "vpc_endpoint_connection_notification_connection_events" {
  description = "(Required) One or more endpoint events for which to receive notifications."
  default     = ["Accept", "Reject"]
}

variable "vpc_endpoint_connection_notification_vpc_endpoint_service_id" {
  description = "(Optional) The ID of the VPC Endpoint Service to receive notifications for."
  default     = ""
}

variable "vpc_endpoint_connection_notification_vpc_endpoint_id" {
  description = "(Optional) The ID of the VPC Endpoint to receive notifications for."
  default     = ""
}