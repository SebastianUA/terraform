#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    # alias                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

data "template_file" "kms_key_policy" {
    template = file("policies/kms_key_policy.json.tpl")
}

module "kms" {
    source              = "../../modules/kms"
    
    enable_kms_key      = true
    name                = "TESTKMS"
    environment         = "stage"

    policy              = data.template_file.kms_key_policy.rendered

}
