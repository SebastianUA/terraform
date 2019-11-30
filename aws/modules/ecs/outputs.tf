#---------------------------------------
# AWS ECS cluster
#---------------------------------------
output "ecs_cluster_id" {
    description = "The Amazon Resource Name (ARN) that identifies the cluster"
    value       = element(concat(aws_ecs_cluster.ecs_cluster.*.id, [""]), 0)
}

output "ecs_cluster_arn" {
    description = "The Amazon Resource Name (ARN) that identifies the cluster"
    value       = element(concat(aws_ecs_cluster.ecs_cluster.*.arn, [""]), 0)
}

#---------------------------------------
# AWS ECS service
#---------------------------------------
output "ecs_service_id" {
    description = "The Amazon Resource Name (ARN) that identifies the service"
    value       = element(concat(aws_ecs_service.ecs_service.*.id, [""]), 0)
}

output "ecs_service_name" {
    description = "The name of the service"
    value       = element(concat(aws_ecs_service.ecs_service.*.name, [""]), 0)
}

output "ecs_service_cluster" {
    description = "The Amazon Resource Name (ARN) of cluster which the service runs on"
    value       = element(concat(aws_ecs_service.ecs_service.*.cluster, [""]), 0)
}

output "ecs_service_iam_role" {
    description = "The ARN of IAM role used for ELB"
    value       = element(concat(aws_ecs_service.ecs_service.*.iam_role, [""]), 0)
}

output "ecs_service_desired_count" {
    description = "The number of instances of the task definition"
    value       = element(concat(aws_ecs_service.ecs_service.*.desired_count, [""]), 0)
}

#---------------------------------------
# AWS ECS  task definition
#---------------------------------------
output "ecs_task_definition_arn" {
    description = "Full ARN of the Task Definition (including both family and revision)."
    value       = element(concat(aws_ecs_task_definition.ecs_task_definition.*.arn, [""]), 0)
}

output "ecs_task_definition_family" {
    description = "The family of the Task Definition."
    value       = element(concat(aws_ecs_task_definition.ecs_task_definition.*.family, [""]), 0)
}

output "ecs_task_definition_revision" {
    description = "The revision of the task in a particular family."
    value       = element(concat(aws_ecs_task_definition.ecs_task_definition.*.revision, [""]), 0)
}