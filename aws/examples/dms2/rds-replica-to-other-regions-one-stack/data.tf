data "aws_caller_identity" "current" {}

data "aws_caller_identity" "linux_notes_main" {
  provider = aws.linux_notes_main
}

data "aws_region" "current" {}

data "aws_region" "linux_notes_main" {
  provider = aws.linux_notes_main
}
