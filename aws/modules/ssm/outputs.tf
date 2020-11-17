/*
-----------------------------------------------------------
AWS SSM activation
-----------------------------------------------------------
*/
output "ssm_activation_id" {
  description = "The activation ID."
  value       = element(concat(aws_ssm_activation.ssm_activation.*.id, [""]), 0)
}

output "ssm_activation_activation_code" {
  description = "The code the system generates when it processes the activation."
  value       = element(concat(aws_ssm_activation.ssm_activation.*.activation_code, [""]), 0)
}

output "ssm_activation_name" {
  description = "The default name of the registered managed instance."
  value       = element(concat(aws_ssm_activation.ssm_activation.*.name, [""]), 0)
}

output "ssm_activation_description" {
  description = "The description of the resource that was registered."
  value       = element(concat(aws_ssm_activation.ssm_activation.*.description, [""]), 0)
}

output "ssm_activation_expired" {
  description = "If the current activation has expired."
  value       = element(concat(aws_ssm_activation.ssm_activation.*.expired, [""]), 0)
}

output "ssm_activation_expiration_date" {
  description = "The date by which this activation request should expire. The default value is 24 hours."
  value       = element(concat(aws_ssm_activation.ssm_activation.*.expiration_date, [""]), 0)
}

output "ssm_activation_iam_role" {
  description = "The IAM Role attached to the managed instance."
  value       = element(concat(aws_ssm_activation.ssm_activation.*.iam_role, [""]), 0)
}

output "ssm_activation_registration_limit" {
  description = "The maximum number of managed instances you want to be registered. The default value is 1 instance."
  value       = element(concat(aws_ssm_activation.ssm_activation.*.registration_limit, [""]), 0)
}

output "ssm_activation_registration_count" {
  description = "The number of managed instances that are currently registered using this activation."
  value       = element(concat(aws_ssm_activation.ssm_activation.*.registration_count, [""]), 0)
}

#-----------------------------------------------------------
# AWS SSM association
#-----------------------------------------------------------
output "ssm_association_association_id" {
  description = "The ID of the SSM association."
  value       = element(concat(aws_ssm_association.ssm_association.*.association_id, [""]), 0)
}

output "ssm_association_instance_id" {
  description = "The instance id that the SSM document was applied to."
  value       = element(concat(aws_ssm_association.ssm_association.*.instance_id, [""]), 0)
}

output "ssm_association_name" {
  description = "The name of the SSM document to apply."
  value       = element(concat(aws_ssm_association.ssm_association.*.name, [""]), 0)
}

output "ssm_association_parameters" {
  description = "Additional parameters passed to the SSM document."
  value       = element(concat(aws_ssm_association.ssm_association.*.parameters, [""]), 0)
}

#-----------------------------------------------------------
# AWS SSM document
#-----------------------------------------------------------
output "aws_ssm_document_created_date" {
  description = "The date the document was created."
  value       = element(concat(aws_ssm_document.ssm_document.*.created_date, [""]), 0)
}

output "aws_ssm_document_description" {
  description = "The description of the document."
  value       = element(concat(aws_ssm_document.ssm_document.*.description, [""]), 0)
}

output "aws_ssm_document_schema_version" {
  description = "The schema version of the document."
  value       = element(concat(aws_ssm_document.ssm_document.*.schema_version, [""]), 0)
}

output "aws_ssm_document_default_version" {
  description = "The default version of the document."
  value       = element(concat(aws_ssm_document.ssm_document.*.default_version, [""]), 0)
}

output "aws_ssm_document_hash" {
  description = "The sha1 or sha256 of the document content"
  value       = element(concat(aws_ssm_document.ssm_document.*.hash, [""]), 0)
}

output "aws_ssm_document_hash_type" {
  description = "'Sha1' 'Sha256'. The hashing algorithm used when hashing the content."
  value       = element(concat(aws_ssm_document.ssm_document.*.hash_type, [""]), 0)
}

