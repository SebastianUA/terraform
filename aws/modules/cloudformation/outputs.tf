#---------------------------------------------------
# AWS cloudformation
#---------------------------------------------------
output "cloudformation_stack_id" {
  description = "A unique identifier of the stack."
  value       = element(concat(aws_cloudformation_stack.cloudformation_stack.*.id, [""]), 0)
}

output "cloudformation_stack_outputs" {
  description = "A map of outputs from the stack."
  value       = concat(aws_cloudformation_stack.cloudformation_stack.*.outputs, [""])
}

#---------------------------------------------------
# AWS cloudformation stack set
#---------------------------------------------------
output "cloudformation_stack_set_id" {
  description = "Name of the Stack Set."
  value       = element(concat(aws_cloudformation_stack_set.cloudformation_stack_set.*.id, [""]), 0)
}

output "cloudformation_stack_set_arn" {
  description = "Amazon Resource Name (ARN) of the Stack Set."
  value       = element(concat(aws_cloudformation_stack_set.cloudformation_stack_set.*.arn, [""]), 0)
}

output "cloudformation_stack_set_stack_set_id" {
  description = "Unique identifier of the Stack Set."
  value       = element(concat(aws_cloudformation_stack_set.cloudformation_stack_set.*.stack_set_id, [""]), 0)
}

#---------------------------------------------------
# AWS cloudformation stack set instance
#---------------------------------------------------
output "cloudformation_stack_set_instance_id" {
  description = "Stack Set name, target AWS account ID, and target AWS region separated by commas (,)"
  value       = element(concat(aws_cloudformation_stack_set_instance.cloudformation_stack_set_instance.*.id, [""]), 0)
}

output "cloudformation_stack_set_instance_stack_id" {
  description = "Stack identifier"
  value       = element(concat(aws_cloudformation_stack_set_instance.cloudformation_stack_set_instance.*.stack_id, [""]), 0)
}
