#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "batch" {
  source      = "../../modules/batch"
  name        = "TEST"
  environment = "dev"

  # Batch job definition
  enable_batch_job_definition = true
  batch_job_definition_name   = ""
  batch_job_definition_type   = "container"

  batch_job_definition_container_properties = file("./additional_files/job_definition-container_properties.json")

  # Batch compute environment
  enable_batch_compute_environment            = false
  batch_compute_environment_name              = "batch-comp-env"
  batch_compute_environment_service_role      = "role_here"
  batch_compute_environment_type              = "MANAGED"
  batch_compute_environment_compute_resources = []

  # Batch job queue
  enable_batch_job_queue               = false
  batch_job_queue_name                 = ""
  batch_job_queue_state                = "ENABLED"
  batch_job_queue_priority             = 1
  batch_job_queue_compute_environments = []

}
