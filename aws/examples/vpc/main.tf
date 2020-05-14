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

#---------------------------------------------------------------
# VPC custom routing
#---------------------------------------------------------------
module "vpc_custom_routings" {
    source                                          = "../../modules/vpc"
    name                                            = "vpc_custom_routings"
    environment                                     = "dev"

    # VPC
    enable_vpc                                      = true
    vpc_name                                        = "vpc-custom-routings"

    instance_tenancy                                = "default"
    enable_dns_support                              = true
    enable_dns_hostnames                            = true
    assign_generated_ipv6_cidr_block                = false

    vpc_cidr                                        = "12.11.0.0/16"
    private_subnet_cidrs                            = ["12.11.1.0/24"]
    public_subnet_cidrs                             = ["12.11.2.0/24", "12.11.3.0/24"]

    #Internet-GateWay
    enable_internet_gateway                         = true
    #NAT
    enable_nat_gateway                              = false
    single_nat_gateway                              = false

    #DHCP
    enable_dhcp                                     = true
    dhcp_options_domain_name                        = "ec2.internal"
    dhcp_options_domain_name_servers                = ["AmazonProvidedDNS"]

    # EIP
    enable_eip                                      = false

    private_custom_peering_destination_cidr_block   = ["1.2.3.4/32", "4.3.2.1/32"]
    private_custom_gateway_id                       = "tgw-05b56a37c420a2635"

    tags                                            = map("Env", "stage", "Orchestration", "Terraform")
}

#---------------------------------------------------------------
# VPC Endpoint
#---------------------------------------------------------------
module "vpc_endpoint" {
    source                              = "../../modules/vpc"
    name                                = "endpoint"
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

    vpc_cidr                            = "10.11.0.0/16"
    private_subnet_cidrs                = ["10.11.1.0/24"]
    public_subnet_cidrs                 = ["10.11.2.0/24", "10.11.3.0/24"]
    #azs                                 = ["us-east-1a", "us-east-1b"]

    #Internet-GateWay
    enable_internet_gateway             = true
    #NAT
    #enable_nat_gateway                  = true
    single_nat_gateway                  = true
    #DHCP
    enable_dhcp                         = true
    # EIP
    enable_eip                          = false

    #VPN
    enable_vpn_gateway                  = false
    vpn_gw_name                         = ""
    vpn_gw_availability_zone            = null
    vpn_gw_amazon_side_asn              = 64512
    vpn_connection_static_routes_only   = true
    vpn_connection_route_cidr_block     = "192.168.113.0/24" # Set IP addr cidr; For example: office's IP subnet.

    customer_gateway_bgp_asn            = 65000
    customer_gateway_ip_address         = "1.2.3.4" # Set IP addr gateway; For example: office's IP GW.

    # VPC endpoint (S3)
    enable_vpc_endpoint                 = false
    vpc_endpoint_name                   = "s3-endpoint-for-emr"
    vpc_endpoint_service_name           = "com.amazonaws.us-east-1.s3"
    vpc_endpoint_vpc_endpoint_type      = "Gateway"
    vpc_endpoint_security_group_ids     = ["sg-0ac2ce954f45c8f6a", "sg-0919aabecaea96510"]
    vpc_endpoint_auto_accept            = true
    vpc_endpoint_private_dns_enabled    = true

    # VPC endpoint (SQS)
    enable_vpc_endpoint                 = false
    vpc_endpoint_name                   = "sqs-endpoint-for-emr"
    vpc_endpoint_service_name           = "com.amazonaws.us-east-1.sqs"
    vpc_endpoint_vpc_endpoint_type      = "Interface"
    vpc_endpoint_security_group_ids     = ["sg-0ac2ce954f45c8f6a", "sg-0919aabecaea96510"]
    vpc_endpoint_auto_accept            = true
    vpc_endpoint_private_dns_enabled    = true

