# Work with ELASTICSEARCH via terraform

A terraform module for making ELASTICSEARCH.


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
  region                  = "us-west-2"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "elasticsearch_domain" {
  source = "../../modules/elasticsearch"

  # elasticsearch domain
  enable_elasticsearch_domain                = true
  elasticsearch_domain_name                  = "es-test-1"
  elasticsearch_domain_elasticsearch_version = "1.5"

  elasticsearch_domain_advanced_security_options = {}
  elasticsearch_domain_ebs_options = {
    ebs_enabled = true

    volume_type = "gp2"
    volume_size = 30
    iops        = 125
  }
  elasticsearch_domain_encrypt_at_rest         = {}
  elasticsearch_domain_node_to_node_encryption = {}
  elasticsearch_domain_cluster_config          = []
  elasticsearch_domain_vpc_options = {
    subnet_ids         = []
    security_group_ids = []
  }
  elasticsearch_domain_snapshot_options        = {}
  elasticsearch_domain_log_publishing_options  = {}
  elasticsearch_domain_cognito_options         = {}
  elasticsearch_domain_domain_endpoint_options = {}
  elasticsearch_domain_timeouts                = {}

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

module "elasticsearch_domain_policy" {
  source = "../../modules/elasticsearch"

  # elasticsearch domain policy
  enable_elasticsearch_domain_policy          = true
  elasticsearch_domain_policy_domain_name     = module.elasticsearch_domain.elasticsearch_domain_domain_name
  elasticsearch_domain_policy_access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Condition": {
                "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
            },
            "Resource": "${module.elasticsearch_domain.elasticsearch_domain_arn}/*"
        }
    ]
}
POLICIES

}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)
- `enable_elasticsearch_domain` - Enable elasticsearch domain usage (`default = False`)
- `elasticsearch_domain_name` - Name of the domain. (`default = ""`)
- `elasticsearch_domain_advanced_security_options` - (Optional) Options for fine-grained access control. (`default = {}`)
- `elasticsearch_domain_ebs_options` - (Optional) EBS related options, may be required based on chosen instance size. (`default = {}`)
- `elasticsearch_domain_encrypt_at_rest` - (Optional) Encrypt at rest options. Only available for certain instance types. (`default = {}`)
- `elasticsearch_domain_node_to_node_encryption` - (Optional) Node-to-node encryption options.  (`default = {}`)
- `elasticsearch_domain_cluster_config` - (Optional) Cluster configuration of the domain (`default = []`)
- `elasticsearch_domain_vpc_options` - (Optional) VPC related options. Adding or removing this configuration forces a new resource (documentation). (`default = {}`)
- `elasticsearch_domain_snapshot_options` - (Optional) Snapshot related options (`default = {}`)
- `elasticsearch_domain_log_publishing_options` - (Optional) Options for publishing slow and application logs to CloudWatch Logs. This block can be declared multiple times, for each log_type, within the same resource. (`default = {}`)
- `elasticsearch_domain_cognito_options` - (Optional) Options for authenticating Kibana with Cognito. (`default = {}`)
- `elasticsearch_domain_domain_endpoint_options` - (Optional) Domain endpoint HTTP(S) related options. (`default = {}`)
- `elasticsearch_domain_timeouts` - Set timeouts for elasticsearch domain (`default = {}`)
- `elasticsearch_domain_elasticsearch_version` - (Optional) The version of Elasticsearch to deploy. Defaults to 1.5 (`default = null`)
- `elasticsearch_domain_advanced_options` - (Optional) Key-value string pairs to specify advanced configuration options. Note that the values for these configuration options must be strings (wrapped in quotes) or they may be wrong and cause a perpetual diff, causing Terraform to want to recreate your Elasticsearch domain on every apply. (`default = null`)
- `elasticsearch_domain_access_policies` - (Optional) IAM policy document specifying the access policies for the domain (`default = null`)
- `enable_elasticsearch_domain_policy` - Enable elasticsearch domain policy usage (`default = False`)
- `elasticsearch_domain_policy_domain_name` - Name of the domain. (`default = ""`)
- `elasticsearch_domain_policy_access_policies` - (Optional) IAM policy document specifying the access policies for the domain (`default = null`)

## Module Output Variables
----------------------
- `elasticsearch_domain_id` - ID of elasticsearch domain policy
- `elasticsearch_domain_arn` - Amazon Resource Name (ARN) of the domain.
- `elasticsearch_domain_domain_id` - Unique identifier for the domain.
- `elasticsearch_domain_domain_name` - The name of the Elasticsearch domain.
- `elasticsearch_domain_endpoint` - Domain-specific endpoint used to submit index, search, and data upload requests.
- `elasticsearch_domain_kibana_endpoint` - Domain-specific endpoint for kibana without https scheme.
- `elasticsearch_domain_vpc_options` - Domain-specific endpoint for kibana without https scheme.
- `elasticsearch_domain_policy_id` - ID of elasticsearch domain policy


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
