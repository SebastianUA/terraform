#---------------------------------------------------
# Route53 zone
#---------------------------------------------------
output "aws_route53_zone_default_id" {
    description = "The Hosted Zone ID. This can be referenced by zone records."
    value       = "${element(concat(aws_route53_zone.route53_zone_default.*.id, list("")), 0)}"
}

output "aws_route53_zone_with_delegation_set_id_id" {
    description = ""
    value       = "${element(concat(aws_route53_zone.route53_zone_with_delegation_set.*.id, list("")), 0)}"
}

output "aws_route53_zone_with_vpc_id" {
    description = ""
    value       = "${element(concat(aws_route53_zone.route53_zone_with_vpc.*.id, list("")), 0)}"
}

#---------------------------------------------------
# Route53 record
#---------------------------------------------------
output "route53_record_default_name" {
    description = ""
    value       = "${element(concat(aws_route53_record.route53_record_default.*.name, list("")), 0)}"
}

output "route53_record_default_fqdn" {
    description = "FQDN built using the zone domain and name."
    value       = "${element(concat(aws_route53_record.route53_record_default.*.fqdn, list("")), 0)}"
}

output "route53_record_default_zone_ids" {
    description = ""
    value       = ["${aws_route53_record.route53_record_default.*.zone_id}"]
    #value       = "${join("", aws_route53_record.route53_record_default.*.zone_id)}"
}

output "route53_record_alias_name" {
    description = ""
    value       = "${element(concat(aws_route53_record.route53_record_alias.*.name, list("")), 0)}"
}

output "route53_record_alias_fqdn" {
    description = "FQDN built using the zone domain and name."
    value       = "${element(concat(aws_route53_record.route53_record_alias.*.name, list("")), 0)}"
}

output "route53_record_alias_zone_ids" {
    description = ""
    value       = ["${aws_route53_record.route53_record_alias.*.zone_id}"]
    #value       = "${join("", aws_route53_record.route53_record_alias.*.zone_id)}"
}

output "route53_record_weighted_routing_policy_name" {
    description = ""
    value       = "${element(concat(aws_route53_record.route53_record_weighted_routing_policy.*.name, list("")), 0)}"
}

output "route53_record_weighted_routing_policy_fqdn" {
    description = "FQDN built using the zone domain and name."
    value       = "${element(concat(aws_route53_record.route53_record_weighted_routing_policy.*.fqdn, list("")), 0)}"
}

output "route53_record_weighted_routing_policy_zone_ids" {
    description = ""
    value       = ["${aws_route53_record.route53_record_weighted_routing_policy.*.zone_id}"]
    #value       = "${join("", aws_route53_record.route53_record_weighted_routing_policy.*.zone_id)}"
}


#---------------------------------------------------
# Route53 delegation set
#---------------------------------------------------
output "route53_delegation_set_id" {
    description = "The delegation set ID"
    value       = "${element(concat(aws_route53_delegation_set.route53_delegation_set.*.id, list("")), 0)}"
}

output "route53_delegation_set_name_servers" {
    description = "A list of authoritative name servers for the hosted zone (effectively a list of NS records)."
    value       = "$aws_route53_delegation_set.route53_delegation_set.*.name_servers}"
}

#---------------------------------------------------
# Route53 zone association
#---------------------------------------------------
output "route53_zone_association_id" {
    description = ""
    value       = "${element(concat(aws_route53_zone_association.route53_zone_association.*.id, list("")), 0)}"
}

#---------------------------------------------------
# Route53 query log
#---------------------------------------------------
output "route53_query_log_id" {
    description = ""
    value       = "${element(concat(aws_route53_query_log.route53_query_log.*.id, list("")), 0)}"
}
