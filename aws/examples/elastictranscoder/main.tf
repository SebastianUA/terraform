#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13.5"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "elastictranscoder" {
  source      = "../../modules/elastictranscoder"
  name        = "TEST"
  environment = "stage"

  # elastictranscoder pipeline
  enable_elastictranscoder_pipeline       = true
  elastictranscoder_pipeline_name         = "test-elastictranscoder-pipeline"
  elastictranscoder_pipeline_input_bucket = "my-test-bucket"
  elastictranscoder_pipeline_role         = "arn:aws:iam::167127734783:role/admin-role"

  # elastictranscoder preset
  enable_elastictranscoder_preset      = true
  elastictranscoder_preset_container   = "m4"
  elastictranscoder_preset_name        = null
  elastictranscoder_preset_description = null

}
