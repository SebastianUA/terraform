# Work with SES via terraform

A terraform module for making SES.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "ses_domain_identity" {
  source      = "../../modules/ses"
  name        = "TEST"
  environment = "stage"

  # ses domain identity
  enable_ses_domain_identity  = true
  ses_domain_identity_domains = ["linux-notes.org"]

  # ses identity notification topic
  enable_ses_identity_notification_topic                   = true
  ses_identity_notification_topic_notification_type        = "Bounce"
  ses_identity_notification_topic_topic_arn                = "arn:aws:sns:us-east-1:123456789012:mytopic"
  ses_identity_notification_topic_include_original_headers = true

  # ses domain mail from
  enable_ses_domain_mail_from = true


}

module "ses_email_identity" {
  source      = "../../modules/ses"
  name        = "TEST"
  environment = "stage"

  # enable_ses_email_identity
  enable_ses_email_identity = true
  ses_email_identity_emails = ["vitaliy.natarov@yahoo.com"]
}

data "aws_iam_policy_document" "iam_policy_document" {
  statement {
    actions   = ["SES:SendEmail", "SES:SendRawEmail"]
    resources = [module.ses_domain_identity.ses_domain_identity_arn]

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
  }

  depends_on = [
    module.ses_domain_identity
  ]
}

module "ses" {
  source      = "../../modules/ses"
  name        = "TEST"
  environment = "stage"

  # ses template 
  enable_ses_template  = true
  ses_template_name    = "ses-template"
  ses_template_subject = "Greetings, {{name}}!"
  ses_template_html    = "<h1>Hello {{name}},</h1><p>Your favorite animal is {{favoriteanimal}}.</p>"
  ses_template_text    = "Hello {{name}},\r\nYour favorite animal is {{favoriteanimal}}."

  # ses receipt rule set 
  enable_ses_receipt_rule_set        = true
  ses_receipt_rule_set_rule_set_name = "ses-receipt-rule-set-rule-set"

  # ses receipt rule 
  enable_ses_receipt_rule       = true
  ses_receipt_rule_name         = "ses-receipt-rule"
  ses_receipt_rule_recipients   = ["karen@example.com"]
  ses_receipt_rule_enabled      = true
  ses_receipt_rule_scan_enabled = true

  ses_receipt_rule_add_header_action = [
    {
      header_name  = "Custom-Header"
      header_value = "Added by SES"
      position     = 1
    }
  ]

  ses_receipt_rule_s3_action = [
    {
      bucket_name = "emails"
      position    = 2
    }
  ]

  # ses receipt filter
  enable_ses_receipt_filter = true
  ses_receipt_filter_stack = [
    {
      name   = "block-spammer-1"
      cidr   = "10.10.10.10"
      policy = "Block"
    },
    {
      name   = "block-spammer-2"
      cidr   = "10.10.10.11"
      policy = "Block"
    }
  ]

  # ses active receipt rule set
  enable_ses_active_receipt_rule_set        = true
  ses_active_receipt_rule_set_rule_set_name = ""

  # ses configuration set
  enable_ses_configuration_set = true
  ses_configuration_set_name   = ""
  ses_configuration_set_delivery_options = {
    tls_policy = "Require"
  }

  # ses identity policy
  enable_ses_identity_policy   = true
  ses_identity_policy_name     = "ses-identity-policy"
  ses_identity_policy_identity = module.ses_domain_identity.ses_domain_identity_arn
  ses_identity_policy_policy   = data.aws_iam_policy_document.iam_policy_document.json




