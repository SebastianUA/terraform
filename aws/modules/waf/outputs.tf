output "waf_ipset_ids" {
    description = ""
    value       = "${aws_waf_ipset.waf_ipset.*.id}"
}

output "waf_rule_ids" {
    description = ""
    value       = "${aws_waf_rule.waf_rule.*.id}"
}

output "waf_rule_names" {
    description = ""
    value       = "${aws_waf_rule.waf_rule.*.name}"
}

output "waf_byte_match_set_ids" {
    description = ""    
    value       = "${aws_waf_byte_match_set.waf_byte_match_set.*.id}"
}

output "waf_rate_based_rule_ids" {
    description = ""
    value       = "${aws_waf_rate_based_rule.waf_rate_based_rule.*.id}"
}

output "size_constraint_set_ids" {
    description = ""
    value       = "${aws_waf_size_constraint_set.waf_size_constraint_set.*.id}"
}

output "sql_injection_match_set_ids" {
    description = ""
    value       = "${aws_waf_sql_injection_match_set.waf_sql_injection_match_set.*.id}"
}

output "waf_xss_match_set_ids" {
    description = ""
    value       = "${aws_waf_xss_match_set.waf_xss_match_set.*.id}"
}

output "waf_web_acl_ids" {
    description = ""
    value       = "${aws_waf_web_acl.waf_web_acl.*.id}"
}
