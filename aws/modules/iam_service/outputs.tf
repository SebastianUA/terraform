#-----------------------------------------------------------
# IAM service linked role
#-----------------------------------------------------------
output "iam_service_linked_role_id" {
  description = "The Amazon Resource Name (ARN) of the role."
  value       = element(concat(aws_iam_service_linked_role.iam_service_linked_role.*.id, [""]), 0)
}

output "iam_service_linked_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = element(concat(aws_iam_service_linked_role.iam_service_linked_role.*.arn, [""]), 0)
}

output "iam_service_linked_role_create_date" {
  description = "The creation date of the IAM role."
  value       = element(concat(aws_iam_service_linked_role.iam_service_linked_role.*.create_date, [""]), 0)
}

output "iam_service_linked_role_name" {
  description = "The name of the role."
  value       = element(concat(aws_iam_service_linked_role.iam_service_linked_role.*.name, [""]), 0)
}

output "iam_service_linked_role_path" {
  description = "The path of the role."
  value       = element(concat(aws_iam_service_linked_role.iam_service_linked_role.*.path, [""]), 0)
}

output "iam_service_linked_role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = element(concat(aws_iam_service_linked_role.iam_service_linked_role.*.unique_id, [""]), 0)
}
