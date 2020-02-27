#---------------------------------------------------
# AWS MQ broker configuration
#---------------------------------------------------
output "mq_configuration_id" {
    description = "The unique ID that Amazon MQ generates for the configuration."
    value       = element(concat(aws_mq_configuration.mq_configuration.*.id, [""]), 0)
}

output "mq_configuration_arn" {
    description = "The ARN of the configuration."
    value       = element(concat(aws_mq_configuration.mq_configuration.*.arn, [""]), 0)
}

output "mq_configuration_latest_revision" {
    description = "The latest revision of the configuration."
    value       = element(concat(aws_mq_configuration.mq_configuration.*.latest_revision, [""]), 0)
}

#---------------------------------------------------
# AWS MQ broker
#---------------------------------------------------
output "mq_broker_id" {
    description = "The unique ID that Amazon MQ generates for the broker."
    value       = element(concat(aws_mq_broker.mq_broker.*.id, [""]), 0)
}

output "mq_broker_arn" {
    description = "The ARN of the broker."
    value       = element(concat(aws_mq_broker.mq_broker.*.arn, [""]), 0)
}

output "mq_broker_instances" {
    description = "A list of information about allocated brokers (both active & standby)."
    value       = concat(aws_mq_broker.mq_broker.*.instances, [""])
}
