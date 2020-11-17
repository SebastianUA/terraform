#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "msk" {
  source      = "../../modules/msk"
  environment = "stage"

  enable_msk_cluster     = true
  cluster_name           = ""
  kafka_version          = "2.3.1"
  number_of_broker_nodes = 3

  broker_node_group_info = [
    {
      instance_type   = "kafka.m5.large"
      ebs_volume_size = 100
      client_subnets  = ["subnet-8851dea6", "subnet-c3a5f589", "subnet-1d7df041"]
      security_groups = ["sg-aed75fe1"]
      az_distribution = "DEFAULT"
    }
  ]

  #broker_node_group_info_instance_type            = "kafka.m5.large"
  #broker_node_group_info_ebs_volume_size          = "100"
  #broker_node_group_info_client_subnets           = ["subnet-02697458", "subnet-02e9c549", "subnet-289d9e51"]
  #broker_node_group_info_security_groups          = ["sg-014100db4cdff3e0a", "sg-038b8bd5f9120f3c3", "sg-044c87b82fc0fa439", "sg-0eb59e471c3d5a87b", "sg-7f501633"]

  #encryption_in_transit_client_broker              = "TLS"
  #encryption_in_transit_in_cluster                 = true
  #encryption_info_encryption_at_rest_kms_key_arn   = "${module.kms.}"

  #client_authenication_certificate_authority_arns = ["${module.acm_certificate.aws_acm_certificate_arn}"]

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
