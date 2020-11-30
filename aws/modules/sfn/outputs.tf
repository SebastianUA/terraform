#---------------------------------------------------
# AWS sfn activity
#---------------------------------------------------
output "sfn_activity_id" {
  description = "The Amazon Resource Name (ARN) that identifies the created activity."
  value       = element(concat(aws_sfn_activity.sfn_activity.*.id, [""]), 0)
}

output "sfn_activity_name" {
  description = "The name of the activity."
  value       = element(concat(aws_sfn_activity.sfn_activity.*.name, [""]), 0)
}

output "sfn_activity_creation_date" {
  description = "The date the activity was created."
  value       = element(concat(aws_sfn_activity.sfn_activity.*.creation_date, [""]), 0)
}

#---------------------------------------------------
# AWS sfn state machine
#---------------------------------------------------
output "sfn_state_machine_id" {
  description = "The ARN of the state machine."
  value       = element(concat(aws_sfn_state_machine.sfn_state_machine.*.id, [""]), 0)
}

output "sfn_state_machine_creation_date" {
  description = "The date the state machine was created."
  value       = element(concat(aws_sfn_state_machine.sfn_state_machine.*.creation_date, [""]), 0)
}

output "sfn_state_machine_status" {
  description = "The current status of the state machine. Either 'ACTIVE' or 'DELETING'."
  value       = element(concat(aws_sfn_state_machine.sfn_state_machine.*.status, [""]), 0)
}

output "sfn_state_machine_arn" {
  description = "The ARN of the state machine."
  value       = element(concat(aws_sfn_state_machine.sfn_state_machine.*.arn, [""]), 0)
}
