terraform {
  required_version = "~> 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }

  #backend "s3" {
  #  bucket = "terraform-state-bucket"
  #  key    = "aws/ac/us-east-1/prod/networking/terraform.tfstate"
  #  region = "us-east-1"
  #
  #  dynamodb_table = "dynamodb_state_lock"
  #}
}