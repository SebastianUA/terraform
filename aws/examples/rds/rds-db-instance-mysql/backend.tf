terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.9.0"
    }
  }

  backend "s3" {
    bucket = "terraform-states-bucket"
    key    = "aws/666666666666/us-east-1/stage/global-rds/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-locker"
  }
}