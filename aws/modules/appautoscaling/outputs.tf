#---------------------------------------------------
# AWS appautoscaling target
#---------------------------------------------------
output "appautoscaling_target_id" {
    description = "The ID for appautoscaling target"
    value       = element(concat(aws_appautoscaling_target.appautoscaling_target.*.id, [""]), 0)
}

# output "appautoscaling_target_arn" {
#     description = "The ARN for appautoscaling target"
#     value       = element(concat(aws_appautoscaling_target.appautoscaling_target.*.arn, [""]), 0)
# }

#---------------------------------------------------
# AWS appautoscaling policy
#---------------------------------------------------
output "appautoscaling_policy_id" {
    description = "The ID for appautoscaling policy"
    value       = element(concat(aws_appautoscaling_policy.appautoscaling_policy.*.id, [""]), 0)
}

output "appautoscaling_policy_arn" {
    description = "The ARN assigned by AWS to the scaling policy."
    value       = element(concat(aws_appautoscaling_policy.appautoscaling_policy.*.arn, [""]), 0)
}

output "appautoscaling_policy_name" {
    description = "The scaling policy's name."
    value       = element(concat(aws_appautoscaling_policy.appautoscaling_policy.*.name, [""]), 0)
}

output "appautoscaling_policy_policy_type" {
    description = "The scaling policy's type."
    value       = element(concat(aws_appautoscaling_policy.appautoscaling_policy.*.policy_type, [""]), 0)
}

#---------------------------------------------------
# AWS appautoscaling scheduled action
#---------------------------------------------------
output "appautoscaling_scheduled_action_id" {
    description = "The ID for appautoscaling scheduled action"
    value       = element(concat(aws_appautoscaling_scheduled_action.appautoscaling_scheduled_action.*.id, [""]), 0)
}

output "appautoscaling_scheduled_action_arn" {
    description = "The Amazon Resource Name (ARN) of the scheduled action."
    value       = element(concat(aws_appautoscaling_scheduled_action.appautoscaling_scheduled_action.*.arn, [""]), 0)
}