output "aws_ssm_document_latest_version" {
  description = "The latest version of the document."
  value       = element(concat(aws_ssm_document.ssm_document.*.latest_version, [""]), 0)
}

output "aws_ssm_document_owner" {
  description = "The AWS user account of the person who created the document."
  value       = element(concat(aws_ssm_document.ssm_document.*.owner, [""]), 0)
}

output "aws_ssm_document_status" {
  description = "'Creating', 'Active' or 'Deleting'. The current status of the document."
  value       = element(concat(aws_ssm_document.ssm_document.*.status, [""]), 0)
}

output "aws_ssm_document_parameter" {
  description = "The parameters that are available to this document."
  value       = element(concat(aws_ssm_document.ssm_document.*.parameter, [""]), 0)
}

output "aws_ssm_document_platform_types" {
  description = "A list of OS platforms compatible with this SSM document, either 'Windows' or 'Linux'."
  value       = element(concat(aws_ssm_document.ssm_document.*.platform_types, [""]), 0)
}

#-----------------------------------------------------------
# AWS SSM parameter
#-----------------------------------------------------------
output "aws_ssm_parameter_arn" {
  description = "The ARN of the parameter."
  value       = element(concat(aws_ssm_parameter.ssm_parameter.*.arn, [""]), 0)
}

output "aws_ssm_parameter_name" {
  description = "(Required) The name of the parameter."
  value       = element(concat(aws_ssm_parameter.ssm_parameter.*.name, [""]), 0)
}

output "aws_ssm_parameter_description" {
  description = "(Required) The description of the parameter."
  value       = element(concat(aws_ssm_parameter.ssm_parameter.*.description, [""]), 0)
}

output "aws_ssm_parameter_type" {
  description = "(Required) The type of the parameter. Valid types are String, StringList and SecureString."
  value       = element(concat(aws_ssm_parameter.ssm_parameter.*.type, [""]), 0)
}

output "aws_ssm_parameter_value" {
  description = "(Required) The value of the parameter."
  value       = element(concat(aws_ssm_parameter.ssm_parameter.*.value, [""]), 0)
}

output "aws_ssm_parameter_version" {
  description = "The version of the parameter."
  value       = element(concat(aws_ssm_parameter.ssm_parameter.*.version, [""]), 0)
}

#-----------------------------------------------------------
# AWS SSM patch group
#-----------------------------------------------------------
output "ssm_patch_group_id" {
  description = "The ID of the patch baseline."
  value       = element(concat(aws_ssm_patch_group.ssm_patch_group.*.id, [""]), 0)
}

#-----------------------------------------------------------
# AWS SSM patch baseline
#-----------------------------------------------------------
output "ssm_patch_baseline_id" {
  description = "The ID of the patch baseline."
  value       = element(concat(aws_ssm_patch_baseline.ssm_patch_baseline.*.id, [""]), 0)
}

#-----------------------------------------------------------
# AWS SSM resource data sync
#-----------------------------------------------------------
output "ssm_resource_data_sync_id" {
  description = "The ID of the ssm resource data sync"
  value       = element(concat(aws_ssm_resource_data_sync.ssm_resource_data_sync.*.id, [""]), 0)
}

#-----------------------------------------------------------
# AWS SSM window
#-----------------------------------------------------------
output "ssm_maintenance_window_id" {
  description = "The ID of the maintenance window."
  value       = element(concat(aws_ssm_maintenance_window.ssm_maintenance_window.*.id, [""]), 0)
}

#-----------------------------------------------------------
# AWS SSM window task
#-----------------------------------------------------------
output "ssm_maintenance_window_task_id" {
  description = "The ID of the maintenance window task."
  value       = element(concat(aws_ssm_maintenance_window_task.ssm_maintenance_window_task.*.id, [""]), 0)
}


#-----------------------------------------------------------
# AWS SSM window target
#-----------------------------------------------------------
output "ssm_maintenance_window_target_id" {
  description = "The ID of the maintenance window target."
  value       = element(concat(aws_ssm_maintenance_window_target.ssm_maintenance_window_target.*.id, [""]), 0)
}
