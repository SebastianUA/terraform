output "instance_tenancy" {
    value = "${aws_vpc.vpc.instance_tenancy}"
}
output "vpc_id" {
    value = "${aws_vpc.vpc.id}"
}
output "vpc_cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}
output "default_network_acl_id" {
    value = "${aws_vpc.vpc.default_network_acl_id}"
}
output "security_group_id" {
    value = "${aws_security_group.sg.id}"
}
output "default_security_group_id" {
    value = "${aws_vpc.vpc.default_security_group_id}"
}
output "public_route_table_ids" {
    value = ["${aws_route_table.public_route_tables.*.id}"]
}
output "private_route_table_ids" {
    value = ["${aws_route_table.private_route_tables.*.id}"]
}    
output "vpc-publicsubnets" {
    value = "${aws_subnet.public_subnets.*.cidr_block}"
}
output "vpc-publicsubnet-id_0" {
    value = "${aws_subnet.public_subnets.0.id}"
}
output "vpc-publicsubnet-ids" {
    value = "${aws_subnet.public_subnets.*.id}"
}
output "vpc-privatesubnets" {
    value   = "${aws_subnet.private_subnets.*.cidr_block}"
}
output "vpc-privatesubnet-ids" {
    value = "${aws_subnet.private_subnets.*.id}"
}
output "nat_eips" {
    value = ["${aws_eip.nat_eip.*.id}"]
}
output "nat_eips_public_ips" {
    value = ["${aws_eip.nat_eip.*.public_ip}"]
}
output "natgw_ids" {
    value = ["${aws_nat_gateway.nat_gw.*.id}"]
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
