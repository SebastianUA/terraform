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
module "google_pubsub" {
    source                              = "../../modules/google_pubsub"
    name                                = "TEST"

    #
    enable_pubsub_topic                 = true
    #
    #enable_pubsub_topic_iam_policy      = true
    #topic                               = "test-ps-topic-stage"
    #
    #enable_pubsub_topic_iam_binding     = true
    #topic                               = "test-ps-topic-stage"
    #members                              = ["OWNER:solo.metal@bigmir.net"]
    #
    #enable_pubsub_topic_iam_member       = true
    #members                              = ["OWNER:solo.metal@bigmir.net"]   
    #
    #enable_pubsub_subscription_default   = true  
    #
    #enable_pubsub_subscription_iam_policy  = true
    #
    #enable_pubsub_subscription_iam_binding = true
    #members                                = ["OWNER:solo.metal@bigmir.net"]
    #
    #enable_pubsub_subscription_iam_member  = true
    #members                                = ["OWNER:solo.metal@bigmir.net"]
}