    # VPC endpoint (SNS)
    enable_vpc_endpoint                 = false
    vpc_endpoint_name                   = "sns-endpoint-for-emr"
    vpc_endpoint_service_name           = "com.amazonaws.us-east-1.sns"
    vpc_endpoint_vpc_endpoint_type      = "Interface"
    vpc_endpoint_security_group_ids     = ["sg-0ac2ce954f45c8f6a", "sg-0919aabecaea96510"]
    vpc_endpoint_auto_accept            = true
    vpc_endpoint_private_dns_enabled    = true

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}

#---------------------------------------------------------------
# VPC VPN
#---------------------------------------------------------------
module "vpc_vpn" {
    source                              = "../../modules/vpc"
    name                                = "vpn"
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

    vpc_cidr                            = "10.10.0.0/16"
    private_subnet_cidrs                = ["10.10.1.0/24"]
    public_subnet_cidrs                 = ["10.10.2.0/24", "10.10.3.0/24"]
    #azs                                 = ["us-east-1a", "us-east-1b"]

    #Internet-GateWay
    enable_internet_gateway             = true
    #NAT
    #enable_nat_gateway                  = true
    single_nat_gateway                  = true
    #DHCP
    enable_dhcp                         = true
    # EIP
    enable_eip                          = false

    #VPN
    enable_vpn_gateway                  = true
    vpn_gw_name                         = ""
    vpn_gw_availability_zone            = null
    vpn_gw_amazon_side_asn              = 64512
    vpn_connection_static_routes_only   = true
    vpn_connection_route_cidr_block     = "192.168.113.0/24" # Set IP addr cidr; For example: office's IP subnet.

    customer_gateway_bgp_asn            = 65000
    customer_gateway_ip_address         = "1.2.3.4" # Set IP addr gateway; For example: office's IP GW.

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}

#---------------------------------------------------------------
# 1rst VPC for peering
#---------------------------------------------------------------
module "vpc_1" {
    source                              = "../../modules/vpc"
    name                                = "test"
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

    vpc_cidr                            = "6.6.0.0/16"
    private_subnet_cidrs                = ["6.6.1.0/24"]
    public_subnet_cidrs                 = ["6.6.2.0/24", "6.6.3.0/24"]
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

    # for peering
    peering_destination_cidr_block      = "172.32.0.0/16"
    peering_gateway_id                  = module.vpc_2.vpc_peering_connection_id
}

#---------------------------------------------------------------
# 2d VPC for peering with VPC flow log & VPC network ACLs
#---------------------------------------------------------------
module "vpc_2" {
    source                              = "../../modules/vpc"
    name                                = "test2"
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

    # VPC flow log
    enable_flow_log                     = false
    flow_log_name                       = ""
    flow_log_traffic_type               = "ALL"
    flow_log_iam_role_arn               = "arn:aws:iam::167127734783:role/vpc-flow-log"
    flow_log_log_destination            = "arn:aws:logs:us-east-1:167127734783:log-group:vpc-flow-log-test"

    # VPC network ACLs
    enable_network_acl                  = true
    network_acl_name                    = ""
    network_acl_subnet_ids              = []

    network_acl_ingress                 = [{
        from_port       = 0
        to_port         = 0
        rule_no         = 100
        action          = "allow"
        protocol        = -1
        cidr_block      = "0.0.0.0/0"
        ipv6_cidr_block = null
        icmp_type       = 0
        icmp_code       = 0
    }]

    network_acl_egress                  = [{
        from_port       = 0
        to_port         = 0
        rule_no         = 100
        action          = "allow"
        protocol        = -1
        cidr_block      = "0.0.0.0/0"
        ipv6_cidr_block = null
        icmp_type       = 0
        icmp_code       = 0
    }]

    # VPC peering
    enable_vpc_peering                  = true
    vpc_peering_connection_peer_vpc_id  = module.vpc_1.vpc_id
    vpc_peering_connection_auto_accept  = true
    peering_destination_cidr_block      = "6.6.0.0/16"

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}
