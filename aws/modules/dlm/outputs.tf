#---------------------------------------------------
# AWS DLM lifecycle_policy
#---------------------------------------------------
output "dlm_lifecycle_policy_id" {
    description = "Identifier of the DLM Lifecycle Policy."
    value       = element(concat(aws_dlm_lifecycle_policy.dlm_lifecycle_policy.*.id, [""], ), 0)
}

output "dlm_lifecycle_policy_arn" {
    description = "Amazon Resource Name (ARN) of the DLM Lifecycle Policy."
    value       = element(concat(aws_dlm_lifecycle_policy.dlm_lifecycle_policy.*.arn, [""], ), 0)
}
