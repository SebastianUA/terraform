#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "iam_server" {
  source      = "../../modules/iam_server"
  name        = "TEST-iam-server"
  environment = "stage"

  enable_iam_server_certificate = true
  iam_server_certificate_name   = "my-cert"

  iam_server_certificate_body        = file("additional_files/self-ca-cert.pem")
  iam_server_certificate_private_key = file("additional_files/test-key.pem")

  iam_server_certificate_chain = null
  iam_server_certificate_path  = "/"
}
