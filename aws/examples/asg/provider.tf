terraform {
    required_version = "~> 0.12.12"
    #backend "s3" {
    #    bucket  = "test-prod"
    #    key     = "terraform/test-prod.tfstate"
    #    region  = "us-west-2"
    #    profile = "default"
    #}
}

provider "aws" {
    version = "~> 2.7"
    region  = "us-west-2"
    profile = "default"
}
