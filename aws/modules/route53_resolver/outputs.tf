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

#---------------------------------------------------
# AWS route53 resolver dnssec config
#---------------------------------------------------
output "route53_resolver_dnssec_config_id" {
  description = "The ID for a configuration for DNSSEC validation."
  value       = element(concat(aws_route53_resolver_dnssec_config.route53_resolver_dnssec_config.*.id, [""]), 0)
}

output "route53_resolver_dnssec_config_arn" {
  description = "The ARN for a configuration for DNSSEC validation."
  value       = element(concat(aws_route53_resolver_dnssec_config.route53_resolver_dnssec_config.*.arn, [""]), 0)
}

output "route53_resolver_dnssec_config_owner_id" {
  description = "The owner account ID of the virtual private cloud (VPC) for a configuration for DNSSEC validation."
  value       = element(concat(aws_route53_resolver_dnssec_config.route53_resolver_dnssec_config.*.owner_id, [""]), 0)
}

output "route53_resolver_dnssec_config_validation_status" {
  description = "The validation status for a DNSSEC configuration. The status can be one of the following: ENABLING, ENABLED, DISABLING and DISABLED."
  value       = element(concat(aws_route53_resolver_dnssec_config.route53_resolver_dnssec_config.*.validation_status, [""]), 0)
}

#---------------------------------------------------
# AWS route53 resolver query log config
#---------------------------------------------------
output "route53_resolver_query_log_config_id" {
  description = "The ID of the Route 53 Resolver query logging configuration."
  value       = element(concat(aws_route53_resolver_query_log_config.route53_resolver_query_log_config.*.id, [""]), 0)
}

output "route53_resolver_query_log_config_arn" {
  description = "The ARN (Amazon Resource Name) of the Route 53 Resolver query logging configuration."
  value       = element(concat(aws_route53_resolver_query_log_config.route53_resolver_query_log_config.*.arn, [""]), 0)
}

output "route53_resolver_query_log_config_owner_id" {
  description = "The AWS account ID of the account that created the query logging configuration."
  value       = element(concat(aws_route53_resolver_query_log_config.route53_resolver_query_log_config.*.owner_id, [""]), 0)
}

output "route53_resolver_query_log_config_share_status" {
  description = "An indication of whether the query logging configuration is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Values are NOT_SHARED, SHARED_BY_ME or SHARED_WITH_ME"
  value       = element(concat(aws_route53_resolver_query_log_config.route53_resolver_query_log_config.*.share_status, [""]), 0)
}

#---------------------------------------------------
# AWS route53 resolver query log config association
#---------------------------------------------------
output "route53_resolver_query_log_config_association_id" {
  description = "The ID of the Route 53 Resolver query logging configuration association."
  value       = element(concat(aws_route53_resolver_query_log_config_association.route53_resolver_query_log_config_association.*.id, [""]), 0)
}