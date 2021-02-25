#---------------------------------------------------------------
# Global or/and default variables
#---------------------------------------------------------------
variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
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

#---------------------------------------------------------------
# AWS VPC
#---------------------------------------------------------------
variable "enable_default_vpc" {
  description = "Enable default VPC usage"
  default     = false
}

variable "default_vpc_name" {
  description = "Set custom name for default VPC"
  default     = ""
}

variable "default_vpc_enable_dns_support" {
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  default     = true
}

variable "default_vpc_enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults true."
  default     = true
}

variable "default_vpc_enable_classiclink" {
  description = "(Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false."
  default     = false
}

#---------------------------------------------------------------
# AWS subnets
#---------------------------------------------------------------
variable "default_subnet_name" {
  description = "Default subnet name for the region"
  default     = ""
}

variable "default_subnet_map_public_ip_on_launch" {
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
  default     = null
}

variable "default_subnet_azs" {
  description = "A list of Availability zones in the region"
  default     = []
}

#---------------------------------------------------
# AWS default vpc dhcp options
#---------------------------------------------------
variable "default_vpc_dhcp_options_name" {
  description = "Set name for DHCP"
  default     = ""
}

variable "default_vpc_dhcp_options_netbios_name_servers" {
  description = "(Optional) List of NETBIOS name servers."
  default     = null
}

variable "default_vpc_dhcp_options_netbios_node_type" {
  description = "(Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. For more information about these node types, see RFC 2132."
  default     = null
}

#---------------------------------------------------
# AWS default security group
#---------------------------------------------------
variable "default_security_group_name" {
  description = "Set name for default SG"
  default     = "default"
}

#---------------------------------------------------
# AWS default network acl
#---------------------------------------------------
variable "default_network_acl_name" {
  description = "Set name for default network ACL"
  default     = "default"
}

#---------------------------------------------------
# AWS default route table
#---------------------------------------------------
variable "default_route_table_name" {
  description = "Set default table name"
  default     = "default table"
}

variable "default_route_table_propagating_vgws" {
  description = "(Optional) A list of virtual gateways for propagation."
  default     = null
}
