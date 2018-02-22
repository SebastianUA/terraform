output "mq_broker_ids" {
    description = ""
    value       = "${aws_mq_broker.mq_broker.*.id}"
}

output "mq_broker_arns" {
    description = ""
    value       = "${aws_mq_broker.mq_broker.*.arn}"
}

output "mq_broker_instances" {
    description = ""
    value       = "${aws_mq_broker.mq_broker.*.instances}"
}

output "mq_configuration_ids" {
    description = ""
    value       = "${aws_mq_configuration.mq_configuration.*.id}"
}

output "mq_configuration_arns" {
    description = ""
    value       = "${aws_mq_configuration.mq_configuration.*.arn}"
}

output "mq_configuration_latest_revision" {
    description = ""
    value       = "${aws_mq_configuration.mq_configuration.*.latest_revision}"
}
