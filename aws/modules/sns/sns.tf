#---------------------------------------------------
# Create AWS SNS topic
#---------------------------------------------------
resource "aws_sns_topic" "sns_topic" {
    #name_prefix = "${lower(var.name)}-sns-"
    name            = "${lower(var.name)}-sns-${lower(var.environment)}"
    display_name    = "${lower(var.name)}-sns-${lower(var.environment)}"
    delivery_policy = "${data.template_file.sns_topic_delivery_policy_document.rendered}"

    depends_on = ["data.template_file.sns_topic_delivery_policy_document"]
}
                            
data "template_file" "sns_topic_delivery_policy_document" {
                                            
    template = "${file("${path.module}/policies/sns_topic_delivery_policy_document.json.tpl")}"

    vars {
        minDelayTarget                  = "${var.minDelayTarget}"
        maxDelayTarget                  = "${var.maxDelayTarget}"
        numRetries                      = "${var.numRetries}"
        numMaxDelayRetries              = "${var.numMaxDelayRetries}"
        numNoDelayRetries               = "${var.numNoDelayRetries}"
        numMinDelayRetries              = "${var.numMinDelayRetries}"
        backoffFunction                 = "${var.backoffFunction}"
        disableSubscriptionOverrides    = "${var.disableSubscriptionOverrides}"
    }

}
#---------------------------------------------------
# Create AWS SNS topic policies
#---------------------------------------------------
resource "aws_sns_topic_policy" "sns_topic_policy" {
    arn             = "${aws_sns_topic.sns_topic.arn}"
    policy          = "${data.aws_iam_policy_document.sns_topic_policy_document.json}"
                    
    depends_on  = ["aws_sns_topic.sns_topic", "data.aws_iam_policy_document.sns_topic_policy_document"]
}

data "aws_iam_policy_document" "sns_topic_policy_document" {
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
                "${var.account-id}",
            ]
        }

        effect = "Allow"

        principals {
            type        = "AWS"
            identifiers = ["*"]
        }

        resources = [
            "${aws_sns_topic.sns_topic.arn}",
        ]

        sid = "__default_statement_ID"
    }

}
#---------------------------------------------------
# Create AWS SNS topic subscription
#---------------------------------------------------
resource "aws_sns_topic_subscription" "sns_topic_subscription" {
    topic_arn = "${aws_sns_topic.sns_topic.id}"

    confirmation_timeout_in_minutes = "${var.confirmation_timeout_in_minutes}"
    endpoint_auto_confirms          = "${var.endpoint_auto_confirms}"
    raw_message_delivery            = "${var.raw_message_delivery}"

    protocol  = "${var.sns_protocol}"
    endpoint  = "${var.sns_endpoint}"

    depends_on = ["aws_sns_topic.sns_topic"]
}
