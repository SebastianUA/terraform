#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                   = "us-west-2"
  profile                  = "default"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
}

module "prometheus" {
  source = "../../modules/prometheus"

  enable_prometheus_workspace = true
  prometheus_workspace_alias  = "prometheus-test"
}
