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
module "endpoints_service" {
    source                              = "../../modules/endpoints_service"

    # Use openapi 
    enable_endpoints_service_openapi    = true
    openapi_config                      = "files/openapi_spec.yml"   
    #
    # Use grpc
    #enable_endpoints_service_grpc        = true
    #grpc_config                         = "files/service_spec.yml"
    #protoc_output_base64                = "files/compiled_descriptor_file.pb"

   service_name                         = "api-name.endpoints.terraform-2018.cloud.goog"
}

