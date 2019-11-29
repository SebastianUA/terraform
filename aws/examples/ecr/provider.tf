terraform {
    required_version = ">= 0.12.12"
}

provider "aws" {
    #version = "~> 2.5"
    region  = "us-west-2"
    profile = "default"
}
