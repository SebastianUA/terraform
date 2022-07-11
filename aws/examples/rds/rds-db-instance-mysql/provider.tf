provider "aws" {
  region = "us-east-1"

  alias = "captainua_main"

  shared_credentials_files = [pathexpand("~/.aws/credentials")]
  profile                  = "default"
}
