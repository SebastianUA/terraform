#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-east-1"
    # alias = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
     # access_key = "${var.aws_access_key}"
     # secret_key = "${var.aws_secret_key}"
}
module "kms" {
    source               = "../../modules/kms"
    name                 = "TEST-KMS"
    environment          = "PROD"

    aws_account_id       = "XXXXXXXXXXXXXXXXX"
}
module "s3" {
    source                              = "../../modules/s3"
    name                                = "My-backet"
    environment                         = "PROD"

    #
    s3_acl          = "log-delivery-write"  #"private"  
    force_destroy   = "true"    
    # Allow public web-site (Static website hosting)
    website         = [
    {
        index_document = "index.html"
        error_document = "error.html"
        #redirect_all_requests_to = "https://s3-website.linux-notes.org"
    },
    ]
    # Use cors rules
    cors_rule       = [
    {
        allowed_headers = ["*"]
        allowed_methods = ["PUT", "POST"]
        allowed_origins = ["https://s3-website.linux-notes.org"]
        expose_headers  = ["ETag"]
        max_age_seconds = 3000
    },
    ]

    kms_master_key_id = "arn:aws:kms:${module.kms.region}:${module.kms.aws_account_id}:key/${module.kms.kms_key_id}"
}
