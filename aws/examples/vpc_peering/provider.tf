provider "aws" {
  region = "us-east-1"

  shared_credentials_files = [pathexpand("~/.aws/credentials")]
  profile                  = "default"
}

provider "aws" {
  region = "us-east-1"

  alias = "accepter"

  // assume_role {
  //   role_arn = "arn:aws:iam::XXXXXXXXXXXXXXXXX:role/terraform-role"
  // }

  shared_credentials_files = [pathexpand("~/.aws/credentials")]
  profile                  = "accepter" # "aws-main"
}

provider "aws" {
  region = "us-east-1"

  alias = "requester"

  // assume_role {
  //   role_arn = "arn:aws:iam::YYYYYYYYYYYYYY:role/terraform-role"
  // }

  shared_credentials_files = [pathexpand("~/.aws/credentials")]
  profile                  = "requester"
}
