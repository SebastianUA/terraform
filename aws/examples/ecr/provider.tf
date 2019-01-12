terraform {
    required_version = ">= 0.11.11"
}

provider "aws" {
    version = "~> 1.7"
    region  = "us-west-2"
    profile = "default"
}
