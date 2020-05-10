#---------------------------------------------------
# AWS Workspaces directory
#---------------------------------------------------
output "workspaces_directory_id" {
    description = "The ID of the workspaces directory."
    value       = element(concat(aws_workspaces_directory.workspaces_directory.*.id, [""]), 0)
}

output "workspaces_directory_workspace_security_group_id" {
    description = "The identifier of the security group that is assigned to new WorkSpaces."
    value       = element(concat(aws_workspaces_directory.workspaces_directory.*.workspace_security_group_id, [""]), 0)
}

output "workspaces_directory_iam_role_id" {
    description = "The identifier of the IAM role. This is the role that allows Amazon WorkSpaces to make calls to other services, such as Amazon EC2, on your behalf."
    value       = element(concat(aws_workspaces_directory.workspaces_directory.*.iam_role_id, [""]), 0)
}

output "workspaces_directory_registration_code" {
    description = "The registration code for the directory. This is the code that users enter in their Amazon WorkSpaces client application to connect to the directory."
    value       = element(concat(aws_workspaces_directory.workspaces_directory.*.registration_code, [""]), 0)
}

output "workspaces_directory_directory_name" {
    description = "The name of the directory."
    value       = element(concat(aws_workspaces_directory.workspaces_directory.*.directory_name, [""]), 0)
}

output "workspaces_directory_directory_type" {
    description = " The directory type."
    value       = element(concat(aws_workspaces_directory.workspaces_directory.*.directory_type, [""]), 0)
}

output "workspaces_directory_customer_user_name" {
    description = "The user name for the service account."
    value       = element(concat(aws_workspaces_directory.workspaces_directory.*.customer_user_name, [""]), 0)
}

output "workspaces_directory_alias" {
    description = "The directory alias."
    value       = element(concat(aws_workspaces_directory.workspaces_directory.*.alias, [""]), 0)
}

output "workspaces_directory_ip_group_ids" {
    description = "The identifiers of the IP access control groups associated with the directory."
    value       = element(concat(aws_workspaces_directory.workspaces_directory.*.ip_group_ids, [""]), 0)
}

output "workspaces_directory_dns_ip_addresses" {
    description = "The IP addresses of the DNS servers for the directory."
    value       = concat(aws_workspaces_directory.workspaces_directory.*.dns_ip_addresses, [""])
}

#---------------------------------------------------
# AWS Workspaces ip group
#---------------------------------------------------
output "workspaces_ip_group_id" {
    description = "The IP group identifier."
    value       = element(concat(aws_workspaces_ip_group.workspaces_ip_group.*.id, [""]), 0)
}
