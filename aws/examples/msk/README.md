# Work with AWS MSK via terraform
                                
A terraform module for making manages AWS Managed Streaming for Kafka.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    profile                 = "default"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "msk" {
    source                                          = "../../modules/msk"
    region                                          = "us-east-1"
    environment                                     = "stage"

    enable_msk_cluster                              = true
    cluster_name                                    = ""
    kafka_version                                   = "2.3.1"
    number_of_broker_nodes                          = 3
    
    broker_node_group_info                          = [
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
} 

```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST-MSK"`).
- `region` - The region where to deploy this code (e.g. us-east-1). (`default     = "us-east-1"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default     = {}`).
- `enable_msk_cluster` - Enable AWS MSK usage (`default     = false`).
- `cluster_name` - (Required) Name of the MSK cluster. (`default     = ""`).
- `kafka_version` - (Required) Specify the desired Kafka software version. (`default     = "2.3.1"`).
- `number_of_broker_nodes` - (Required) The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets. (`  default     = 3`).
- `broker_node_group_info` - (Required) Configuration block for the broker nodes of the Kafka cluster. (`default       = []`).
- `encryption_in_transit_client_broker` - (Optional) Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT. Default value: TLS_PLAINTEXT. (`default     = "TLS_PLAINTEXT"`).
- `encryption_in_transit_in_cluster` - (Optional) Whether data communication among broker nodes is encrypted. Default value: true. (`default     = true`).
- `encryption_info_encryption_at_rest_kms_key_arn` - (Optional) You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest. If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest. (`default     = ""`).
- `client_authentication_certificate_authority_arns` - (Optional) List of ACM Certificate Authority Amazon Resource Names (ARNs). (`default     = []`).
- `configuration_info` - (Optional) Configuration block for specifying a MSK Configuration to attach to Kafka brokers. (`default       = []`).
- `enhanced_monitoring` - (Optional) Specify the desired enhanced MSK CloudWatch monitoring level. Supports: DEFAULT PER_BROKER PER_TOPIC_PER_BROKER (`default       = "DEFAULT"`).
- `enable_msk_configuration` - Enable mask configuration usage (`default     = false`).
- `msk_configuration_name` - Name of the configuration. (`default     = ""`).
- `kafka_versions` - (Required) List of Apache Kafka versions which can use this configuration. (`default     = ["2.1.0"]`).
- `msk_configuration_description` - (Optional) Description of the configuration. (`default     = ""`).
- `server_properties` - (Required) List of Apache Kafka versions which can use this configuration. (`default     = [
        "auto.create.topics.enable = true",
        "delete.topic.enable = true"]`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
