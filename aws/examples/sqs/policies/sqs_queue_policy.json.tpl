{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "sqs_arn_here",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "sqs_arn_here"
        }
      }
    }
  ]
}
