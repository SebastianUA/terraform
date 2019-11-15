#---------------------------------------
# AWS ECS cluster
#---------------------------------------
output "ecs_cluster_id" {
    description = "The Amazon Resource Name (ARN) that identifies the cluster"
    value       = "${aws_ecs_cluster.ecs_cluster.*.id}"
}

output "ecs_cluster_arn" {
    description = "The Amazon Resource Name (ARN) that identifies the cluster"
    value       = "${aws_ecs_cluster.ecs_cluster.*.arn}"
}

#---------------------------------------
# AWS ECS service
#---------------------------------------
output "ecs_service_id" {
    description = "The Amazon Resource Name (ARN) that identifies the service"
    value       = "${aws_ecs_service.ecs_service.*.id}"
}

output "ecs_service_name" {
    description = "The name of the service"
    value       = "${aws_ecs_service.ecs_service.*.name}"
}

output "ecs_service_cluster" {
    description = "The Amazon Resource Name (ARN) of cluster which the service runs on"
    value       = "${aws_ecs_service.ecs_service.*.cluster}"
}

output "ecs_service_iam_role" {
    description = "The ARN of IAM role used for ELB"
    value       = "${aws_ecs_service.ecs_service.*.iam_role}"
}

output "ecs_service_desired_count" {
    description = "The number of instances of the task definition"
    value       = "${aws_ecs_service.ecs_service.*.desired_count}"
}

#---------------------------------------
# AWS ECS  task definition
#---------------------------------------
output "ecs_task_definition_arn" {
    description = "Full ARN of the Task Definition (including both family and revision)."
    value       = "${aws_ecs_task_definition.ecs_task_definition.*.arn}"
}

output "ecs_task_definition_family" {
    description = "The family of the Task Definition."
    value       = "${aws_ecs_task_definition.ecs_task_definition.*.family}"
}

output "ecs_task_definition_revision" {
    description = "The revision of the task in a particular family."
    value       = "${aws_ecs_task_definition.ecs_task_definition.*.revision}"
}

 
