#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-west-2"
    profile = "default"
    # or 
    #shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
      # or
      # access_key = "${var.aws_access_key}"
      # secret_key = "${var.aws_secret_key}"
}
#-----------------
# Example 1
#-----------------
module "s3" {
    source                                  = "../../modules/s3"
    name                                    = "TEST-bucket"
    environment                             = "NonPROD"
    region                                  = "us-west-2"

    enable_s3_bucket                        = true
    s3_acl                                  = "private"
    cors_rule                               = []

    enable_versioning                       = false
    enable_lifecycle_rule                   = false

    #add policy to the bucket
    enable_s3_bucket_policy                 = false
    policy                                  = ""

    # Add files to bucket
    enable_s3_bucket_object                 = true
    #s3_bucket_object_key                    = ["additional_files/test.txt"]
    s3_bucket_object_source                 = ["additional_files/test.txt", "additional_files/test2.txt"]
    type_of_file                            = "txt"


    #enable_s3_bucket_notification_sns       = true
    
    #enable_s3_bucket_notification_sqs       = true
    #queue_configuration                     = []

    #enable_s3_bucket_notification_lambda_function = true
    
}
#-----------------
# Example 2
#-----------------
#module "kms" {
#    source               = "../../modules/kms"
#    name                 = "TEST-KMS"
#    environment          = "PROD"
#
#    aws_account_id       = "XXXXXXXXXXXXXXXXX"
#}
#module "s3" {
#    source                              = "../../modules/s3"
#    name                                = "My-backet"
#    environment                         = "PROD"
#
#    #enable_s3_bucket_website             = true    
#    s3_acl          = "log-delivery-write"  #"private"  
#    force_destroy   = "true"    
#    # Allow public web-site (Static website hosting)
#    website         = [
#    {
#        index_document = "index.html"
#        error_document = "error.html"
#        #redirect_all_requests_to = "https://s3-website.linux-notes.org"
#    },
#    ]
#    # Use cors rules
#    cors_rule       = [
#    {
#        allowed_headers = ["*"]
#        allowed_methods = ["PUT", "POST"]
#        allowed_origins = ["https://s3-website.linux-notes.org"]
#        expose_headers  = ["ETag"]
#        max_age_seconds = 3000
#    },
#    ]
#
#    kms_master_key_id = "arn:aws:kms:${module.kms.region}:${module.kms.aws_account_id}:key/${module.kms.kms_key_id}"
#}
