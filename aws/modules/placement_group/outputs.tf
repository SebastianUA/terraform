#---------------------------------------------------
# Placement group
#---------------------------------------------------
output "placement_group_name" {
  description = "The name of the placement group."
  value       = element(concat(aws_placement_group.placement_group.*.id, [""]), 0)
}

output "placement_group_arn" {
  description = "Amazon Resource Name (ARN) of the placement group."
  value       = element(concat(aws_placement_group.placement_group.*.arn, [""]), 0)
}

output "placement_group_id" {
  description = "The ID of the placement group."
  value       = element(concat(aws_placement_group.placement_group.*.placement_group_id, [""]), 0)
}
