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

module "globalaccelerator" {
  source      = "../../modules/globalaccelerator"
  name        = "TEST"
  environment = "dev"

  # AWS globalaccelerator accelerator
  enable_globalaccelerator_accelerator = true
  globalaccelerator_accelerator_name   = "test-globalaccelerator-accelerator"

  globalaccelerator_accelerator_attributes = [{
    flow_logs_enabled   = true
    flow_logs_s3_bucket = "example-bucket"
    flow_logs_s3_prefix = "flow-logs/"
  }]

  # AWS globalaccelerator listener
  enable_globalaccelerator_listener          = true
  globalaccelerator_listener_client_affinity = "SOURCE_IP"
  globalaccelerator_listener_protocol        = "TCP"
  globalaccelerator_listener_port_range = [{
    from_port = 80
    to_port   = 80
  }]

  # AWS globalaccelerator endpoint group
  enable_globalaccelerator_endpoint_group = true
  globalaccelerator_endpoint_group_endpoint_configuration = [
    #{
    #    endpoint_id = "${aws_lb.example.arn}"
    #    weight      = 100
    #}
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
