# Output the IDs of the EC2 instances created
output "instance_ids" {
    description = ""
    value       = element(concat(aws_instance.instance.*.id, [""], ), 0)
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = element(concat(aws_instance.instance.*.availability_zone, [""], ), 0)
}

output "key_name" {
  description = "List of key names of instances"
  value       = element(concat(aws_instance.instance.*.key_name, [""], ), 0)
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = element(concat(aws_instance.instance.*.public_dns, [""], ), 0)
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = element(concat(aws_instance.instance.*.public_ip, [""], ), 0)
}

output "network_interface_id" {
  description = "List of IDs of the network interface of instances"
  value       = element(concat(aws_instance.instance.*.network_interface_id, [""], ), 0)
}

output "primary_network_interface_id" {
  description = "List of IDs of the primary network interface of instances"
  value       = element(concat(aws_instance.instance.*.primary_network_interface_id, [""], ), 0)
}

output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = element(concat(aws_instance.instance.*.private_dns, [""], ), 0)
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = element(concat(aws_instance.instance.*.private_ip, [""], ), 0)
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = aws_instance.instance.*.security_groups
}

output "vpc_security_group_ids" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value       = aws_instance.instance.*.vpc_security_group_ids
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = element(concat(aws_instance.instance.*.subnet_id, [""], ), 0)
}

output "tags" {
  description = "List of tags of instances"
  value       = aws_instance.instance.*.tags
}
