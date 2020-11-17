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
# AWS wafregional ipset
#---------------------------------------------------


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
