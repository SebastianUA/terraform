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