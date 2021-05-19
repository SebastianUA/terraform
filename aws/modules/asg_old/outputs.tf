#---------------------------------------------------
# Launch configuration
#---------------------------------------------------
output "this_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = element(concat(aws_launch_configuration.lc.*.id, aws_launch_configuration.lc_spot.*.id, aws_launch_configuration.lc_prefix.*.id, aws_launch_configuration.lc_spot_prefix.*.id, [""]), 0)
}

output "this_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = element(concat(aws_launch_configuration.lc.*.name, aws_launch_configuration.lc_spot.*.name, aws_launch_configuration.lc_prefix.*.name, aws_launch_configuration.lc_spot_prefix.*.name, [""]), 0)
}

output "this_launch_configuration_associate_public_ip_address" {
  description = "Whether a Public IP address is associated with the instance."
  value       = element(concat(aws_launch_configuration.lc.*.associate_public_ip_address, aws_launch_configuration.lc_spot.*.associate_public_ip_address, aws_launch_configuration.lc_prefix.*.associate_public_ip_address, aws_launch_configuration.lc_spot_prefix.*.associate_public_ip_address, [""]), 0)
}

output "this_launch_configuration_user_data" {
  description = "The User Data of the instance."
  value       = element(concat(aws_launch_configuration.lc.*.user_data, aws_launch_configuration.lc_spot.*.user_data, aws_launch_configuration.lc_prefix.*.user_data, aws_launch_configuration.lc_spot_prefix.*.user_data, [""]), 0)
}
#---------------------------------------------------
# Autoscaling group
#---------------------------------------------------
output "this_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = element(concat(aws_autoscaling_group.asg.*.id, aws_autoscaling_group.asg_prefix.*.id, aws_autoscaling_group.asg_azs.*.id, aws_autoscaling_group.asg_azs_prefix.*.id, [""]), 0)
}

output "this_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = element(concat(aws_autoscaling_group.asg.*.name, aws_autoscaling_group.asg_prefix.*.name, aws_autoscaling_group.asg_azs.*.name, aws_autoscaling_group.asg_azs_prefix.*.name, [""]), 0)
}

output "this_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = element(concat(aws_autoscaling_group.asg.*.arn, aws_autoscaling_group.asg_prefix.*.arn, aws_autoscaling_group.asg_azs.*.arn, aws_autoscaling_group.asg_azs_prefix.*.arn, [""]), 0)
}

output "this_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = element(concat(aws_autoscaling_group.asg.*.min_size, aws_autoscaling_group.asg_prefix.*.min_size, aws_autoscaling_group.asg_azs.*.min_size, aws_autoscaling_group.asg_azs_prefix.*.min_size, [""]), 0)
}

output "this_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = element(concat(aws_autoscaling_group.asg.*.max_size, aws_autoscaling_group.asg_prefix.*.max_size, aws_autoscaling_group.asg_azs.*.max_size, aws_autoscaling_group.asg_azs_prefix.*.max_size, [""]), 0)
}

output "this_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = element(concat(aws_autoscaling_group.asg.*.desired_capacity, aws_autoscaling_group.asg_prefix.*.desired_capacity, aws_autoscaling_group.asg_azs.*.desired_capacity, aws_autoscaling_group.asg_azs_prefix.*.desired_capacity, [""]), 0)
}

output "this_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = element(concat(aws_autoscaling_group.asg.*.default_cooldown, aws_autoscaling_group.asg_prefix.*.default_cooldown, aws_autoscaling_group.asg_azs.*.default_cooldown, aws_autoscaling_group.asg_azs_prefix.*.default_cooldown, [""]), 0)
}

output "this_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = element(concat(aws_autoscaling_group.asg.*.health_check_grace_period, aws_autoscaling_group.asg_prefix.*.health_check_grace_period, aws_autoscaling_group.asg_azs.*.health_check_grace_period, aws_autoscaling_group.asg_azs_prefix.*.health_check_grace_period, [""]), 0)
}

output "this_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = element(concat(aws_autoscaling_group.asg.*.health_check_type, aws_autoscaling_group.asg_prefix.*.health_check_type, aws_autoscaling_group.asg_azs.*.health_check_type, aws_autoscaling_group.asg_azs_prefix.*.health_check_type, [""]), 0)
}
