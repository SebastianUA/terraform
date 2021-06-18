#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

#---------------------------------------------------
# AWS ses template
#---------------------------------------------------
variable "enable_ses_template" {
  description = "Set enable ses template usage"
  default     = false
}

variable "ses_template_name" {
  description = "The name of the template. Cannot exceed 64 characters. You will refer to this name when you send email."
  default     = ""
}

variable "ses_template_subject" {
  description = "(Optional) The subject line of the email."
  default     = null
}

variable "ses_template_html" {
  description = "(Optional) The HTML body of the email. Must be less than 500KB in size, including both the text and HTML parts."
  default     = null
}

variable "ses_template_text" {
  description = "(Optional) The email body that will be visible to recipients whose email clients do not display HTML. Must be less than 500KB in size, including both the text and HTML parts."
  default     = null
}

#---------------------------------------------------
# AWS ses receipt rule
#---------------------------------------------------
variable "enable_ses_receipt_rule" {
  description = "Enable ses receipt rule usage"
  default     = false
}

variable "ses_receipt_rule_name" {
  description = "The name of the rule"
  default     = ""
}

variable "ses_receipt_rule_rule_set_name" {
  description = "The name of the rule set"
  default     = ""
}

variable "ses_receipt_rule_recipients" {
  description = "(Optional) A list of email addresses"
  default     = null
}

variable "ses_receipt_rule_enabled" {
  description = "(Optional) If true, the rule will be enabled"
  default     = null
}

variable "ses_receipt_rule_scan_enabled" {
  description = "(Optional) If true, incoming emails will be scanned for spam and viruses"
  default     = null
}

variable "ses_receipt_rule_after" {
  description = "(Optional) The name of the rule to place this rule after"
  default     = null
}

variable "ses_receipt_rule_tls_policy" {
  description = "(Optional) Require or Optional"
  default     = null
}

variable "ses_receipt_rule_add_header_action" {
  description = "(Optional) A list of Add Header Action blocks. "
  default     = []
}

variable "ses_receipt_rule_bounce_action" {
  description = "(Optional) A list of Bounce Action blocks."
  default     = []
}

variable "ses_receipt_rule_lambda_action" {
  description = "(Optional) A list of Lambda Action blocks."
  default     = []
}

variable "ses_receipt_rule_s3_action" {
  description = "(Optional) A list of S3 Action blocks."
  default     = []
}

variable "ses_receipt_rule_sns_action" {
  description = "(Optional) A list of SNS Action blocks."
  default     = []
}

variable "ses_receipt_rule_stop_action" {
  description = "(Optional) A list of Stop Action blocks"
  default     = []
}

variable "ses_receipt_rule_workmail_action" {
  description = "(Optional) A list of WorkMail Action blocks."
  default     = []
}

#---------------------------------------------------
# AWS ses receipt rule set
#---------------------------------------------------
variable "enable_ses_receipt_rule_set" {
  description = "Enable ses receipt rule set usage"
  default     = false
}

variable "ses_receipt_rule_set_rule_set_name" {
  description = "Name of the rule set."
  default     = ""
}

#---------------------------------------------------
# AWS ses receipt filter
#---------------------------------------------------
variable "enable_ses_receipt_filter" {
  description = "Enable ses receipt filter usage"
  default     = false
}

variable "ses_receipt_filter_stack" {
  description = "The stack of ses receipt filter"
  default     = []
}

#---------------------------------------------------
# AWS ses active receipt rule set
#---------------------------------------------------
variable "enable_ses_active_receipt_rule_set" {
  description = "Enable ses active receipt rule set usage"
  default     = false
}

variable "ses_active_receipt_rule_set_rule_set_name" {
  description = "(Required) The name of the rule set"
  default     = ""
}

#---------------------------------------------------
# AWS ses configuration set
#---------------------------------------------------
variable "enable_ses_configuration_set" {
  description = "Enable ses configuration set usage"
  default     = false
}

variable "ses_configuration_set_name" {
  description = "Name of the configuration set."
  default     = ""
}

variable "ses_configuration_set_reputation_metrics_enabled" {
  description = "(Optional) Whether or not Amazon SES publishes reputation metrics for the configuration set, such as bounce and complaint rates, to Amazon CloudWatch. The default value is false"
  default     = null
}

variable "ses_configuration_set_delivery_options" {
  description = "(Optional) Configuration block."
  default     = {}
}

variable "ses_configuration_set_sending_enabled" {
  description = "(Optional) Whether email sending is enabled or disabled for the configuration set. The default value is true."
  default     = null
}

