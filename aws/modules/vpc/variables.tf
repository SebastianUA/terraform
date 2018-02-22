#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-VPC"
}

variable "instance_tenancy" {
    description = "instance tenancy"
    default     = "default"
}

variable "enable_dns_support" {
    description = "Enabling dns support"
    default     = "true"
}

variable "enable_dns_hostnames" {
    description = "Enabling dns hostnames"
    default     = "true"
}

variable "assign_generated_ipv6_cidr_block" {
    description = "Generation IPv6"
    default     = "false"
}

variable "enable_classiclink" {
    description = "Enabling classiclink"
    default     = "false"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

#---------------------------------------------------------------
# Custom variables
#---------------------------------------------------------------
variable "allowed_ports" {
  description = "Allowed ports from/to host"
  type        = "list"
}

variable "allow_cidrs_for_allowed_ports" {
    description = "Set allowed cidrs for allowed_ports"
    type        = "map"
    default     = {
        "80"        = ["0.0.0.0/0"]
        "443"       = ["0.0.0.0/0"]
        "3306"      = ["0.0.0.0/0"]
        "8080"      = ["0.0.0.0/0"]
        "5672"      = ["0.0.0.0/0"]
    }
}

variable "enable_all_egress_ports" {
    description = "Allows all ports from host"
    default     = false
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    #type        = "list"
    #default     = []
}

variable "public_subnet_cidrs" {
    description = "CIDR for the Public Subnet"
    type        = "list"
    default     = []
}

variable "private_subnet_cidrs" {
    description = "CIDR for the Private Subnet"
    type        = "list"
    default     = []
}

variable "availability_zones" {
    description = "A list of Availability zones in the region"
    type        = "list"
    default     = []
}

#variable "availability_zones" {
#  type = "map"
#
#  default = {
#    us-east-1      = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
#    us-east-2      = ["us-east-2a", "eu-east-2b", "eu-east-2c"]
#    us-west-1      = ["us-west-1a", "us-west-1c"]
#    us-west-2      = ["us-west-2a", "us-west-2b", "us-west-2c"]
#    ca-central-1   = ["ca-central-1a", "ca-central-1b"]
#    eu-west-1      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
#    eu-west-2      = ["eu-west-2a", "eu-west-2b"]
#    eu-central-1   = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
#    ap-south-1     = ["ap-south-1a", "ap-south-1b"]
#    sa-east-1      = ["sa-east-1a", "sa-east-1c"]
#    ap-northeast-1 = ["ap-northeast-1a", "ap-northeast-1c"]
#    ap-southeast-1 = ["ap-southeast-1a", "ap-southeast-1b"]
#    ap-southeast-2 = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
#    ap-northeast-1 = ["ap-northeast-1a", "ap-northeast-1c"]
#    ap-northeast-2 = ["ap-northeast-2a", "ap-northeast-2c"]
#  }
#}

variable "enable_internet_gateway" {
    description = "Allow Internet GateWay to/from public network"
    default     = "false"
}

variable "private_propagating_vgws" {
    description = "A list of VGWs the private route table should propagate."
    type        = "list"
    default     = []
}

variable "public_propagating_vgws" {
    description = "A list of VGWs the public route table should propagate."
    default     = []
}

variable "enable_vpn_gateway" {
    description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
    default     = false
}

variable "enable_nat_gateway" {
    description = "Allow Nat GateWay to/from private network"
    default     = "false"
}

variable "single_nat_gateway" {
    description = "should be true if you want to provision a single shared NAT Gateway across all of your private networks"
    default     = "false"
}

variable "enable_eip" {
    description = "Allow creation elastic eip"
    default     = "false"
}

variable "map_public_ip_on_launch" {
    description = "should be false if you do not want to auto-assign public IP on launch"
    default     = "true"
}

variable "enable_dhcp_options" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  default     = false
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set"
  default     = ""
}

variable "dhcp_options_domain_name_servers" {
  description = "Specify a list of DNS server addresses for DHCP options set, default to AWS provided"
  type        = "list"
  default     = ["AmazonProvidedDNS"]
}

variable "dhcp_options_ntp_servers" {
  description = "Specify a list of NTP servers for DHCP options set"
  type        = "list"
  default     = []
}

variable "dhcp_options_netbios_name_servers" {
  description = "Specify a list of netbios servers for DHCP options set"
  type        = "list"
  default     = []
}

variable "dhcp_options_netbios_node_type" {
  description = "Specify netbios node_type for DHCP options set"
  default     = ""
}
