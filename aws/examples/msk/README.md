# Work with MSK via terraform

A terraform module for making MSK.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
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

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. (`default = {}`)
- `enable_msk_cluster` - Enable AWS MSK usage (`default = False`)
- `msk_cluster_name` - (Required) Name of the MSK cluster. (`default = ""`)
- `msk_cluster_kafka_version` - (Required) Specify the desired Kafka software version. (`default = 2.3.1`)
- `msk_cluster_number_of_broker_nodes` - (Required) The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets. (`default = 3`)
- `msk_cluster_broker_node_group_info` - (Required) Configuration block for the broker nodes of the Kafka cluster. (`default = []`)
- `msk_cluster_encryption_info` - (Optional) Configuration block for specifying encryption. (`default = []`)
- `msk_cluster_client_authentication` - (Optional) Configuration block for specifying a client authentication. (`default = []`)
- `msk_cluster_configuration_info` - (Optional) Configuration block for specifying a MSK Configuration to attach to Kafka brokers. (`default = []`)
- `msk_cluster_open_monitoring` - Configuration block for settings for open monitoring. (`default = []`)
- `msk_cluster_logging_info` - (Optional) Configuration block for streaming broker logs to Cloudwatch/S3/Kinesis Firehose. (`default = []`)
- `msk_cluster_enhanced_monitoring` - (Optional) Specify the desired enhanced MSK CloudWatch monitoring level. Supports [DEFAULT PER_BROKER PER_TOPIC_PER_BROKER] (`default = null`)
- `enable_msk_configuration` - Enable msk configuration usage (`default = False`)
- `msk_configuration_name` - Name of the configuration. (`default = ""`)
- `msk_configuration_kafka_versions` - (Required) List of Apache Kafka versions which can use this configuration. (`default = ['2.1.0']`)
- `msk_configuration_server_properties` - (Required) List of Apache Kafka versions which can use this configuration. (`default = ['auto.create.topics.enable = true', 'delete.topic.enable = true']`)
- `msk_configuration_description` - (Optional) Description of the configuration. (`default = null`)
- `enable_msk_scram_secret_association` - Enable msk scram secret association usage (`default = False`)
- `msk_scram_secret_association_cluster_arn` - Amazon Resource Name (ARN) of the MSK cluster. (`default = ""`)
- `msk_scram_secret_association_secret_arn_list` - (Required) List of AWS Secrets Manager secret ARNs. (`default = []`)

## Module Output Variables
----------------------
- `msk_cluster_id` - Amazon Resource Name (ID) of the MSK cluster.
- `msk_cluster_arn` - Amazon Resource Name (ARN) of the MSK cluster.
- `msk_cluster_zookeeper_connect_string` - ""
- `msk_cluster_bootstrap_brokers` - Plaintext connection host:port pairs
- `msk_cluster_bootstrap_brokers_tls` - TLS connection host:port pairs
- `msk_cluster_encryption_info` - Outputs list with encryption info
- `msk_cluster_current_version` - Current version of the MSK Cluster used for updates, e.g. K13V1IB3VIYZZH
- `msk_configuration_id` - Amazon Resource Name (ID) of the configuration.
- `msk_configuration_arn` - Amazon Resource Name (ARN) of the configuration.
- `msk_configuration_latest_revision` - Latest revision of the configuration.
- `msk_scram_secret_association_id` - Amazon Resource Name (ARN) of the MSK cluster.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
