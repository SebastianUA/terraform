# Work with ROUTE53_RESOLVER via terraform

A terraform module for making ROUTE53_RESOLVER.


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
  region = "us-west-2"
}

module "route53_resolver" {
  source = "../../modules/route53_resolver"

  name        = "TEST-Route53"
  environment = "stage"

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
- `enable_route53_zone` - If true, then create route53 zone (`default = False`)
- `route53_zone_name` - Domain name for route53_zone (`default = domain.localdomain`)
- `route53_zone_comment` - (Optional) A comment for the hosted zone. Defaults to 'Managed by Terraform'. (`default = null`)
- `route53_zone_force_destroy` - (Optional) Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. (`default = null`)
- `route53_zone_delegation_set_id` - (Optional) The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc and vpc_id as delegation sets can only be used for public zones. (`default = null`)
- `route53_zone_vpc` - (Optional) Configuration block(s) specifying VPC(s) to associate with a private hosted zone. Conflicts with the delegation_set_id argument in this resource and any aws_route53_zone_association resource specifying the same zone ID. (`default = []`)
- `enable_route53_record` - Enable route53 record usage (`default = False`)
- `route53_record_name` - Route53 record name (`default = null`)
- `route53_record_type` - The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT (`default = A`)
- `route53_record_ttl` - Route53 record ttl (`default = null`)
- `route53_record_parent_zone_id` - Perent Zone ID (`default = ""`)
- `route53_record_alias` - (Optional) An alias block. Conflicts with route53_record_ttl & route53_record_records. (`default = []`)
- `route53_record_records` - (Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \\ inside the Terraform configuration string. (`default = []`)
- `route53_record_set_identifier` - (Optional) Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below. (`default = null`)
- `route53_record_weighted_routing_policy` - (Optional) A block indicating a weighted routing policy. Conflicts with any other routing policy. (`default = []`)
- `route53_record_health_check_id` - (Optional) The health check the record should be associated with. (`default = null`)
- `route53_record_failover_routing_policy` - (Optional) A block indicating the routing behavior when associated health check fails. Conflicts with any other routing policy. (`default = []`)
- `route53_record_geolocation_routing_policy` - (Optional) A block indicating a routing policy based on the geolocation of the requestor. Conflicts with any other routing policy. (`default = []`)
- `route53_record_latency_routing_policy` - (Optional) A block indicating a routing policy based on the latency between the requestor and an AWS region. Conflicts with any other routing policy. (`default = []`)
- `route53_record_multivalue_answer_routing_policy` - (Optional) Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy. (`default = null`)
- `route53_record_allow_overwrite` - (Optional) Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments. (`default = False`)
- `enable_route53_health_check` - Create http route53 health check (`default = False`)
- `route53_health_check_name` - Name for route53 HC (`default = ""`)
- `route53_health_check_type` - (Required) The protocol to use when performing health checks. Valid values are HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED and CLOUDWATCH_METRIC. (`default = HTTP`)
- `route53_health_check_failure_threshold` - (Required) Failure threshold for http route53 health check (`default = null`)
- `route53_health_check_request_interval` - (Required) Request interval for http route53 health check (`default = null`)
- `route53_health_check_fqdn` - FQDN for http route53 health check (`default = null`)
- `route53_health_check_port` - Port for http route53 health check (`default = null`)
- `route53_health_check_resource_path` - (Optional) Resource path for http route53 health check (`default = null`)
- `route53_health_check_measure_latency` - (Optional) measure latency for http route53 health check (`default = null`)
- `route53_health_check_child_health_threshold` - (Optional) The minimum number of child health checks that must be healthy for Route 53 to consider the parent health check to be healthy. Valid values are integers between 0 and 256, inclusive (`default = null`)
- `route53_health_check_child_healthchecks` - (Optional) For a specified parent health check, a list of HealthCheckId values for the associated child health checks. (`default = null`)
- `route53_health_check_cloudwatch_alarm_name` - (Optional) The name of the CloudWatch alarm. (`default = null`)
- `route53_health_check_cloudwatch_alarm_region` - (Optional) The CloudWatchRegion that the CloudWatch alarm was created in. (`default = null`)
- `route53_health_check_insufficient_data_health_status` - (Optional) The status of the health check when CloudWatch has insufficient data about the state of associated alarm. Valid values are Healthy , Unhealthy and LastKnownStatus. (`default = null`)
- `route53_health_check_disabled` - (Optional) A boolean value that stops Route 53 from performing health checks.  (`default = null`)
- `route53_health_check_reference_name` - (Optional) This is a reference name used in Caller Reference (helpful for identifying single health_check set amongst others) (`default = null`)
- `route53_health_check_ip_address` - (Optional) The IP address of the endpoint to be checked. (`default = null`)
- `route53_health_check_search_string` - (Optional) String searched in the first 5120 bytes of the response body for check to be considered healthy. Only valid with HTTP_STR_MATCH and HTTPS_STR_MATCH. (`default = null`)
- `route53_health_check_invert_healthcheck` - (Optional) A boolean value that indicates whether the status of health check should be inverted. For example, if a health check is healthy but Inverted is True , then Route 53 considers the health check to be unhealthy. (`default = null`)
- `route53_health_check_enable_sni` - (Optional) A boolean value that indicates whether Route53 should send the fqdn to the endpoint when performing the health check. This defaults to AWS' defaults: when the type is 'HTTPS' enable_sni defaults to true, when type is anything else enable_sni defaults to false. (`default = null`)
- `route53_health_check_regions` - (Optional) A list of AWS regions that you want Amazon Route 53 health checkers to check the specified endpoint from. (`default = null`)
- `enable_route53_delegation_set` - Enable route53 delegation set usage (`default = False`)
- `route53_delegation_set_reference_name` - (Optional) This is a reference name used in Caller Reference (helpful for identifying single delegation set amongst others) (`default = null`)
- `enable_route53_zone_association` - Enable route53 zone association (`default = False`)
- `route53_zone_association_zone_id` - (Required) The private hosted zone to associate. (`default = ""`)
- `route53_zone_association_vpc_id` - (Required) The VPC to associate with the private hosted zone. (`default = ""`)
- `route53_zone_association_vpc_region` - (Optional) The VPC's region. Defaults to the region of the AWS provider. (`default = ""`)
- `enable_route53_query_log` - Enable route53 query log usage (`default = False`)
- `route53_query_log_cloudwatch_log_group_arn` - (Required) CloudWatch log group ARN to send query logs. (`default = ""`)
- `route53_query_log_zone_id` - (Required) Route53 hosted zone ID to enable query logs. (`default = ""`)
- `enable_route53_resolver_endpoint` - Enable route53 resolver endpoint usage (`default = False`)
- `route53_resolver_endpoint_name` - (Optional) The friendly name of the Route 53 Resolver endpoint. (`default = ""`)
- `route53_resolver_endpoint_direction` - (Required) The direction of DNS queries to or from the Route 53 Resolver endpoint. Valid values are INBOUND (resolver forwards DNS queries to the DNS service for a VPC from your network or another VPC) or OUTBOUND (resolver forwards DNS queries from the DNS service for a VPC to your network or another VPC). (`default = ""`)
- `route53_resolver_endpoint_security_group_ids` - (Required) The ID of one or more security groups that you want to use to control access to this VPC. (`default = []`)
- `route53_resolver_endpoint_ip_address` - (Required) The subnets and IP addresses in your VPC that you want DNS queries to pass through on the way from your VPCs to your network (for outbound endpoints) or on the way from your network to your VPCs (for inbound endpoints). (`default = []`)
- `route53_resolver_endpoint_timeouts` - Set timeouts for route53 resolver endpoint (`default = {}`)
- `enable_route53_resolver_rule_association` - Enable route53 resolver rule association usage (`default = False`)
- `route53_resolver_rule_association_name` - (Optional) A name for the association that you're creating between a resolver rule and a VPC. (`default = ""`)
- `route53_resolver_rule_association_resolver_rule_id` - The ID of the resolver rule that you want to associate with the VPC. (`default = ""`)
- `route53_resolver_rule_association_vpc_id` - (Required) The ID of the VPC that you want to associate the resolver rule with. (`default = ""`)
- `enable_route53_resolver_rule` - Enable route53 resolver rule usage (`default = False`)
- `route53_resolver_rule_domain_name` - (Required) DNS queries for this domain name are forwarded to the IP addresses that are specified using target_ip (`default = ""`)
- `route53_resolver_rule_name` - (Optional) A friendly name that lets you easily find a rule in the Resolver dashboard in the Route 53 console. (`default = ""`)
- `route53_resolver_rule_rule_type` - (Required) The rule type. Valid values are FORWARD, SYSTEM and RECURSIVE. (`default = SYSTEM`)
- `route53_resolver_rule_resolver_endpoint_id` - (Optional) The ID of the outbound resolver endpoint that you want to use to route DNS queries to the IP addresses that you specify using target_ip. This argument should only be specified for FORWARD type rules. (`default = null`)
- `route53_resolver_rule_target_ip` - (Optional) Configuration block(s) indicating the IPs that you want Resolver to forward DNS queries to (documented below). This argument should only be specified for FORWARD type rules. (`default = []`)
- `enable_route53_vpc_association_authorization` - Enable route53 vpc association authorization usage (`default = False`)
- `route53_vpc_association_authorization_zone_id` - (Required) The private hosted zone to associate. (`default = ""`)
- `route53_vpc_association_authorization_vpc_id` - (Required) The VPC to associate with the private hosted zone. (`default = ""`)
- `enable_route53_key_signing_key` - Enable Route53 key signing key usage (`default = False`)
- `route53_key_signing_key_name` - Name of the key-signing key (KSK). Must be unique for each key-singing key in the same hosted zone. (`default = ""`)
- `route53_key_signing_key_hosted_zone_id` - Identifier of the Route 53 Hosted Zone. (`default = ""`)
- `route53_key_signing_key_key_management_service_arn` - (Required) Amazon Resource Name (ARN) of the Key Management Service (KMS) Key. This must be unique for each key-signing key (KSK) in a single hosted zone. This key must be in the us-east-1 Region and meet certain requirements, which are described in the Route 53 Developer Guide and Route 53 API Reference. (`default = null`)
- `route53_key_signing_key_status` - (Optional) Status of the key-signing key (KSK). Valid values: ACTIVE, INACTIVE. Defaults to ACTIVE (`default = null`)
- `enable_route53_resolver_dnssec_config` - Enable route53 resolver dnssec config usage (`default = False`)
- `route53_resolver_dnssec_config_resource_id` - (Required) The ID of the virtual private cloud (VPC) that you're updating the DNSSEC validation status for. (`default = null`)
- `enable_route53_resolver_query_log_config` - Enable route53 resolver query log config usage (`default = False`)
- `route53_resolver_query_log_config_name` - The name of the Route 53 Resolver query logging configuration. (`default = ""`)
- `route53_resolver_query_log_config_destination_arn` - (Required) The ARN of the resource that you want Route 53 Resolver to send query logs. You can send query logs to an S3 bucket, a CloudWatch Logs log group, or a Kinesis Data Firehose delivery stream. (`default = null`)
- `enable_route53_resolver_query_log_config_association` - Enable route53 resolver query log config association usage (`default = False`)
- `route53_resolver_query_log_config_association_resolver_query_log_config_id` - The ID of the Route 53 Resolver query logging configuration that you want to associate a VPC with. (`default = ""`)
- `route53_resolver_query_log_config_association_resource_id` - (Required) The ID of a VPC that you want this query logging configuration to log queries for. (`default = null`)

## Module Output Variables
----------------------
- `route53_resolver_endpoint_id` - The ID of the Route 53 Resolver endpoint.
- `route53_resolver_endpoint_arn` - The ARN of the Route 53 Resolver endpoint.
- `route53_resolver_endpoint_host_vpc_id` - The ID of the VPC that you want to create the resolver endpoint in.
- `route53_resolver_rule_association_id` - The ID of the resolver rule association.
- `route53_resolver_rule_id` - The ID of the resolver rule.
- `route53_resolver_rule_arn` - The ARN (Amazon Resource Name) for the resolver rule.
- `route53_resolver_rule_owner_id` - When a rule is shared with another AWS account, the account ID of the account that the rule is shared with.
- `route53_resolver_rule_share_status` - Whether the rules is shared and, if so, whether the current account is sharing the rule with another account, or another account is sharing the rule with the current account. Values are NOT_SHARED, SHARED_BY_ME or SHARED_WITH_ME
- `route53_resolver_dnssec_config_id` - The ID for a configuration for DNSSEC validation.
- `route53_resolver_dnssec_config_arn` - The ARN for a configuration for DNSSEC validation.
- `route53_resolver_dnssec_config_owner_id` - The owner account ID of the virtual private cloud (VPC) for a configuration for DNSSEC validation.
- `route53_resolver_dnssec_config_validation_status` - The validation status for a DNSSEC configuration. The status can be one of the following: ENABLING, ENABLED, DISABLING and DISABLED.
- `route53_resolver_query_log_config_id` - The ID of the Route 53 Resolver query logging configuration.
- `route53_resolver_query_log_config_arn` - The ARN (Amazon Resource Name) of the Route 53 Resolver query logging configuration.
- `route53_resolver_query_log_config_owner_id` - The AWS account ID of the account that created the query logging configuration.
- `route53_resolver_query_log_config_share_status` - An indication of whether the query logging configuration is shared with other AWS accounts, or was shared with the current account by another AWS account. Sharing is configured through AWS Resource Access Manager (AWS RAM). Values are NOT_SHARED, SHARED_BY_ME or SHARED_WITH_ME
- `route53_resolver_query_log_config_association_id` - The ID of the Route 53 Resolver query logging configuration association.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
