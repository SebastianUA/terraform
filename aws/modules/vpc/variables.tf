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

variable "tags" {
    description = "A list of tag blocks. Each element should have keys named key, value, etc."
    type        = map(string)
    default     = {}
}

#---------------------------------------------------------------
# AWS VPC
#---------------------------------------------------------------
variable "enable_vpc" {
    description   = "Enable VPC usage"
    default       = false
}

variable "vpc_name" {
  description   = "name for VPC"
  default       = ""
}

variable "vpc_cidr" {
    description = "(Required) The CIDR block for the VPC."
    default     = ""
}

variable "instance_tenancy" {
    description = "(Optional) A tenancy option for instances launched into the VPC"
    default     = "default"
}

variable "enable_dns_support" {
    description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true."
    default     = true
}

variable "enable_dns_hostnames" {
    description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
    default     = false
}

variable "enable_classiclink" {
    description = "(Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false. Dedicated tenancy VPCs cannot be enabled for ClassicLink by default"
    default     = false
}

variable "enable_classiclink_dns_support" {
  description   = "(Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  default       = true
}

variable "assign_generated_ipv6_cidr_block" {
    description = "(Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false."
    default     = false
}

#---------------------------------------------------------------
# AWS subnets
#---------------------------------------------------------------
variable "private_subnet_cidrs" {
    description = "CIDR for the Private Subnet"
    default     = []
}

variable "vpc_id" {
  description   = "The VPC ID."
  default       = ""
}

variable "azs" {
    description = "A list of Availability zones in the region"
    default     = []
}

