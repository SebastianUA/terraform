terraform {
  required_version = "~> 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.9.0"
    }
  }

  // backend "s3" {
  //   bucket = "terraform-states-bucket"
  //   key    = "aws/66666666666666/us-east-1/prod/dms_replication/terraform.tfstate"
  //   region = "us-east-1"

  //   dynamodb_table = "terraform-locker"
  // }
}