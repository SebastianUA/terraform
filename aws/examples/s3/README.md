# Work with AWS S3 via terraform

A terraform module for working with S3.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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
    s3_bucket_object_key                    = "additional_files/test.txt"
    s3_bucket_object_source                 = "additional_files/test.txt"
    type_of_file                            = "zip"


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
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix" (`default = "TEST-S3"`).
- `environment` - Environment for service (`default = stage`). Just uses for tag.
- `orchestration` - Type of orchestration (`default = Terraform`). Just uses for tag.
- `createdby` - Created by (`default = Vitaliy Natarov`). Just uses for tag.
- `region` - The region where to deploy this code (e.g. us-east-1) - (`default  = "us-east-1"`).
- `bucket_prefix` - Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket (`default = ""`). I don't USE IT IN MODULE, used - bucket!
- `s3_acl` - The canned ACL to apply. Defaults to 'private' (`default  = "private"`).
- `versioning` - Enabling a versioning (`default = false`).
- `force_destroy` - A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable (`default = false`).
- `website` - List of website fields (`default = []`).
- `routing_rules` - Routing rules (`default = []`).
- `cors_rule` - Cors rule (`default = []`).
- `logging` - Add logging rules (`default = []`).
- `enable_lifecycle_rule` - Enable lifecycle rule (`default = true`).
- `lifecycle_rule_prefix` - Set prefix for lifecycle rule (`default = ""`).
- `noncurrent_version_expiration_days` - (Optional) Specifies when noncurrent object versions expire (`default = "90"`).
- `noncurrent_version_transition_days` - Specifies when noncurrent object versions transitions (`default = "30"`).
- `standard_transition_days` - Number of days to persist in the standard storage tier before moving to the infrequent access tier (`default = "30"`).
- `glacier_transition_days` - Number of days after which to move the data to the glacier storage tier (`default = "60"`).
- `expiration_days` - Number of days after which to expunge the objects (`default = "90"`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