variable "availability_zones" {
    description = "A list of Availability zones in the region"
    default     = {
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

variable "availability_zone_id" {
  description   = "(Optional) The AZ ID of the subnet."
  default       = null
}

variable "private_subnet_ipv6_cidrs" {
  description   = "(Optional) The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length."
  default       = null
}

variable "private_subnets_name" {
  description   = "Name for private subnets"
  default       = ""
}

variable "assign_ipv6_address_on_creation" {
  description   = "(Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false"
  default       = false
}

variable "public_subnet_cidrs" {
    description = "CIDR for the Public Subnet"
    default     = []
}

variable "map_public_ip_on_launch" {
    description = "should be false if you do not want to auto-assign public IP on launch"
    default     = true
}

variable "public_subnet_ipv6_cidrs" {
  description   = "(Optional) The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length."
  default       = null
}

variable "public_subnets_name" {
  description   = "Name for private subnets"
  default       = ""
}

variable "subnet_timeouts_create" {
  description   = "(Default 10m) How long to wait for a subnet to be created."
  default       = "10m"
}

variable "subnet_timeouts_delete" {
  description   = "(Default 20m) How long to retry on DependencyViolation errors during subnet deletion from lingering ENIs left by certain AWS services such as Elastic Load Balancing. NOTE: Lambda ENIs can take up to 45 minutes to delete, which is not affected by changing this customizable timeout (in version 2.31.0 and later of the Terraform AWS Provider) unless it is increased above 45 minutes."
  default       = "20m"
}

#---------------------------------------------------------------
# AWS VPN gateway
#---------------------------------------------------------------
variable "enable_vpn_gateway" {
    description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
    default     = false
}

#variable "vpn_gw_vpc_id" {
#  description   = "The VPC ID to create in."
#  default       = ""
#}

variable "vpn_gw_availability_zone" {
  description   = "(Optional) The Availability Zone for the virtual private gateway."
  default       = null
}

variable "vpn_gw_amazon_side_asn" {
  description   = "(Optional) The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN."
  default       = null
}

variable "vpn_gw_name" {
  description   = "Set name for VPC GW"
  default       = ""
}

#---------------------------------------------------------------
# AWS VPN gateway attachment
#---------------------------------------------------------------
variable "vpn_gw_attachment_vpn_gateway_id" {
  description   = "The ID of the Virtual Private Gateway."
  default       = ""
}

#---------------------------------------------------------------
# AWS VPN gateway route propagation
#---------------------------------------------------------------
variable "vpn_gateway_route_propagation_route_table_id" {
  description   = "The id of the aws_route_table to propagate routes into."
  default       = ""
}

#---------------------------------------------------------------
# Create DHCP
#---------------------------------------------------------------
variable "enable_dhcp" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  default     = false
}

variable "vpc_dhcp_name" {
  description   = "Set name for VPC DHCP"
  default       = ""
}

variable "dhcp_options_domain_name" {
  description = "(Optional) the suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the search value in the /etc/resolv.conf file."
  default     = ""
}

variable "dhcp_options_domain_name_servers" {
  description = "(Optional) List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to AmazonProvidedDNS."
  default     = ["AmazonProvidedDNS"]
}

variable "dhcp_options_ntp_servers" {
  description = "(Optional) List of NTP servers to configure."
  default     = []
}

variable "dhcp_options_netbios_name_servers" {
  description = "(Optional) List of NETBIOS name servers."
  default     = []
}

variable "dhcp_options_netbios_node_type" {
  description = "(Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. For more information about these node types, see RFC 2132."
  default     = ""
}

#---------------------------------------------------------------
# DHCP Options Set Association
#---------------------------------------------------------------
variable "dhcp_options_id" {
  description   = "The ID of the DHCP Options Set to associate to the VPC."
  default       = ""
}

#---------------------------------------------------------------
# Add AWS internet gateway
#---------------------------------------------------------------
variable "enable_internet_gateway" {
    description = "Allow Internet GateWay to/from public network"
    default     = false
}

#variable "internet_gw_vpc_id" {
#  description   = "The VPC ID to create in."
#  default       = ""
#}

variable "internet_gw_name" {
  description   = "Name for internet gw"
  default       = ""
}

#---------------------------------------------------
# Create NAT
#---------------------------------------------------
variable "enable_nat_gateway" {
    description = "Allow Nat GateWay to/from private network"
    default     = false
}

variable "single_nat_gateway" {
    description = "should be true if you want to provision a single shared NAT Gateway across all of your private networks"
    default     = false
}

#---------------------------------------------------------------
# AWS EIP
#---------------------------------------------------------------
variable "enable_eip" {
    description = "Allow creation elastic eip"
    default     = false
}

variable "nat_eip_vpc" {
  description   = "(Optional) Boolean if the EIP is in a VPC or not."
  default       = true
}

variable "nat_eip_instance" {
  description   = "(Optional) EC2 instance ID."
  default       = null
}

variable "nat_eip_network_interface" {
  description   = "(Optional) Network interface ID to associate with."
  default       = null
}

variable "nat_eip_associate_with_private_ip" {
  description   = "(Optional) A user specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address."
  default       = null
}

variable "nat_eip_public_ipv4_pool" {
  description   = "(Optional) EC2 IPv4 address pool identifier or amazon. This option is only available for VPC EIPs."
  default       = null
}

variable "nat_eip_name" {
  description   = "Set name for NAT EIP"
  default       = ""
}

#---------------------------------------------------------------
# AWS route
#---------------------------------------------------------------
variable "timeouts_create" {
  description   = "(Default 2 minutes) Used for route creation"
  default       = "2m"
}

variable "timeouts_delete" {
  description   = "(Default 5 minutes) Used for route deletion"
  default       = "5m"
}

#---------------------------------------------------------------
# AWS route table
#---------------------------------------------------------------
variable "private_propagating_vgws" {
    description = "A list of VGWs the private route table should propagate."
    default     = []
}

variable "private_route_tables_name" {
  description   = "Set name for private route tables"
  default       = ""
}

variable "public_propagating_vgws" {
    description = "A list of VGWs the public route table should propagate."
    default     = []
}

variable "public_route_tables_name" {
  description   = "Set name for public route tables"
  default       = ""
}

#---------------------------------------------------
# AWS VPC flow log
#---------------------------------------------------
variable "enable_flow_log" {
  description = "Enable VPC flow log usage"
  default     = false
}

variable "flow_log_name" {
  description = "Set name for VPC flow log"
  default     = ""
}

variable "flow_log_traffic_type" {
  description = "(Required) The type of traffic to capture. Valid values: ACCEPT,REJECT, ALL."
  default     = "ALL"
}

variable "flow_log_eni_id" {
  description = "(Optional) Elastic Network Interface ID to attach to"
  default     = null
}

variable "flow_log_iam_role_arn" {
  description = "(Optional) The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group"
  default     = null
}

variable "flow_log_log_destination_type" {
  description = "(Optional) The type of the logging destination. Valid values: cloud-watch-logs, s3. Default: cloud-watch-logs"
  default     = "cloud-watch-logs"
}

variable "flow_log_log_destination" {
  description = "(Optional) The ARN of the logging destination."
  default     = null
}

variable "flow_log_subnet_id" {
  description = "(Optional) Subnet ID to attach to"
  default     = null
}

variable "flow_log_log_format" {
  description = "(Optional) The fields to include in the flow log record, in the order in which they should appear."
  default     = null
}

variable "flow_log_max_aggregation_interval" {
  description = "(Optional) The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: 60 seconds (1 minute) or 600 seconds (10 minutes). Default: 600."
  default     = 600
}

#---------------------------------------------------
# AWS VPC network acl
#---------------------------------------------------
variable "enable_network_acl" {
  description = "Enable network acl for VPC usage"
  default     = false
}

variable "network_acl_subnet_ids" {
  description = "(Optional) A list of Subnet IDs to apply the ACL to"
  default     = null
}

variable "network_acl_name" {
  description = "Set name for VPC network acl"
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

variable "network_acl_rule_network_acl_id" {
  description = "The ID of the network ACL."
  default     = ""
}

variable "network_acl_rule_rule_number" {
  description = "(Required) The rule number for the entry (for example, 100). ACL entries are processed in ascending order by rule number."
  default     = 100
}

variable "network_acl_rule_protocol" {
  description = "(Required) The protocol. A value of -1 means all protocols."
  default     = "all"
}

variable "network_acl_rule_rule_action" {
  description = "(Required) Indicates whether to allow or deny the traffic that matches the rule. Accepted values: allow | deny"
  default     = "allow"
}

variable "network_acl_rule_egress" {
  description = "(Optional, bool) Indicates whether this is an egress rule (rule is applied to traffic leaving the subnet). Default false."
  default     = false
}

variable "network_acl_rule_cidr_block" {
  description = "(Optional) The network range to allow or deny, in CIDR notation (for example 172.16.0.0/24 )."
  default     = null
}

variable "network_acl_rule_ipv6_cidr_block" {
  description = "(Optional) The IPv6 CIDR block to allow or deny."
  default     = null
}

variable "network_acl_rule_from_port" {
  description = "(Optional) The from port to match."
  default     = null
}

variable "network_acl_rule_to_port" {
  description = "(Optional) The to port to match."
  default     = null
}

variable "network_acl_rule_icmp_type" {
  description = "(Optional) ICMP protocol: The ICMP type. Required if specifying ICMP for the protocol. e.g. -1"
  default     = null
}

variable "network_acl_rule_icmp_code" {
  description = "(Optional) ICMP protocol: The ICMP code. Required if specifying ICMP for the protocol. e.g. -1"
  default     = null
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

variable "vpc_ipv4_cidr_block_association_timeouts_create" {
  description = "(Default 10 minutes) Used for creating the association"
  default     = "10m"
}

variable "vpc_ipv4_cidr_block_association_timeouts_delete" {
  description = "(Default 10 minutes) Used for destroying the association"
  default     = "10m"
}

#---------------------------------------------------
# AWS egress only internet gateway
#---------------------------------------------------
variable "enable_egress_only_internet_gateway" {
  description = "Enable VPC egress only internet gateway usage. Creates an egress-only Internet gateway for your VPC. An egress-only Internet gateway is used to enable outbound communication over IPv6 from instances in your VPC to the Internet, and prevents hosts outside of your VPC from initiating an IPv6 connection with your instance."
  default     = false
}

#---------------------------------------------------
# AWS VPC main route table association
#---------------------------------------------------
variable "enable_main_route_table_association" {
  description = "Enable VPC main route table association usage."
  default     = false
}

variable "main_route_table_association_route_table_id" {
  description = "(Required) The ID of the Route Table to set as the new main route table for the target VPC"
  default     = ""
}
