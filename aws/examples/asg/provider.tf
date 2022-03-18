terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }

  #backend "s3" {
  #    bucket  = "test-prod"
  #    key     = "terraform/test-prod.tfstate"
  #    region  = "us-west-2"
  #    profile = "default"
  #}
}

provider "aws" {
  region  = "us-west-2"
  profile = "default"
}
