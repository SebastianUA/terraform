# Work with AWS Route53 via terraform

A terraform module for making Route53.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.11.11"
}

provider "aws" {
    region  = "us-west-2"
}

module "route53" {
    source                              = "../../modules/route53"
    name                                = "TEST-Route53"
    region                              = "us-west-2"
    environment                         = "PROD"
 
    enable_route53_zone                 = true
    domain_name_for_route53_zone        = "example.local"

    enable_route53_record               = true
    route53_record_type                 = "A"
    route53_record_ttl                  = 50
    route53_record_names                = ["192.168.0.113"]

    #Health_checks
    #create_http_route53_health_check    = "true"
    fqdn_for_http_route53_health_check       = "linux-notes.org"
    
    #create_https_route53_health_check   = "true"
    fqdn_for_https_route53_health_check = "linux-notes.org"
}
```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = "TEST-ASG"`).
- `region` - The region where to deploy this code (e.g. us-east-1) (`default = "us-east-1"`).
- `environment` - Environment for service (`default = "STAGE"`).
- `orchestration` - Type of orchestration (`default = "Terraform"`).
- `createdby` - Created by (`default = "Vitaliy Natarov"`).
- `enable_route53_zone` - If true, then create primary public route53 zone (`default  = "false"`).
- `domain_name_for_route53_zone` - Domain name for primary_public route53_zone (`default  = "domain.localdomain"`).
- `route53_zone_force_destroy` - (Optional) Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone (`default     = true`).
- `route53_zone_delegation_set_id` - (Optional) The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc and vpc_id as delegation sets can only be used for public zones (`default = ""`).
- `route53_zone_vpc_id` - (Required) ID of the VPC to associate (`default = ""`).
- `route53_zone_vpc_region` - (Optional) Region of the VPC to associate. Defaults to AWS provider region (`default = ""`).
- `enable_route53_record` - Enable route53 record usage (`default     = false`).
- `route53_record_names` - Route53 record name (`default     = []`).
- `route53_record_type` - The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT (`default = "A"`).
- `route53_record_ttl` - Route53 record ttl (`default     = "30"`).
- `parent_zone_id` - Perent Zone ID (`default = ""`).
- `target_dns_name` - Target DNS name which needs to add to route53 (`default = ""`).
- `target_zone_id` - Target Zone ID which needs to add to route53 (`default = ""`).
- `evaluate_target_health` - Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set (`default = "false"`).
- `set_identifier` - (Optional) Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below (`default     = ""`).
- `weighted_routing_policy_weight` - (Required) A numeric value indicating the relative weight of the record (`default     = ""`).
- `create_http_route53_health_check` - Create http route53 health check (`default = "false"`).
- `create_https_route53_health_check` - Create https route53 health check (`default = "false"`).
- `fqdn_for_http_route53_health_check` - FQDN for http route53 health check (`default = ""`).
- `fqdn_for_https_route53_health_check` - FQDN for https route53 health check (`default = ""`).
- `port_for_http_route53_health_check` - Port for http route53 health check (`default = "80"`).
- `port_for_https_route53_health_check` - Port for https route53 health check (`default = "443"`).
- `type_for_http_route53_health_check` - Type for http route53 health check (`default = "HTTP"`).
- `type_for_https_route53_health_check` - Type for https route53 health check (`default = "HTTPS"`).
- `resource_path_for_http_route53_health_check` - Resource path for http route53 health check (`default = "/"`).
- `resource_path_for_https_route53_health_check` - Resource path for https route53 health check (`default = "/"`).
- `failure_threshold_for_http_route53_health_check` - Failure threshold for http route53 health check (`default = "5"`).
- `failure_threshold_for_https_route53_health_check` - Failure threshold for https route53 health check (`default = "5"`).
- `request_interval_for_http_route53_health_check` - Request interval for http route53 health check (`default = "30"`).
- `request_interval_for_https_route53_health_check` - Request interval for https route53 health check (`default = "30"`).
- `measure_latency_for_http_route53_health_check` - The measure latency for http route53 health check (`default = "1"`).
- `measure_latency_for_https_route53_health_check` - The measure latency for https route53 health check (`default = "1"`).
- `create_calculated_route53_health_check` - Create calculated route53 health check (`default     = false`).
- `child_health_threshold_for_calculated_route53_health_check` - (Optional) The minimum number of child health checks that must be healthy for Route 53 to consider the parent health check to be healthy. Valid values are integers between 0 and 256, inclusive (`default     = 1`).
- `child_healthchecks_for_calculated_route53_health_check` - (Optional) For a specified parent health check, a list of HealthCheckId values for the associated child health checks (`default     = []`).
- `type_for_calculated_route53_health_check` - (Required) The protocol to use when performing health checks. Valid values are HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED and CLOUDWATCH_METRIC. But for this point you shoulf use CALCULATED (`default     = "CALCULATED"`).
- `create_cloudwatch_route53_health_check` - Create loudwatch route53 health check (`default     = false`).
- `type_for_cloudwatch_route53_health_check` - (Required) The protocol to use when performing health checks. Valid values are HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED and CLOUDWATCH_METRIC. But for this point you shoulf use CLOUDWATCH_METRIC (`default     = "CLOUDWATCH_METRIC"`).
- `cloudwatch_alarm_name_for_cloudwatch_route53_health_check` - (Optional) The name of the CloudWatch alarm (`default     = ""`).
- `cloudwatch_alarm_region_for_cloudwatch_route53_health_check` - (Optional) The CloudWatchRegion that the CloudWatch alarm was created in (`default     = "us-east-1"`).
- `insufficient_data_health_status_for_cloudwatch_route53_health_check` - (Optional) The status of the health check when CloudWatch has insufficient data about the state of associated alarm. Valid values are Healthy , Unhealthy and LastKnownStatus (`default     = "Healthy"`).
- `enable_route53_delegation_set` - Enable route53 delegation set (`default     = false`).
- `reference_name` - (Optional) This is a reference name used in Caller Reference (helpful for identifying single delegation set amongst others) - (`default     = "DynDNS"`).
- `enable_route53_zone_association` - Enable route53 zone association (`default     = false`).
- `route53_zone_association_zone_id` - (Required) The private hosted zone to associate (`default     = ""`).
- `route53_zone_association_vpc_id` - (Required) The VPC to associate with the private hosted zone (`default     = ""`).
- `route53_zone_association_vpc_region` - (Optional) The VPC's region. Defaults to the region of the AWS provider (`default     = ""`).
- `enable_route53_query_log` - Enable route53 query log (`default     = false`).
- `cloudwatch_log_group_arn` - (Required) CloudWatch log group ARN to send query logs (`default     = ""`).
- `route53_query_log_zone_id` - (Required) Route53 hosted zone ID to enable query logs (`default     = ""`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
