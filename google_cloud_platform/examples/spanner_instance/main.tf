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
module "spanner_instance" {
    source                              = "../../modules/spanner_instance"
    name                                = "TEST"

    num_nodes                           = 1
    
    # spanner instance iam policy
    #enable_spanner_instance_iam_policy  = true
    #instance                            = "test-si-stage"
    #members                             = ["user:solo.metaliSebastian@gmail.com",]
    #role                                = "roles/editor"    
    #
    # spanner instance iam binding
    #enable_spanner_instance_iam_binding = true
    #instance                            = "test-si-stage"
    #members                             = [
    #    "user:solo.metaliSebastian@gmail.com",
    #]
    #role                                = "roles/editor"    
    #
    # spanner instance iam member
    #enable_spanner_instance_iam_member  = true
    #instance                            = "test-si-stage"
    #members                             = [
    #    "user:solo.metaliSebastian@gmail.com",
    #]
    #role                                = "roles/editor"
    #
    # spanner_database
    #enable_spanner_database             = true
    #instance                            = "test-si-stage"
    #db_name                             = "db-test"
    #ddl                                 = [
    #]
    #
    # Create spanner database iam
    #enable_spanner_database_iam_policy  = true
    #instance                            = "test-si-stage"
    #members                             = [
    #    "user:solo.metaliSebastian@gmail.com",
    #]
    #role                                = "roles/editor"
    #
    # spanner_database_iam_binding
    #enable_spanner_database_iam_binding = true
    #instance                            = "test-si-stage"
    #members                             = [
    #    "user:solo.metaliSebastian@gmail.com",
    #]
    #role                                = "roles/editor"
    #
    # spanner_database_iam_member
    #enable_spanner_database_iam_member  = true
    #instance                            = "test-si-stage"
    #members                             = [
    #    "user:solo.metaliSebastian@gmail.com",
    #]
    #role                                = "roles/editor"
} 

