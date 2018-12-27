#---------------------------------------------------
# Create VPC
#---------------------------------------------------
resource "aws_vpc" "vpc" {
    cidr_block                          = "${cidrsubnet(var.vpc_cidr, 0, 0)}"
    #cidr_block                          = "${var.vpc_cidr}"
    instance_tenancy                    = "${var.instance_tenancy}"
    enable_dns_support                  = "${var.enable_dns_support}"
    enable_dns_hostnames                = "${var.enable_dns_hostnames}"
    assign_generated_ipv6_cidr_block    = "${var.assign_generated_ipv6_cidr_block}"
    enable_classiclink                  = "${var.enable_classiclink}"
    
    tags {  
        Name            = "${lower(var.name)}-vpc-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}
#---------------------------------------------------
# Create security group
#---------------------------------------------------
resource "aws_security_group" "sg" {
    name                = "${var.name}-sg-${var.environment}"
    description         = "Security Group ${var.name}-sg-${var.environment}"
    vpc_id              = "${aws_vpc.vpc.id}"
    
    tags {
        Name            = "${var.name}-sg-${var.environment}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
  
    lifecycle {
        create_before_destroy = true
    }


    depends_on  = ["aws_vpc.vpc"]
}
#---------------------------------------------------
# Add security group rules (one more way)
#---------------------------------------------------
resource "aws_security_group_rule" "ingress_ports" {
    count               = "${length(var.allowed_ports)}"

    type                = "ingress"
    security_group_id   = "${aws_security_group.sg.id}"
    from_port           = "${element(var.allowed_ports, count.index)}"
    to_port             = "${element(var.allowed_ports, count.index)}"
    protocol            = "tcp"
    cidr_blocks         = ["${var.allow_cidrs_for_allowed_ports[element(var.allowed_ports, count.index)]}"]
    
    depends_on          = ["aws_security_group.sg"]
}
resource "aws_security_group_rule" "egress_ports" {
    count               = "${var.enable_all_egress_ports ? 0 : length(var.allowed_ports)}"

    type                = "egress"
    security_group_id   = "${aws_security_group.sg.id}"
    from_port           = "${element(var.allowed_ports, count.index)}"
    to_port             = "${element(var.allowed_ports, count.index)}"
    protocol            = "tcp"
    cidr_blocks         = ["${var.allow_cidrs_for_allowed_ports[element(var.allowed_ports, count.index)]}"] 
    
    depends_on          = ["aws_security_group.sg"]
}
resource "aws_security_group_rule" "icmp-self" {
    security_group_id   = "${aws_security_group.sg.id}"
    type                = "ingress"
    protocol            = "icmp"
    from_port           = -1
    to_port             = -1
    self                = true
    
    depends_on          = ["aws_security_group.sg"]
}
resource "aws_security_group_rule" "default_egress" {
    count             = "${var.enable_all_egress_ports ? 1 : 0}"

    type              = "egress"
    security_group_id = "${aws_security_group.sg.id}"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    
    depends_on        = ["aws_security_group.sg"]
}
#---------------------------------------------------
# Add AWS subnets (private)
#---------------------------------------------------
resource "aws_subnet" "private_subnets" {
    count                   = "${length(var.private_subnet_cidrs)}"
    
    cidr_block              = "${var.private_subnet_cidrs[count.index]}"
    vpc_id                  = "${aws_vpc.vpc.id}"
    map_public_ip_on_launch = "false"
    availability_zone       = "${element(var.availability_zones, count.index)}"
    
    tags {
        Name            = "${lower(var.name)}-${lower(var.environment)}-private_subnet-${count.index+1}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
    
    depends_on        = ["aws_vpc.vpc"]
}
#---------------------------------------------------
# Add AWS subnets (public)
#---------------------------------------------------
resource "aws_subnet" "public_subnets" {
    count                   = "${length(var.public_subnet_cidrs)}"    

    cidr_block              = "${var.public_subnet_cidrs[count.index]}"
    vpc_id                  = "${aws_vpc.vpc.id}"
    map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
    availability_zone       = "${element(var.availability_zones, count.index)}"
    
    tags {
        Name            = "${lower(var.name)}-${lower(var.environment)}-public_subnet-${count.index+1}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
    
    depends_on        = ["aws_vpc.vpc"]
}
#---------------------------------------------------
# Add AWS internet gateway 
#---------------------------------------------------
resource "aws_internet_gateway" "internet_gw" {
    count = "${length(var.public_subnet_cidrs) > 0 ? 1 : 0}"
    
    vpc_id = "${aws_vpc.vpc.id}"
    
    tags {
        Name            = "internet-gateway to ${var.name}-vpc-${var.environment}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
    
    depends_on        = ["aws_vpc.vpc"]
}
resource "aws_route_table" "public_route_tables" {
    count            = "${length(var.public_subnet_cidrs) > 0 ? 1 : 0}"
    
    vpc_id           = "${aws_vpc.vpc.id}"
    propagating_vgws = ["${var.public_propagating_vgws}"]
    
    tags {
        Name            = "public_route_tables"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
    
    depends_on        = ["aws_vpc.vpc"]
}
resource "aws_route" "public_internet_gateway" {
    count                  = "${length(var.public_subnet_cidrs) > 0 ? 1 : 0}"
    
    route_table_id         = "${aws_route_table.public_route_tables.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "${aws_internet_gateway.internet_gw.id}"
    
    depends_on             = ["aws_internet_gateway.internet_gw", "aws_route_table.public_route_tables"]
}
#---------------------------------------------------
# CREATE EIP
#---------------------------------------------------
resource "aws_eip" "nat_eip" {
    count       = "${var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.availability_zones)) : 0}"
    
    vpc         = true
    
    depends_on  = ["aws_internet_gateway.internet_gw"]
}
#---------------------------------------------------
# CREATE NAT
#---------------------------------------------------
resource "aws_nat_gateway" "nat_gw" {
    count           = "${var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(var.availability_zones)) : 0}"
    
    allocation_id   = "${element(aws_eip.nat_eip.*.id, (var.single_nat_gateway ? 0 : count.index))}"
    subnet_id       = "${element(aws_subnet.public_subnets.*.id, (var.single_nat_gateway ? 0 : count.index))}"
    
    depends_on      = ["aws_internet_gateway.internet_gw", "aws_subnet.public_subnets"]
}
#---------------------------------------------------
# Create private route table and the route to the internet
#---------------------------------------------------
resource "aws_route_table" "private_route_tables" {
    count               = "${length(var.private_subnet_cidrs) > 0 ? 1 : 0}"
                    
    vpc_id              = "${aws_vpc.vpc.id}"
    propagating_vgws    = ["${var.private_propagating_vgws}"]
    
    tags {
        Name            = "private_route_tables"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
    
    lifecycle {
        # When attaching VPN gateways it is common to define aws_vpn_gateway_route_propagation
        # resources that manipulate the attributes of the routing table (typically for the private subnets)
        ignore_changes = ["propagating_vgws"]
    }   

    depends_on          = ["aws_vpc.vpc"]
}
resource "aws_route" "private_nat_gateway" {
    count                   = "${var.enable_nat_gateway ? length(var.availability_zones) : 0}"
    
    route_table_id          = "${element(aws_route_table.private_route_tables.*.id, count.index)}"
    destination_cidr_block  = "0.0.0.0/0"
    nat_gateway_id          = "${element(aws_nat_gateway.nat_gw.*.id, count.index)}"
    
    depends_on              = ["aws_nat_gateway.nat_gw", "aws_route_table.private_route_tables"]
}
#---------------------------------------------------
# CREATE VPN
#---------------------------------------------------
###############################
# VPN Gateway
###############################
resource "aws_vpn_gateway" "vpn_gw" {
    count   = "${var.enable_vpn_gateway ? 1 : 0}"
    
    vpc_id  = "${aws_vpc.vpc.id}"
    
    tags {
        Name            = "vpn_gateway"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
    
    depends_on          = ["aws_vpc.vpc"]
}
#---------------------------------------------------
# CREATE DHCP
#---------------------------------------------------
resource "aws_vpc_dhcp_options" "vpc_dhcp_options" {
    count                = "${var.enable_dhcp_options ? 1 : 0}"
    
    domain_name          = "${var.dhcp_options_domain_name}"
    domain_name_servers  = "${var.dhcp_options_domain_name_servers}"
    ntp_servers          = "${var.dhcp_options_ntp_servers}"
    netbios_name_servers = "${var.dhcp_options_netbios_name_servers}"
    netbios_node_type    = "${var.dhcp_options_netbios_node_type}"
    
    tags {
        Name            = "dhcp"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}
#---------------------------------------------------
# Route Table Associations 
#---------------------------------------------------
##############################
# private
##############################
resource "aws_route_table_association" "private_route_table_associations" {
    count           = "${length(var.private_subnet_cidrs)}"
    
    subnet_id       = "${element(aws_subnet.private_subnets.*.id, count.index)}"
    route_table_id  = "${element(aws_route_table.private_route_tables.*.id, count.index)}"
    
    depends_on      = ["aws_route_table.private_route_tables", "aws_subnet.private_subnets"]
}
##############################
# public
##############################
resource "aws_route_table_association" "public_route_table_associations" {
    count           = "${length(var.public_subnet_cidrs)}"
    
    subnet_id       = "${element(aws_subnet.public_subnets.*.id, count.index)}"
    route_table_id  = "${aws_route_table.public_route_tables.id}"    
    
    depends_on      = ["aws_route_table.public_route_tables", "aws_subnet.public_subnets"]
}
###############################
# DHCP Options Set Association
###############################
resource "aws_vpc_dhcp_options_association" "vpc_dhcp_options_association" {
    count           = "${var.enable_dhcp_options ? 1 : 0}"
    
    vpc_id          = "${aws_vpc.vpc.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.vpc_dhcp_options.id}"
    
    depends_on      = ["aws_vpc.vpc", "aws_vpc_dhcp_options.vpc_dhcp_options"]
}
