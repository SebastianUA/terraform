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
# AWS route53 vpc association authorization
#---------------------------------------------------
output "route53_vpc_association_authorization_id" {
  description = "The calculated unique identifier for the association."
  value       = element(concat(aws_route53_vpc_association_authorization.route53_vpc_association_authorization.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Route53 key signing key
#---------------------------------------------------
output "route53_key_signing_key_id" {
  description = "Route 53 Hosted Zone identifier and KMS Key identifier, separated by a comma (,)."
  value       = element(concat(aws_route53_key_signing_key.route53_key_signing_key.*.id, [""]), 0)
}

output "route53_key_signing_key_digest_algorithm_mnemonic" {
  description = "A string used to represent the delegation signer digest algorithm. This value must follow the guidelines provided by RFC-8624 Section 3.3."
  value       = element(concat(aws_route53_key_signing_key.route53_key_signing_key.*.digest_algorithm_mnemonic, [""]), 0)
}

output "route53_key_signing_key_digest_algorithm_type" {
  description = "An integer used to represent the delegation signer digest algorithm. This value must follow the guidelines provided by RFC-8624 Section 3.3."
  value       = element(concat(aws_route53_key_signing_key.route53_key_signing_key.*.digest_algorithm_type, [""]), 0)
}

output "route53_key_signing_key_digest_value" {
  description = "A cryptographic digest of a DNSKEY resource record (RR). DNSKEY records are used to publish the public key that resolvers can use to verify DNSSEC signatures that are used to secure certain kinds of information provided by the DNS system."
  value       = element(concat(aws_route53_key_signing_key.route53_key_signing_key.*.digest_value, [""]), 0)
}

output "route53_key_signing_key_dnskey_record" {
  description = "A string that represents a DNSKEY record."
  value       = element(concat(aws_route53_key_signing_key.route53_key_signing_key.*.dnskey_record, [""]), 0)
}

output "route53_key_signing_key_ds_record" {
  description = "A string that represents a delegation signer (DS) record."
  value       = element(concat(aws_route53_key_signing_key.route53_key_signing_key.*.ds_record, [""]), 0)
}

output "route53_key_signing_key_flag" {
  description = "An integer that specifies how the key is used. For key-signing key (KSK), this value is always 257."
  value       = element(concat(aws_route53_key_signing_key.route53_key_signing_key.*.flag, [""]), 0)
}

output "route53_key_signing_key_key_tag" {
  description = "An integer used to identify the DNSSEC record for the domain name. The process used to calculate the value is described in RFC-4034 Appendix B."
  value       = element(concat(aws_route53_key_signing_key.route53_key_signing_key.*.key_tag, [""]), 0)
}

output "route53_key_signing_key_public_key" {
  description = "The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5."
  value       = element(concat(aws_route53_key_signing_key.route53_key_signing_key.*.public_key, [""]), 0)
}

output "route53_key_signing_key_signing_algorithm_mnemonic" {
  description = "A string used to represent the signing algorithm. This value must follow the guidelines provided by RFC-8624 Section 3.1."
  value       = element(concat(aws_route53_key_signing_key.route53_key_signing_key.*.signing_algorithm_mnemonic, [""]), 0)
}

output "route53_key_signing_key_signing_algorithm_type" {
  description = "An integer used to represent the signing algorithm. This value must follow the guidelines provided by RFC-8624 Section 3.1."
  value       = element(concat(aws_route53_key_signing_key.route53_key_signing_key.*.signing_algorithm_type, [""]), 0)
}