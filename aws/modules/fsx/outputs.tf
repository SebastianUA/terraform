#---------------------------------------------------
# AWS fsx lustre file system
#---------------------------------------------------
output "fsx_lustre_file_system_id" {
  description = "Identifier of the file system, e.g. fs-12345678"
  value       = element(concat(aws_fsx_lustre_file_system.fsx_lustre_file_system.*.id, [""]), 0)
}

output "fsx_lustre_file_system_arn" {
  description = "Amazon Resource Name of the file system."
  value       = element(concat(aws_fsx_lustre_file_system.fsx_lustre_file_system.*.arn, [""]), 0)
}

output "fsx_lustre_file_system_dns_name" {
  description = "DNS name for the file system, e.g. fs-12345678.fsx.us-west-2.amazonaws.com"
  value       = element(concat(aws_fsx_lustre_file_system.fsx_lustre_file_system.*.dns_name, [""]), 0)
}

output "fsx_lustre_file_system_network_interface_ids" {
  description = "Set of Elastic Network Interface identifiers from which the file system is accessible."
  value       = concat(aws_fsx_lustre_file_system.fsx_lustre_file_system.*.network_interface_ids, [""])
}

output "fsx_lustre_file_system_owner_id" {
  description = "AWS account identifier that created the file system."
  value       = element(concat(aws_fsx_lustre_file_system.fsx_lustre_file_system.*.owner_id, [""]), 0)
}

output "fsx_lustre_file_system_vpc_id" {
  description = "Identifier of the Virtual Private Cloud for the file system."
  value       = element(concat(aws_fsx_lustre_file_system.fsx_lustre_file_system.*.vpc_id, [""]), 0)
}

#---------------------------------------------------
# AWS fsx windows file system
#---------------------------------------------------
output "fsx_windows_file_system_id" {
  description = "Identifier of the file system, e.g. fs-12345678"
  value       = element(concat(aws_fsx_windows_file_system.fsx_windows_file_system.*.id, [""]), 0)
}

output "fsx_windows_file_system_arn" {
  description = "Amazon Resource Name of the file system."
  value       = element(concat(aws_fsx_windows_file_system.fsx_windows_file_system.*.arn, [""]), 0)
}


output "fsx_windows_file_system_dns_name" {
  description = "DNS name for the file system, e.g. fs-12345678.corp.example.com (domain name matching the Active Directory domain name)"
  value       = element(concat(aws_fsx_windows_file_system.fsx_windows_file_system.*.dns_name, [""]), 0)
}

output "fsx_windows_file_system_network_interface_ids" {
  description = "Set of Elastic Network Interface identifiers from which the file system is accessible."
  value       = concat(aws_fsx_windows_file_system.fsx_windows_file_system.*.network_interface_ids, [""])
}

output "fsx_windows_file_system_owner_id" {
  description = "AWS account identifier that created the file system."
  value       = element(concat(aws_fsx_windows_file_system.fsx_windows_file_system.*.owner_id, [""]), 0)
}

output "fsx_windows_file_system_vpc_id" {
  description = "Identifier of the Virtual Private Cloud for the file system."
  value       = element(concat(aws_fsx_windows_file_system.fsx_windows_file_system.*.vpc_id, [""]), 0)
}
