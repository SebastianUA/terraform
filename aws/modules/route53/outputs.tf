output "hostnames" {
    #value = "${aws_route53_record.route53_record.*.fqdn}"
    value = "${join("", aws_route53_record.route53_record.*.fqdn)}"
}
output "parent_zone_id" {
    #value = "${aws_route53_record.aws_route53_zone.primary_public.*.zone_id}"
    value = "${join("", aws_route53_record.route53_record.*.zone_id)}"
}
output "parent_zone_name" {
    value = "${join("", aws_route53_record.route53_record.*.name)}"
}
