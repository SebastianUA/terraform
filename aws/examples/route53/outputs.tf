#---------------------------------------------------
# Route53 zone
#---------------------------------------------------
output "route53_zone_id" {
    description = "The Hosted Zone ID. This can be referenced by zone records."
    value       = "${module.route53.aws_route53_zone_default_id}"
}

