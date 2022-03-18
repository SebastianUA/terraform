#---------------------------------------------------
# Launch configuration
#---------------------------------------------------
output "launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = element(concat(aws_launch_configuration.lc.*.id, [""]), 0)
}

output "launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = element(concat(aws_launch_configuration.lc.*.name, [""]), 0)
}

output "launch_configuration_associate_public_ip_address" {
  description = "Whether a Public IP address is associated with the instance."
  value       = element(concat(aws_launch_configuration.lc.*.associate_public_ip_address, [""]), 0)
}

output "launch_configuration_user_data" {
  description = "The User Data of the instance."
  value       = element(concat(aws_launch_configuration.lc.*.user_data, [""]), 0)
}

#---------------------------------------------------
# Launch template
#---------------------------------------------------
output "launch_template_arn" {
  description = "Amazon Resource Name (ARN) of the launch template."
  value       = element(concat(aws_launch_template.lt.*.arn, [""]), 0)
}

output "launch_template_id" {
  description = "The ID of the launch template."
  value       = element(concat(aws_launch_template.lt.*.id, [""]), 0)
}

output "launch_template_latest_version" {
  description = "The latest version of the launch template."
  value       = element(concat(aws_launch_template.lt.*.latest_version, [""]), 0)
}

#---------------------------------------------------
# Autoscaling group
#---------------------------------------------------
output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = element(concat(aws_autoscaling_group.asg.*.id, [""]), 0)
}

output "autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = element(concat(aws_autoscaling_group.asg.*.name, [""]), 0)
}

output "autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = element(concat(aws_autoscaling_group.asg.*.arn, [""]), 0)
}

output "autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = element(concat(aws_autoscaling_group.asg.*.min_size, [""]), 0)
}

output "autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = element(concat(aws_autoscaling_group.asg.*.max_size, [""]), 0)
}

output "autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = element(concat(aws_autoscaling_group.asg.*.desired_capacity, [""]), 0)
}

output "autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = element(concat(aws_autoscaling_group.asg.*.default_cooldown, [""]), 0)
}

output "autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = element(concat(aws_autoscaling_group.asg.*.health_check_grace_period, [""]), 0)
}

output "autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = element(concat(aws_autoscaling_group.asg.*.health_check_type, [""]), 0)
}

#---------------------------------------------------
# AWS ASG tag
#---------------------------------------------------
output "asg_tag_id" {
  description = "ASG name and key, separated by a comma"
  value       = element(concat(aws_autoscaling_group_tag.asg_tag.*.id, [""]), 0)
}