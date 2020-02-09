#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.12.12"
}

provider "aws" {
    region  = "us-east-1"
    profile = "default"
}

module "iam_provider" {
    source                                      = "../../modules/iam_provider"
    name                                        = "TEST-AIM"
    environment                                 = "PROD"

    # Using IAM openID provider
    enable_iam_openid_connect_provider          = true
    iam_openid_connect_provider_url             = "https://accounts.google.com"
    iam_openid_connect_provider_client_id_list  = ["266362248691-342342xasdasdasda-apps.googleusercontent.com"]
    iam_openid_connect_provider_thumbprint_list = []

    # Using SAML provider
    enable_iam_saml_provider                    = true
    iam_saml_provider_name                      = ""
    iam_saml_provider_saml_metadata_document    = file("additional_files/saml-metadata.xml")
}
