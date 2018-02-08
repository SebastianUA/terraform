output "hostnames" {
    value = "${join("", aws_route53_record.route53_record.*.fqdn)}"
}

output "parent_zone_ids" {
    value = "${join("", aws_route53_record.route53_record.*.zone_id)}"
}

output "parent_zone_names" {
    value = "${join("", aws_route53_record.route53_record.*.name)}"
}
