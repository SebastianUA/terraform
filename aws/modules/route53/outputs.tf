#---------------------------------------------------
# Route53 zone
#---------------------------------------------------
output "aws_route53_zone_id" {
  description = "The Hosted Zone ID. This can be referenced by zone records."
  value       = element(concat(aws_route53_zone.route53_zone.*.id, [""]), 0)
}

output "aws_route53_zone_zone_id" {
  description = "The Hosted Zone ID. This can be referenced by zone records."
  value       = element(concat(aws_route53_zone.route53_zone.*.zone_id, [""]), 0)
}

output "aws_route53_zone_name_servers" {
  description = "A list of name servers in associated (or default) delegation set. Find more about delegation sets in AWS docs."
  value       = concat(aws_route53_zone.route53_zone.*.name_servers, [""])
}

#---------------------------------------------------
# Route53 record
#---------------------------------------------------
output "route53_record_name" {
  description = "Get route53 record name"
  value       = element(concat(aws_route53_record.route53_record.*.name, [""]), 0)
}

output "route53_record_fqdn" {
  description = "FQDN built using the zone domain and name."
  value       = element(concat(aws_route53_record.route53_record.*.fqdn, [""]), 0)
}

#---------------------------------------------------
# Route53 delegation set
#---------------------------------------------------
output "route53_delegation_set_id" {
  description = "The delegation set ID"
  value       = element(concat(aws_route53_delegation_set.route53_delegation_set.*.id, [""]), 0)
}

output "route53_delegation_set_name_servers" {
  description = "A list of authoritative name servers for the hosted zone (effectively a list of NS records)."
  value       = concat(aws_route53_delegation_set.route53_delegation_set.*.name_servers, [""])
}

#---------------------------------------------------
# Route53 zone association
#---------------------------------------------------
output "route53_zone_association_id" {
  description = "The calculated unique identifier for the association."
  value       = element(concat(aws_route53_zone_association.route53_zone_association.*.id, [""]), 0)
}

output "route53_zone_association_zone_id" {
  description = "The ID of the hosted zone for the association."
  value       = element(concat(aws_route53_zone_association.route53_zone_association.*.zone_id, [""]), 0)
}

output "route53_zone_association_vpc_id" {
  description = "The ID of the VPC for the association."
  value       = element(concat(aws_route53_zone_association.route53_zone_association.*.vpc_id, [""]), 0)
}

output "route53_zone_association_vpc_region" {
  description = "The region in which the VPC identified by vpc_id was created."
  value       = element(concat(aws_route53_zone_association.route53_zone_association.*.vpc_region, [""]), 0)
}

#---------------------------------------------------
# Route53 query log
#---------------------------------------------------
output "route53_query_log_id" {
  description = "The query logging configuration ID"
  value       = element(concat(aws_route53_query_log.route53_query_log.*.id, [""]), 0)
}

#---------------------------------------------------
# Route53 query log
#---------------------------------------------------
output "route53_health_check_id" {
  description = "The query logging configuration ID"
  value       = element(concat(aws_route53_health_check.route53_health_check.*.id, [""]), 0)
}

#---------------------------------------------------
# Route53 resolver endpoint
#---------------------------------------------------
output "route53_resolver_endpoint_id" {
  description = "The ID of the Route 53 Resolver endpoint."
  value       = element(concat(aws_route53_resolver_endpoint.route53_resolver_endpoint.*.id, [""]), 0)
}

output "route53_resolver_endpoint_arn" {
  description = "The ARN of the Route 53 Resolver endpoint."
  value       = element(concat(aws_route53_resolver_endpoint.route53_resolver_endpoint.*.arn, [""]), 0)
}

output "route53_resolver_endpoint_host_vpc_id" {
  description = "The ID of the VPC that you want to create the resolver endpoint in."
  value       = element(concat(aws_route53_resolver_endpoint.route53_resolver_endpoint.*.host_vpc_id, [""]), 0)
}

#---------------------------------------------------
# Route53 resolver rule association
#---------------------------------------------------
output "route53_resolver_rule_association_id" {
  description = "The ID of the resolver rule association."
  value       = element(concat(aws_route53_resolver_rule_association.route53_resolver_rule_association.*.id, [""]), 0)
}

#---------------------------------------------------
# Route53 resolver rule
#---------------------------------------------------
output "route53_resolver_rule_id" {
  description = "The ID of the resolver rule."
  value       = element(concat(aws_route53_resolver_rule.route53_resolver_rule.*.id, [""]), 0)
}

output "route53_resolver_rule_arn" {
  description = "The ARN (Amazon Resource Name) for the resolver rule."
  value       = element(concat(aws_route53_resolver_rule.route53_resolver_rule.*.arn, [""]), 0)
}

output "route53_resolver_rule_owner_id" {
  description = "When a rule is shared with another AWS account, the account ID of the account that the rule is shared with."
  value       = element(concat(aws_route53_resolver_rule.route53_resolver_rule.*.owner_id, [""]), 0)
}

output "route53_resolver_rule_share_status" {
  description = "Whether the rules is shared and, if so, whether the current account is sharing the rule with another account, or another account is sharing the rule with the current account. Values are NOT_SHARED, SHARED_BY_ME or SHARED_WITH_ME"
  value       = element(concat(aws_route53_resolver_rule.route53_resolver_rule.*.share_status, [""]), 0)
}
