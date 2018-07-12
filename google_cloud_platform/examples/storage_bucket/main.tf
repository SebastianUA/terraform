#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "google" {
    credentials = "${file("/Users/captain/.config/gcloud/creds/terraform_creds.json")}"
    project     = "terraform-2018"
    region      = "us-east1"
}   
module "storage_bucket" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    lifecycle_rule_action_type          = "Delete"
    versioning_enabled                  = false

    #enable_storage_bucket_acl           = true
    #bucket                              = "test-sb-stage"
    #
    #enable_storage_bucket_iam_binding    = true
    #
    #enable_storage_bucket_iam_member    = true        
    #members                             = ["solo.metal@bigmir.net"]
    #
    #enable_storage_bucket_iam_policy     = true   
    #
    #enable_storage_default_object_acl    = true   
    #
    #enable_storage_object_acl           = true
    #role_entity                         = ["OWNER:solo.metal@bigmir.net"]
    #enable_storage_bucket_object        = true
    #    
    #enable_storage_notification         = true
}

