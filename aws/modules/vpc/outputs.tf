output "instance_tenancy" {
    description = ""
    value       = "${aws_vpc.vpc.instance_tenancy}"
}       

output "vpc_id" {
    description = ""
    #value       = "${aws_vpc.vpc.id}"
    value       = "${element(concat(aws_vpc.vpc.*.id, list("")), 0)}"
}

output "vpc_cidr_block" {
    description = ""  
    #value       = "${aws_vpc.vpc.cidr_block}"
    value       = "${element(concat(aws_vpc.vpc.*.cidr_block, list("")), 0)}"
}

output "default_network_acl_id" {
    description = ""
    value       = "${aws_vpc.vpc.default_network_acl_id}"
}       

output "security_group_id" {
    description = ""
    value       = "${aws_security_group.sg.id}"
}       

output "default_security_group_id" {
    description = ""
    value       = "${aws_vpc.vpc.default_security_group_id}"
}       

output "public_route_table_ids" {
    description = ""
    value       = ["${aws_route_table.public_route_tables.*.id}"]
}           

output "private_route_table_ids" {
    description = ""
    value       = ["${aws_route_table.private_route_tables.*.id}"]
}           

output "vpc-publicsubnets" {
    description = ""
    value       = "${aws_subnet.public_subnets.*.cidr_block}"
}       

output "vpc-publicsubnet-id_0" {
    description = ""
    value       = "${aws_subnet.public_subnets.0.id}"
}       

output "vpc-publicsubnet-ids" {
    description = ""
    value       = "${aws_subnet.public_subnets.*.id}"
}           

output "vpc-privatesubnets" {
    description = ""
    value       = "${aws_subnet.private_subnets.*.cidr_block}"
}           

output "vpc-privatesubnet-ids" {
    description = ""
    value       = "${aws_subnet.private_subnets.*.id}"
}
   
# NAT Gateway
output "nat_name" {
    description = ""
    value       = ["${aws_eip.nat_eip.*.name}"]
}

output "nat_ids" {
    description = ""
    value       = ["${aws_eip.nat_eip.*.id}"]
}           

output "nat_eip_public_ips" {
    description = ""
    value       = ["${aws_eip.nat_eip.*.public_ip}"]
    #value       = "${element(concat(aws_eip.nat_eip.*.public_ip, list("")), 0)}"
}       

output "natgw_ids" {
    description = ""
    value       = ["${aws_nat_gateway.nat_gw.*.id}"]
}       

# Single NAT Gateway
output "single_nat_gateway_name" {
    description = ""
    #value       = "${element(concat(aws_nat_gateway.nat_gw.*.name, list("")), 0)}"
    value       = ["${aws_nat_gateway.nat_gw.*.name}"]
}

output "single_nat_gateway_id" {
    description = ""
    value       = "${element(concat(aws_nat_gateway.nat_gw.*.id, list("")), 0)}"
}

output "single_nat_gateway_cidr" {
    description = ""
    value       = "${element(concat(aws_nat_gateway.nat_gw.*.cidr_block, list("")), 0)}"
}

output "single_nat_gateway_public-ip" {
    description = ""
    value       = "${element(concat(aws_nat_gateway.nat_gw.*.public_ip, list("")), 0)}"
}

# Internet Gateway
output "gateway_id" {
    description = "The ID of the Internet Gateway"
    value       = "${element(concat(aws_internet_gateway.internet_gw.*.id, list("")), 0)}"
}

# VPN Gateway
output "vgw_id" {
  description = "The ID of the VPN Gateway"
  value       = "${element(concat(aws_vpn_gateway.vpn_gw.*.id, list("")), 0)}"
}
