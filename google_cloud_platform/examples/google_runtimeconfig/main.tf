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
module "google_runtimeconfig" {
    source                                      = "../../modules/google_runtimeconfig"
    name                                        = "TEST"
                                        
    # variable with text
    #enable_runtimeconfig_variable_text_usage    = "true"
    #runtimeconfig_config_name                   = "test-rc-config-stage"
    #text                                        = "linux-notes.org"

    # variable with value
    #enable_runtimeconfig_variable_value_usage   = true
    #runtimeconfig_config_name                   = "test-rc-config-stage"
    #value                                       = "test2"
    #value_file                                  = "files/file_name.dat"
    
}    

