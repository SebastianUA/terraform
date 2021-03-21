#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "worklink" {
  source      = "../../modules/worklink"
  name        = "TEST"
  environment = "stage"

  # worklink fleet
  enable_worklink_fleet            = true
  worklink_fleet_name              = ""
  worklink_fleet_network           = []
  worklink_fleet_identity_provider = []

  # worklink
  enable_worklink_website_certificate_authority_association       = true
  worklink_website_certificate_authority_association_fleet_arn    = ""
  worklink_website_certificate_authority_association_certificate  = file("additional_files/certificate.pem")
  worklink_website_certificate_authority_association_display_name = null
}
