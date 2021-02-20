{
  "Version": "2012-10-17",
  "Id": "key-default-1",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::6666666666666666:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
