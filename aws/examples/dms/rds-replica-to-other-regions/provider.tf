provider "aws" {
  region = "us-east-1"

  shared_credentials_files = [pathexpand("~/.aws/credentials")]
  profile                  = "default"
}

# us-east-1
provider "aws" {
  region = "us-east-1"

  alias = "linux_notes_main"

  shared_credentials_files = [pathexpand("~/.aws/credentials")]
  profile                  = "default"
}