#---------------------------------------------------
# AWS elasticsearch domain
#---------------------------------------------------
output "elasticsearch_domain_id" {
  description = "ID of elasticsearch domain policy"
  value       = element(concat(aws_elasticsearch_domain.elasticsearch_domain.*.id, [""]), 0)
}

output "elasticsearch_domain_arn" {
  description = "Amazon Resource Name (ARN) of the domain."
  value       = element(concat(aws_elasticsearch_domain.elasticsearch_domain.*.arn, [""]), 0)
}

output "elasticsearch_domain_domain_id" {
  description = "Unique identifier for the domain."
  value       = element(concat(aws_elasticsearch_domain.elasticsearch_domain.*.domain_id, [""]), 0)
}

output "elasticsearch_domain_domain_name" {
  description = "The name of the Elasticsearch domain."
  value       = element(concat(aws_elasticsearch_domain.elasticsearch_domain.*.domain_name, [""]), 0)
}

output "elasticsearch_domain_endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests."
  value       = element(concat(aws_elasticsearch_domain.elasticsearch_domain.*.endpoint, [""]), 0)
}

output "elasticsearch_domain_kibana_endpoint" {
  description = "Domain-specific endpoint for kibana without https scheme."
  value       = element(concat(aws_elasticsearch_domain.elasticsearch_domain.*.kibana_endpoint, [""]), 0)
}

output "elasticsearch_domain_vpc_options" {
  description = "Domain-specific endpoint for kibana without https scheme."
  value       = concat(aws_elasticsearch_domain.elasticsearch_domain.*.vpc_options, [""])
}

#---------------------------------------------------
# AWS elasticsearch domain policy
#---------------------------------------------------
output "elasticsearch_domain_policy_id" {
  description = "ID of elasticsearch domain policy"
  value       = element(concat(aws_elasticsearch_domain_policy.elasticsearch_domain_policy.*.id, [""]), 0)
}