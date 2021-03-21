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

module "transfer" {
  source      = "../../modules/transfer"
  name        = "TEST"
  environment = "stage"

  # transfer server
  enable_transfer_server        = true
  transfer_server_endpoint_type = "PUBLIC"
  transfer_server_logging_role  = "arn:aws:iam::167127734783:role/AllowS3FullAccess"

  # transfer user
  enable_transfer_user = true
  transfer_user_name   = "transfer_user_name"
  transfer_user_role   = "arn:aws:iam::167127734783:role/AllowS3FullAccess"

  # transfer ssh key
  enable_transfer_ssh_key = true
  transfer_ssh_key_body   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 example@linux-notes.org"

}
