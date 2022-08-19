# Work with ROUTE53 via terraform

A terraform module for making ROUTE53.


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

module "route53" {
  source = "../../modules/route53"

  name        = "TEST-Route53"
  environment = "stage"

  # Route53 zone
  enable_route53_zone = true
  route53_zone_name   = "linux-notes.local"

  # Route53 record
  enable_route53_record  = true
  route53_record_type    = "A"
  route53_record_name    = "linux-notes.org"
  route53_record_ttl     = 300
  route53_record_records = ["192.168.0.113"]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "route53_cname" {
  source = "../../modules/route53"

  name        = "TEST-Route53"
  environment = "stage"

  # Route53 record
  enable_route53_record         = true
  route53_record_type           = "CNAME"
  route53_record_parent_zone_id = "Z16BBBIER89NH9"
  route53_record_name           = "test.internal.linux-notes.org"
  route53_record_ttl            = 300
  route53_record_records = [
    rds-mysql.crkkvblobbbp.us-east-1.rds.amazonaws.com
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = []
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
- `enable_route53_vpc_association_authorization` - Enable route53 vpc association authorization usage (`default = False`)
- `route53_vpc_association_authorization_zone_id` - (Required) The private hosted zone to associate. (`default = ""`)
- `route53_vpc_association_authorization_vpc_id` - (Required) The VPC to associate with the private hosted zone. (`default = ""`)
- `enable_route53_key_signing_key` - Enable Route53 key signing key usage (`default = False`)
- `route53_key_signing_key_name` - Name of the key-signing key (KSK). Must be unique for each key-singing key in the same hosted zone. (`default = ""`)
- `route53_key_signing_key_hosted_zone_id` - Identifier of the Route 53 Hosted Zone. (`default = ""`)
- `route53_key_signing_key_key_management_service_arn` - (Required) Amazon Resource Name (ARN) of the Key Management Service (KMS) Key. This must be unique for each key-signing key (KSK) in a single hosted zone. This key must be in the us-east-1 Region and meet certain requirements, which are described in the Route 53 Developer Guide and Route 53 API Reference. (`default = null`)
- `route53_key_signing_key_status` - (Optional) Status of the key-signing key (KSK). Valid values: ACTIVE, INACTIVE. Defaults to ACTIVE (`default = null`)

## Module Output Variables
----------------------
- `aws_route53_zone_id` - The Hosted Zone ID. This can be referenced by zone records.
- `aws_route53_zone_zone_id` - The Hosted Zone ID. This can be referenced by zone records.
- `aws_route53_zone_name_servers` - A list of name servers in associated (or default) delegation set. Find more about delegation sets in AWS docs.
- `route53_record_name` - Get route53 record name
- `route53_record_fqdn` - FQDN built using the zone domain and name.
- `route53_delegation_set_id` - The delegation set ID
- `route53_delegation_set_name_servers` - A list of authoritative name servers for the hosted zone (effectively a list of NS records).
- `route53_zone_association_id` - The calculated unique identifier for the association.
- `route53_zone_association_zone_id` - The ID of the hosted zone for the association.
- `route53_zone_association_vpc_id` - The ID of the VPC for the association.
- `route53_zone_association_vpc_region` - The region in which the VPC identified by vpc_id was created.
- `route53_query_log_id` - The query logging configuration ID
- `route53_health_check_id` - The query logging configuration ID
- `route53_vpc_association_authorization_id` - The calculated unique identifier for the association.
- `route53_key_signing_key_id` - Route 53 Hosted Zone identifier and KMS Key identifier, separated by a comma (,).
- `route53_key_signing_key_digest_algorithm_mnemonic` - A string used to represent the delegation signer digest algorithm. This value must follow the guidelines provided by RFC-8624 Section 3.3.
- `route53_key_signing_key_digest_algorithm_type` - An integer used to represent the delegation signer digest algorithm. This value must follow the guidelines provided by RFC-8624 Section 3.3.
- `route53_key_signing_key_digest_value` - A cryptographic digest of a DNSKEY resource record (RR). DNSKEY records are used to publish the public key that resolvers can use to verify DNSSEC signatures that are used to secure certain kinds of information provided by the DNS system.
- `route53_key_signing_key_dnskey_record` - A string that represents a DNSKEY record.
- `route53_key_signing_key_ds_record` - A string that represents a delegation signer (DS) record.
- `route53_key_signing_key_flag` - An integer that specifies how the key is used. For key-signing key (KSK), this value is always 257.
- `route53_key_signing_key_key_tag` - An integer used to identify the DNSSEC record for the domain name. The process used to calculate the value is described in RFC-4034 Appendix B.
- `route53_key_signing_key_public_key` - The public key, represented as a Base64 encoding, as required by RFC-4034 Page 5.
- `route53_key_signing_key_signing_algorithm_mnemonic` - A string used to represent the signing algorithm. This value must follow the guidelines provided by RFC-8624 Section 3.1.
- `route53_key_signing_key_signing_algorithm_type` - An integer used to represent the signing algorithm. This value must follow the guidelines provided by RFC-8624 Section 3.1.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
