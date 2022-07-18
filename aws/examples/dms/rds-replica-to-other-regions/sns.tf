#---------------------------------------------------------------
# AWS SNS
#---------------------------------------------------------------
data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.linux_notes_main.account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      module.dms_sns.sns_topic_arn,
    ]

    sid = "__default_statement_ID"
  }
}


module "dms_sns" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/sns?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # SNS topic
  enable_sns_topic          = true
  sns_topic_name            = "${local.name}-${local.environment}-dms-events-sns"
  sns_topic_display_name    = "${local.name}-${local.environment}-dms-events-sns"
  sns_topic_delivery_policy = file("./additional_files/sns_topic_delivery_policy_document.json")

  # SNS topic policy
  enable_sns_topic_policy = true
  sns_topic_policy_policy = data.aws_iam_policy_document.sns_topic_policy.json

  # SNS topic subscription
  enable_sns_topic_subscription        = true
  sns_topic_subscription_sns_protocol  = "email"
  sns_topic_subscription_sns_endpoints = local.sns_topic_subscription_list

  tags = local.tags

  depends_on = []
}