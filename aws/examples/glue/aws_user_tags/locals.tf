locals {
  tags = merge(
    var.custom_tags,
    {
      terraform_managed = true
      environment       = var.environment
      modified          = formatdate("DD-MMM-YY hh:mm:ss ZZZ", timestamp())
      modified_by       = data.aws_caller_identity.current.arn
    }
  )
}