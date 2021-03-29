#---------------------------------------------------
# AWS serverlessapplicationrepository cloudformation stack
#---------------------------------------------------
output "serverlessapplicationrepository_cloudformation_stack_id" {
  description = "A unique identifier of the stack."
  value       = element(concat(aws_serverlessapplicationrepository_cloudformation_stack.serverlessapplicationrepository_cloudformation_stack.*.id, [""]), 0)
}

output "serverlessapplicationrepository_cloudformation_stack_outputs" {
  description = "A map of outputs from the stack."
  value       = concat(aws_serverlessapplicationrepository_cloudformation_stack.serverlessapplicationrepository_cloudformation_stack.*.outputs, [""])
}
