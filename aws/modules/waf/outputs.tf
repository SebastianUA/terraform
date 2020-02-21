#---------------------------------------------------
# AWS WAF ipset
#---------------------------------------------------
output "waf_ipset_id" {
    description = "The ID of the WAF IPSet."
    value       = element(concat(aws_waf_ipset.waf_ipset.*.id, [""]), 0)
}

output "waf_ipset_arn" {
    description = "The ARN of the WAF IPSet."
    value       = element(concat(aws_waf_ipset.waf_ipset.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS WAF rule
#---------------------------------------------------
output "waf_rule_id" {
    description = "The ID of the WAF rule."
    value       = element(concat(aws_waf_rule.waf_rule.*.id, [""]), 0)
}

output "waf_rule_arn" {
    description = "The ARN of the WAF rule."
    value       = element(concat(aws_waf_rule.waf_rule.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS WAF rule group
#---------------------------------------------------
output "waf_rule_group_id" {
    description = "The ID of the WAF rule group."
    value       = element(concat(aws_waf_rule_group.waf_rule_group.*.id, [""]), 0)
}

output "waf_rule_group_arn" {
    description = "The ARN of the WAF rule group."
    value       = element(concat(aws_waf_rule_group.waf_rule_group.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS WAF web acl
#---------------------------------------------------
output "waf_web_acl_id" {
    description = "The ID of the WAF WebACL."
    value       = element(concat(aws_waf_web_acl.waf_web_acl.*.id, [""]), 0)
}

output "waf_web_acl_arn" {
    description = "The ARN of the WAF WebACL."
    value       = element(concat(aws_waf_web_acl.waf_web_acl.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS WAF rate based rule
#---------------------------------------------------
output "waf_rate_based_rule_id" {
    description = "The ID of the WAF rule."
    value       = element(concat(aws_waf_rate_based_rule.waf_rate_based_rule.*.id, [""]), 0)
}

output "waf_rate_based_rule_arn" {
    description = "Amazon Resource Name (ARN)"
    value       = element(concat(aws_waf_rate_based_rule.waf_rate_based_rule.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS WAF byte match set
#---------------------------------------------------
output "waf_byte_match_set_id" {
    description = "The ID of the WAF Byte Match Set."
    value       = element(concat(aws_waf_byte_match_set.waf_byte_match_set.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS WAF geo match set
#---------------------------------------------------
output "waf_geo_match_set_id" {
    description = "The ID of the WAF rule."
    value       = element(concat(aws_waf_geo_match_set.waf_geo_match_set.*.id, [""]), 0)
}

output "waf_geo_match_set_arn" {
    description = "Amazon Resource Name (ARN)"
    value       = element(concat(aws_waf_geo_match_set.waf_geo_match_set.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS WAF regex match set
#---------------------------------------------------
output "waf_regex_match_set_id" {
    description = "The ID of the WAF Regex Match Set."
    value       = element(concat(aws_waf_regex_match_set.waf_regex_match_set.*.id, [""]), 0)
}

output "waf_regex_match_set_arn" {
    description = "Amazon Resource Name (ARN)"
    value       = element(concat(aws_waf_regex_match_set.waf_regex_match_set.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS WAF regex pattern set
#---------------------------------------------------
output "waf_regex_pattern_set_id" {
    description = "The ID of the WAF Regex Pattern Set."
    value       = element(concat(aws_waf_regex_pattern_set.waf_regex_pattern_set.*.id, [""]), 0)
}

output "waf_regex_pattern_set_arn" {
    description = "Amazon Resource Name (ARN)"
    value       = element(concat(aws_waf_regex_pattern_set.waf_regex_pattern_set.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS WAF size constraint set 
#---------------------------------------------------
output "waf_size_constraint_set_id" {
    description = "The ID of the WAF Size Constraint Set."
    value       = element(concat(aws_waf_size_constraint_set.waf_size_constraint_set.*.id, [""]), 0)
}

output "waf_size_constraint_set_arn" {
    description = "Amazon Resource Name (ARN)"
    value       = element(concat(aws_waf_size_constraint_set.waf_size_constraint_set.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS WAF sql injection match set
#---------------------------------------------------
output "waf_sql_injection_match_set_id" {
    description = "The ID of the WAF SQL Injection Match Set."
    value       = element(concat(aws_waf_sql_injection_match_set.waf_sql_injection_match_set.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS WAF xss match set
#---------------------------------------------------
output "waf_xss_match_set_id" {
    description = "The ID of the WAF XssMatchSet."
    value       = element(concat(aws_waf_xss_match_set.waf_xss_match_set.*.id, [""]), 0)
}

output "waf_xss_match_set_arn" {
    description = "Amazon Resource Name (ARN)"
    value       = element(concat(aws_waf_xss_match_set.waf_xss_match_set.*.id, [""]), 0)
}