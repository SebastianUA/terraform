#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                   = "us-east-1"
  profile                  = "default"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
}

module "msk" {
  source      = "../../modules/msk"
  environment = "stage"

  # AWS MSK cluster
  enable_msk_cluster                 = true
  msk_cluster_name                   = ""
  msk_cluster_kafka_version          = "2.3.1"
  msk_cluster_number_of_broker_nodes = 3

  msk_cluster_broker_node_group_info = [
    {
      instance_type   = "kafka.m5.large"
      ebs_volume_size = 100
      client_subnets  = ["subnet-8851dea6", "subnet-c3a5f589", "subnet-1d7df041"]
      security_groups = ["sg-014100db4cdff3e0a", "sg-038b8bd5f9120f3c3", "sg-044c87b82fc0fa439", "sg-0eb59e471c3d5a87b", "sg-7f501633"]
      az_distribution = "DEFAULT"
    }
  ]

  msk_cluster_encryption_info = [
    {
      //encryption_at_rest_kms_key_arn = module.kms.kms_id
      // encryption_in_transit = {
      //client_broker = "TLS"
      //in_cluster = true
      //  }
    }
  ]

  msk_cluster_client_authentication = [
    {
      tls  = {}
      sasl = {}
    }
  ]
  msk_cluster_configuration_info = []
  msk_cluster_open_monitoring = [
    {
      prometheus = {
        jmx_exporter = {
          enabled_in_broker = true
        }
        node_exporter = {
          enabled_in_broker = true
        }
      }
    }
  ]

  msk_cluster_logging_info = [
    {
      broker_logs = {
        cloudwatch_logs = [
          //{
          //enabled   = null
          //log_group = null
          //}
        ]
        firehose = [
          //{
          //enabled         = null
          //delivery_stream = null
          //}
        ]
        s3 = [
          //{
          //enabled = null
          //bucket  = null
          //prefix  = null
          //}
        ]
      }
    }
  ]


  # AWS MSK config
  enable_msk_configuration         = true
  msk_configuration_name           = "msk-config"
  msk_configuration_kafka_versions = ["2.3.1"]

  msk_configuration_server_properties = <<PROPERTIES
auto.create.topics.enable = true
delete.topic.enable = true
PROPERTIES

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