  depends_on = [
    module.ses_domain_identity,
    data.aws_iam_policy_document.iam_policy_document
  ]
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_ses_template` - Set enable ses template usage (`default = False`)
- `ses_template_name` - The name of the template. Cannot exceed 64 characters. You will refer to this name when you send email. (`default = ""`)
- `ses_template_subject` - (Optional) The subject line of the email. (`default = null`)
- `ses_template_html` - (Optional) The HTML body of the email. Must be less than 500KB in size, including both the text and HTML parts. (`default = null`)
- `ses_template_text` - (Optional) The email body that will be visible to recipients whose email clients do not display HTML. Must be less than 500KB in size, including both the text and HTML parts. (`default = null`)
- `enable_ses_receipt_rule` - Enable ses receipt rule usage (`default = False`)
- `ses_receipt_rule_name` - The name of the rule (`default = ""`)
- `ses_receipt_rule_rule_set_name` - The name of the rule set (`default = ""`)
- `ses_receipt_rule_recipients` - (Optional) A list of email addresses (`default = null`)
- `ses_receipt_rule_enabled` - (Optional) If true, the rule will be enabled (`default = null`)
- `ses_receipt_rule_scan_enabled` - (Optional) If true, incoming emails will be scanned for spam and viruses (`default = null`)
- `ses_receipt_rule_after` - (Optional) The name of the rule to place this rule after (`default = null`)
- `ses_receipt_rule_tls_policy` - (Optional) Require or Optional (`default = null`)
- `ses_receipt_rule_add_header_action` - (Optional) A list of Add Header Action blocks.  (`default = []`)
- `ses_receipt_rule_bounce_action` - (Optional) A list of Bounce Action blocks. (`default = []`)
- `ses_receipt_rule_lambda_action` - (Optional) A list of Lambda Action blocks. (`default = []`)
- `ses_receipt_rule_s3_action` - (Optional) A list of S3 Action blocks. (`default = []`)
- `ses_receipt_rule_sns_action` - (Optional) A list of SNS Action blocks. (`default = []`)
- `ses_receipt_rule_stop_action` - (Optional) A list of Stop Action blocks (`default = []`)
- `ses_receipt_rule_workmail_action` - (Optional) A list of WorkMail Action blocks. (`default = []`)
- `enable_ses_receipt_rule_set` - Enable ses receipt rule set usage (`default = False`)
- `ses_receipt_rule_set_rule_set_name` - Name of the rule set. (`default = ""`)
- `enable_ses_receipt_filter` - Enable ses receipt filter usage (`default = False`)
- `ses_receipt_filter_stack` - The stack of ses receipt filter (`default = []`)
- `enable_ses_active_receipt_rule_set` - Enable ses active receipt rule set usage (`default = False`)
- `ses_active_receipt_rule_set_rule_set_name` - (Required) The name of the rule set (`default = ""`)
- `enable_ses_configuration_set` - Enable ses configuration set usage (`default = False`)
- `ses_configuration_set_name` - Name of the configuration set. (`default = ""`)
- `ses_configuration_set_reputation_metrics_enabled` - (Optional) Whether or not Amazon SES publishes reputation metrics for the configuration set, such as bounce and complaint rates, to Amazon CloudWatch. The default value is false (`default = null`)
- `ses_configuration_set_delivery_options` - (Optional) Configuration block. (`default = {}`)
- `ses_configuration_set_sending_enabled` - (Optional) Whether email sending is enabled or disabled for the configuration set. The default value is true. (`default = null`)
- `enable_ses_domain_identity` - Enable ses domain identity usage (`default = False`)
- `ses_domain_identity_domains` - Set list of domains for ses domain identity (`default = []`)
- `enable_ses_email_identity` - Enable ses email identity usage (`default = False`)
- `ses_email_identity_emails` - Set list of emails for ses email identity (`default = []`)
- `enable_ses_identity_policy` - Enable ses identity policy usage (`default = False`)
- `ses_identity_policy_name` - Name of the policy. (`default = ""`)
- `ses_identity_policy_identity` - Name or Amazon Resource Name (ARN) of the SES Identity. (`default = ""`)
- `ses_identity_policy_policy` - (Required) JSON string of the policy. For more information about building AWS IAM policy documents with Terraform (`default = null`)
- `enable_ses_identity_notification_topic` - Enable ses identity notification topic usage (`default = False`)
- `ses_identity_notification_topic_notification_type` - (Required) The type of notifications that will be published to the specified Amazon SNS topic. Valid Values: Bounce, Complaint or Delivery. (`default = null`)
- `ses_identity_notification_topic_identity` - The identity for which the Amazon SNS topic will be set. You can specify an identity by using its name or by using its Amazon Resource Name (ARN). (`default = ""`)
- `ses_identity_notification_topic_topic_arn` - (Optional) The Amazon Resource Name (ARN) of the Amazon SNS topic. Can be set to '' (an empty string) to disable publishing. (`default = null`)
- `ses_identity_notification_topic_include_original_headers` - (Optional) Whether SES should include original email headers in SNS notifications of this type. false by default. (`default = null`)
- `enable_ses_domain_mail_from` - Enable ses domain mail from usage (`default = False`)
- `ses_domain_mail_from_domain` - Verified domain name to generate DKIM tokens for. (`default = ""`)
- `ses_domain_mail_from_mail_from_domain` - Subdomain (of above domain) which is to be used as MAIL FROM address (Required for DMARC validation) (`default = ""`)
- `ses_domain_mail_from_behavior_on_mx_failure` - (Optional) The action that you want Amazon SES to take if it cannot successfully read the required MX record when you send an email. Defaults to UseDefaultValue (`default = null`)
- `enable_ses_domain_identity_verification` - Enable ses domain identity verification usage (`default = False`)
- `ses_domain_identity_verification_domain` - The domain name of the SES domain identity to verify. (`default = ""`)
- `enable_ses_domain_dkim` - Enable ses domain dkim usage (`default = False`)
- `ses_domain_dkim_domain` - Verified domain name to generate DKIM tokens for. (`default = ""`)
- `enable_ses_event_destination` - Enable ses event destination usage (`default = False`)
- `ses_event_destination_name` - The name of the event destination (`default = ""`)
- `ses_event_destination_configuration_set_name` - The name of the configuration set (`default = ""`)
- `ses_event_destination_matching_types` - (Required) A list of matching types. May be any of 'send', 'reject', 'bounce', 'complaint', 'delivery', 'open', 'click', or 'renderingFailure'. (`default = null`)
- `ses_event_destination_enabled` - (Optional) If true, the event destination will be enabled (`default = null`)
- `ses_event_destination_cloudwatch_destination` - (Optional) CloudWatch destination for the events (`default = []`)
- `ses_event_destination_kinesis_destination` - (Optional) Send the events to a kinesis firehose destination (`default = []`)
- `ses_event_destination_sns_destination` - (Optional) Send the events to an SNS Topic destination (`default = []`)

## Module Output Variables
----------------------
- `ses_template_arn` - The ARN of the SES template
- `ses_template_id` - The name of the SES template
- `ses_receipt_rule_arn` - The SES receipt rule ARN.
- `ses_receipt_rule_id` - The SES receipt rule name.
- `ses_receipt_rule_set_arn` - SES receipt rule set ARN.
- `ses_receipt_rule_set_id` - SES receipt rule set name.
- `ses_receipt_filter_arn` - The SES receipt filter ARN.
- `ses_receipt_filter_id` - The SES receipt filter name.
- `ses_active_receipt_rule_set_arn` - The SES receipt rule set ARN.
- `ses_active_receipt_rule_set_id` - The SES receipt rule set name.
- `ses_configuration_set_arn` - SES configuration set ARN.
- `ses_configuration_set_id` - SES configuration set name.
- `ses_configuration_set_last_fresh_start` - The date and time at which the reputation metrics for the configuration set were last reset. Resetting these metrics is known as a fresh start.
- `ses_domain_identity_id` - SES domain identity id.
- `ses_domain_identity_arn` - The ARN of the domain identity.
- `ses_domain_identity_verification_token` - A code which when added to the domain as a TXT record will signal to SES that the owner of the domain has authorised SES to act on their behalf. The domain identity will be in state 'verification pending' until this is done.
- `ses_email_identity_id` - SES email identity id.
- `ses_email_identity_arn` - The ARN of the email identity.
- `ses_identity_policy_id` - SES email identity policy id.
- `ses_identity_notification_topic_id` - SES email identity notification topic id.
- `ses_domain_mail_from_id` - The domain name.
- `ses_domain_identity_verification_id` - The domain name of the domain identity.
- `ses_domain_identity_verification_arn` - The ARN of the domain identity.
- `ses_domain_dkim_id` - The domain dkim id.
- `ses_domain_dkim_dkim_tokens` - DKIM tokens generated by SES. These tokens should be used to create CNAME records used to verify SES Easy DKIM. See below for an example of how this might be achieved when the domain is hosted in Route 53 and managed by Terraform.
- `ses_event_destination_id` - The SES event destination name.
- `ses_event_destination_arn` - The SES event destination ARN.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
