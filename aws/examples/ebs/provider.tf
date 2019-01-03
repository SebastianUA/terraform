terraform {
    required_version = ">= 0.11.11"
    #backend "s3" {
    #    bucket  = "test-prod"
    #    key     = "terraform/test-prod.tfstate"
    #    region  = "us-west-2"
    #    profile = "default"
    #}
}

provider "aws" {
    version = "~> 1.7"
    region  = "us-west-2"
    profile = "default"
}

