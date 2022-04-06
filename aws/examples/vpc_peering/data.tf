data "aws_caller_identity" "current" {}

data "aws_caller_identity" "linux_notes_prod" {
  provider = aws.linux_notes_prod
}

data "aws_caller_identity" "linux_notes_vault" {
  provider = aws.linux_notes_vault
}

data "aws_region" "current" {}

data "aws_region" "linux_notes_prod" {
  provider = aws.linux_notes_prod
}

data "aws_region" "linux_notes_vault" {
  provider = aws.linux_notes_vault
}