#---------------------------------------------------
# AWS ses domain identity
#---------------------------------------------------
variable "enable_ses_domain_identity" {
  description = "Enable ses domain identity usage"
  default     = false
}

variable "ses_domain_identity_domains" {
  description = "Set list of domains for ses domain identity"
  default     = []
}

#---------------------------------------------------
# AWS ses email identity
#---------------------------------------------------
variable "enable_ses_email_identity" {
  description = "Enable ses email identity usage"
  default     = false
}

variable "ses_email_identity_emails" {
  description = "Set list of emails for ses email identity"
  default     = []
}

#---------------------------------------------------
# AWS ses identity policy
#---------------------------------------------------
variable "enable_ses_identity_policy" {
  description = "Enable ses identity policy usage"
  default     = false
}

variable "ses_identity_policy_name" {
  description = "Name of the policy."
  default     = ""
}

variable "ses_identity_policy_identity" {
  description = "Name or Amazon Resource Name (ARN) of the SES Identity."
  default     = ""
}

variable "ses_identity_policy_policy" {
  description = "(Required) JSON string of the policy. For more information about building AWS IAM policy documents with Terraform"
  default     = null
}

#---------------------------------------------------
# AWS ses identity notification topic
#---------------------------------------------------
variable "enable_ses_identity_notification_topic" {
  description = "Enable ses identity notification topic usage"
  default     = false
}

variable "ses_identity_notification_topic_notification_type" {
  description = "(Required) The type of notifications that will be published to the specified Amazon SNS topic. Valid Values: Bounce, Complaint or Delivery."
  default     = null
}

variable "ses_identity_notification_topic_identity" {
  description = "The identity for which the Amazon SNS topic will be set. You can specify an identity by using its name or by using its Amazon Resource Name (ARN)."
  default     = ""
}

variable "ses_identity_notification_topic_topic_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the Amazon SNS topic. Can be set to '' (an empty string) to disable publishing."
  default     = null
}

variable "ses_identity_notification_topic_include_original_headers" {
  description = "(Optional) Whether SES should include original email headers in SNS notifications of this type. false by default."
  default     = null
}

#---------------------------------------------------
# AWS ses domain email from
#---------------------------------------------------
variable "enable_ses_domain_mail_from" {
  description = "Enable ses domain mail from usage"
  default     = false
}

variable "ses_domain_mail_from_domain" {
  description = "Verified domain name to generate DKIM tokens for."
  default     = ""
}

variable "ses_domain_mail_from_mail_from_domain" {
  description = "Subdomain (of above domain) which is to be used as MAIL FROM address (Required for DMARC validation)"
  default     = ""
}

variable "ses_domain_mail_from_behavior_on_mx_failure" {
  description = "(Optional) The action that you want Amazon SES to take if it cannot successfully read the required MX record when you send an email. Defaults to UseDefaultValue"
  default     = null
}

#---------------------------------------------------
# AWS ses domain identity verification
#---------------------------------------------------
variable "enable_ses_domain_identity_verification" {
  description = "Enable ses domain identity verification usage"
  default     = false
}

variable "ses_domain_identity_verification_domain" {
  description = "The domain name of the SES domain identity to verify."
  default     = ""
}

#---------------------------------------------------
# AWS ses domain dkim
#---------------------------------------------------
variable "enable_ses_domain_dkim" {
  description = "Enable ses domain dkim usage"
  default     = false
}

variable "ses_domain_dkim_domain" {
  description = "Verified domain name to generate DKIM tokens for."
  default     = ""
}

#---------------------------------------------------
# AWS ses event destination
#---------------------------------------------------
variable "enable_ses_event_destination" {
  description = "Enable ses event destination usage"
  default     = false
}

variable "ses_event_destination_name" {
  description = "The name of the event destination"
  default     = ""
}

variable "ses_event_destination_configuration_set_name" {
  description = "The name of the configuration set"
  default     = ""
}

variable "ses_event_destination_matching_types" {
  description = "(Required) A list of matching types. May be any of 'send', 'reject', 'bounce', 'complaint', 'delivery', 'open', 'click', or 'renderingFailure'."
  default     = null
}

variable "ses_event_destination_enabled" {
  description = "(Optional) If true, the event destination will be enabled"
  default     = null
}

variable "ses_event_destination_cloudwatch_destination" {
  description = "(Optional) CloudWatch destination for the events"
  default     = []
}

variable "ses_event_destination_kinesis_destination" {
  description = "(Optional) Send the events to a kinesis firehose destination"
  default     = []
}

variable "ses_event_destination_sns_destination" {
  description = "(Optional) Send the events to an SNS Topic destination"
  default     = []
}
