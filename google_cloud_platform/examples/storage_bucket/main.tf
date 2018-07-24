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

    enable_storage_bucket               = true
    lifecycle_rule_action_type          = "Delete"
    versioning_enabled                  = false
}

module "storage_bucket_acl" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_bucket_acl           = false
    bucket                              = "test-sb-stage"
    role_entity                         = ["OWNER:solo.metal@bigmir.net"]
    
}

module "storage_bucket_iam_binding" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"
    
    enable_storage_bucket               = false
    enable_storage_bucket_iam_binding   = false
}

module "storage_bucket_iam_member" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_bucket_iam_member    = false
    members                             = ["solo.metal@bigmir.net"]
} 

module "storage_bucket_iam_policy" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"
    
    enable_storage_bucket               = false
    enable_storage_bucket_iam_policy    = false
} 

module "storage_default_object_acl" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_default_object_acl   = false
    role_entity                         = ["OWNER:solo.metal@bigmir.net"]
} 

module "storage_object_acl" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_object_acl           = false
    role_entity                         = ["OWNER:solo.metal@bigmir.net"]
}    

module "storage_bucket_object" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_bucket_object        = true
    bucket                              = "${element(module.storage_bucket.google_storage_bucket_name, 0)}"
    source_path                         = "/Users/captain/Downloads/line-bot-google-cloud-functions-example-master.zip"
} 

module "storage_notification" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_notification         = false

    topic                               = "my-topic"
    bucket                              = "test-sb-stage"
} 
