#---------------------------------------------------
# AWS config aggregate authorization
#---------------------------------------------------
output "config_aggregate_authorization_arn" {
  description = "The ARN of the authorization"
  value       = element(concat(aws_config_aggregate_authorization.config_aggregate_authorization.*.arn, [""], ), 0)
}

#---------------------------------------------------
# AWS config delivery channel
#---------------------------------------------------
output "config_delivery_channel_id" {
  description = "The name of the delivery channel."
  value       = element(concat(aws_config_delivery_channel.config_delivery_channel.*.id, [""], ), 0)
}

#---------------------------------------------------
# AWS config organization managed rule
#---------------------------------------------------
output "config_organization_managed_rule_arn" {
  description = "Amazon Resource Name (ARN) of the rule"
  value       = element(concat(aws_config_organization_managed_rule.config_organization_managed_rule.*.arn, [""], ), 0)
}

#---------------------------------------------------
# AWS config organization custom rule
#---------------------------------------------------
output "config_organization_custom_rule_arn" {
  description = "Amazon Resource Name (ARN) of the rule"
  value       = element(concat(aws_config_organization_custom_rule.config_organization_custom_rule.*.arn, [""], ), 0)
}

#---------------------------------------------------
# AWS config configuration recorder
#---------------------------------------------------
output "config_configuration_recorder_id" {
  description = "Name of the recorder"
  value       = element(concat(aws_config_configuration_recorder.config_configuration_recorder.*.id, [""], ), 0)
}

#---------------------------------------------------
# AWS config configuration aggregator
#---------------------------------------------------
output "config_configuration_aggregator_arn" {
  description = "The ARN of the aggregator"
  value       = element(concat(aws_config_configuration_aggregator.config_configuration_aggregator.*.arn, [""], ), 0)
}

#---------------------------------------------------
# AWS config config rule
#---------------------------------------------------
output "config_config_rule_arn" {
  description = "The ARN of the config rule"
  value       = element(concat(aws_config_config_rule.config_config_rule.*.arn, [""], ), 0)
}

output "config_config_rule_id" {
  description = "The ID of the config rule"
  value       = element(concat(aws_config_config_rule.config_config_rule.*.rule_id, [""], ), 0)
}

// #---------------------------------------------------
// # AWS config conformance pack
// #---------------------------------------------------
// output "config_conformance_pack_id" {
//   description = "The ID of the conformance pack"
//   value       = element(concat(aws_config_conformance_pack.config_conformance_pack.*.id, [""], ), 0)
// }

// output "config_conformance_pack_arn" {
//   description = "Amazon Resource Name (ARN) of the conformance pack."
//   value       = element(concat(aws_config_conformance_pack.config_conformance_pack.*.arn, [""], ), 0)
// }

#---------------------------------------------------
# AWS config remediation configuration
#---------------------------------------------------
output "config_remediation_configuration_id" {
  description = "The ID of the remediation configuration"
  value       = element(concat(aws_config_remediation_configuration.config_remediation_configuration.*.id, [""], ), 0)
}
