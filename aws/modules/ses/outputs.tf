#---------------------------------------------------
# AWS ses template
#---------------------------------------------------
output "ses_template_arn" {
  description = "The ARN of the SES template"
  value       = element(concat(aws_ses_template.ses_template.*.arn, [""]), 0)
}

output "ses_template_id" {
  description = "The name of the SES template"
  value       = element(concat(aws_ses_template.ses_template.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS ses receipt rule
#---------------------------------------------------
output "ses_receipt_rule_arn" {
  description = "The SES receipt rule ARN."
  value       = element(concat(aws_ses_receipt_rule.ses_receipt_rule.*.arn, [""]), 0)
}

output "ses_receipt_rule_id" {
  description = "The SES receipt rule name."
  value       = element(concat(aws_ses_receipt_rule.ses_receipt_rule.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS ses receipt rule set
#---------------------------------------------------
output "ses_receipt_rule_set_arn" {
  description = "SES receipt rule set ARN."
  value       = element(concat(aws_ses_receipt_rule_set.ses_receipt_rule_set.*.arn, [""]), 0)
}

output "ses_receipt_rule_set_id" {
  description = "SES receipt rule set name."
  value       = element(concat(aws_ses_receipt_rule_set.ses_receipt_rule_set.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS ses receipt filter
#---------------------------------------------------
output "ses_receipt_filter_arn" {
  description = "The SES receipt filter ARN."
  value       = element(concat(aws_ses_receipt_filter.ses_receipt_filter.*.arn, [""]), 0)
}

output "ses_receipt_filter_id" {
  description = "The SES receipt filter name."
  value       = element(concat(aws_ses_receipt_filter.ses_receipt_filter.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS ses active receipt rule set
#---------------------------------------------------
output "ses_active_receipt_rule_set_arn" {
  description = "The SES receipt rule set ARN."
  value       = element(concat(aws_ses_active_receipt_rule_set.ses_active_receipt_rule_set.*.arn, [""]), 0)
}

output "ses_active_receipt_rule_set_id" {
  description = "The SES receipt rule set name."
  value       = element(concat(aws_ses_active_receipt_rule_set.ses_active_receipt_rule_set.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS ses configuration set
#---------------------------------------------------
output "ses_configuration_set_arn" {
  description = "SES configuration set ARN."
  value       = element(concat(aws_ses_configuration_set.ses_configuration_set.*.arn, [""]), 0)
}

output "ses_configuration_set_id" {
  description = "SES configuration set name."
  value       = element(concat(aws_ses_configuration_set.ses_configuration_set.*.id, [""]), 0)
}

output "ses_configuration_set_last_fresh_start" {
  description = "The date and time at which the reputation metrics for the configuration set were last reset. Resetting these metrics is known as a fresh start."
  value       = element(concat(aws_ses_configuration_set.ses_configuration_set.*.last_fresh_start, [""]), 0)
}

#---------------------------------------------------
# AWS ses domain identity
#---------------------------------------------------
output "ses_domain_identity_id" {
  description = "SES domain identity id."
  value       = element(concat(aws_ses_domain_identity.ses_domain_identity.*.id, [""]), 0)
}

output "ses_domain_identity_arn" {
  description = "The ARN of the domain identity."
  value       = element(concat(aws_ses_domain_identity.ses_domain_identity.*.arn, [""]), 0)
}

output "ses_domain_identity_verification_token" {
  description = "A code which when added to the domain as a TXT record will signal to SES that the owner of the domain has authorised SES to act on their behalf. The domain identity will be in state 'verification pending' until this is done."
  value       = element(concat(aws_ses_domain_identity.ses_domain_identity.*.verification_token, [""]), 0)
}

#---------------------------------------------------
# AWS ses email identity
#---------------------------------------------------
output "ses_email_identity_id" {
  description = "SES email identity id."
  value       = element(concat(aws_ses_email_identity.ses_email_identity.*.id, [""]), 0)
}

output "ses_email_identity_arn" {
  description = "The ARN of the email identity."
  value       = element(concat(aws_ses_email_identity.ses_email_identity.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS ses identity policy
#---------------------------------------------------
output "ses_identity_policy_id" {
  description = "SES email identity policy id."
  value       = element(concat(aws_ses_identity_policy.ses_identity_policy.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS ses identity notification topic
#---------------------------------------------------
output "ses_identity_notification_topic_id" {
  description = "SES email identity notification topic id."
  value       = element(concat(aws_ses_identity_notification_topic.ses_identity_notification_topic.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS ses domain email from
#---------------------------------------------------
output "ses_domain_mail_from_id" {
  description = "The domain name."
  value       = element(concat(aws_ses_domain_mail_from.ses_domain_mail_from.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS ses domain identity verification
#---------------------------------------------------
output "ses_domain_identity_verification_id" {
  description = "The domain name of the domain identity."
  value       = element(concat(aws_ses_domain_identity_verification.ses_domain_identity_verification.*.id, [""]), 0)
}

output "ses_domain_identity_verification_arn" {
  description = "The ARN of the domain identity."
  value       = element(concat(aws_ses_domain_identity_verification.ses_domain_identity_verification.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS ses domain dkim
#---------------------------------------------------
output "ses_domain_dkim_id" {
  description = "The domain dkim id."
  value       = element(concat(aws_ses_domain_dkim.ses_domain_dkim.*.id, [""]), 0)
}

output "ses_domain_dkim_dkim_tokens" {
  description = "DKIM tokens generated by SES. These tokens should be used to create CNAME records used to verify SES Easy DKIM. See below for an example of how this might be achieved when the domain is hosted in Route 53 and managed by Terraform."
  value       = concat(aws_ses_domain_dkim.ses_domain_dkim.*.dkim_tokens, [""])
}

#---------------------------------------------------
# AWS ses event destination
#---------------------------------------------------
output "ses_event_destination_id" {
  description = "The SES event destination name."
  value       = element(concat(aws_ses_event_destination.ses_event_destination.*.id, [""]), 0)
}

output "ses_event_destination_arn" {
  description = "The SES event destination ARN."
  value       = element(concat(aws_ses_event_destination.ses_event_destination.*.arn, [""]), 0)
}
