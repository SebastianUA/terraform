output "rds_ids" {
    value = "${aws_db_instance.db_instance.*.id}"
}

output "rds_arns" {
    value = "${aws_db_instance.db_instance.*.arn}"
}

output "rds_addresses" {
    value = "${aws_db_instance.db_instance.*.address}"
}

output "endpoints" {
    value = "${aws_rds_cluster.rds_cluster.*.endpoint}"
}

output "reader_endpoints" {
    value = "${aws_rds_cluster.rds_cluster.*.reader_endpoint}"
}

output "aws_db_subnet_group_ids" {
    value = "${aws_db_subnet_group.db_subnet_group.*.id}"
}

output "db_parameter_groups" {
    value = "aws_db_parameter_group.db_parameter_group.*.id"
}

output "hosted_zone_ids" {
    value = "${aws_db_instance.db_instance.*.hosted_zone_id}"
}
