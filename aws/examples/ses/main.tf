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
