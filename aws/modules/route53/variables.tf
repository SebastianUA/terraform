#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# Route53 zone
#---------------------------------------------------
variable "enable_route53_zone" {
  description = "If true, then create route53 zone"
  default     = false
}

variable "route53_zone_name" {
  description = "Domain name for route53_zone"
  default     = "domain.localdomain"
}

variable "route53_zone_comment" {
  description = "(Optional) A comment for the hosted zone. Defaults to 'Managed by Terraform'."
  default     = null
}

variable "route53_zone_force_destroy" {
  description = "(Optional) Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
  default     = null
}

variable "route53_zone_delegation_set_id" {
  description = "(Optional) The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc and vpc_id as delegation sets can only be used for public zones."
  default     = null
}

variable "route53_zone_vpc" {
  description = "(Optional) Configuration block(s) specifying VPC(s) to associate with a private hosted zone. Conflicts with the delegation_set_id argument in this resource and any aws_route53_zone_association resource specifying the same zone ID."
  default     = []
}

#---------------------------------------------------
# Route53 record
#---------------------------------------------------
variable "enable_route53_record" {
  description = "Enable route53 record usage"
  default     = false
}

variable "route53_record_name" {
  description = "Route53 record name"
  default     = null
}

variable "route53_record_type" {
  description = "The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT"
  default     = "A"
}

variable "route53_record_ttl" {
  description = "Route53 record ttl"
  default     = null
}

variable "route53_record_parent_zone_id" {
  description = "Perent Zone ID"
  default     = ""
}

variable "route53_record_alias" {
  description = "(Optional) An alias block. Conflicts with route53_record_ttl & route53_record_records."
  default     = []
}

variable "route53_record_records" {
  description = "(Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \\ inside the Terraform configuration string."
  default     = []
}

variable "route53_record_set_identifier" {
  description = "(Optional) Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below."
  default     = null
}

variable "route53_record_weighted_routing_policy" {
  description = "(Optional) A block indicating a weighted routing policy. Conflicts with any other routing policy."
  default     = []
}

variable "route53_record_health_check_id" {
  description = "(Optional) The health check the record should be associated with."
  default     = null
}

variable "route53_record_failover_routing_policy" {
  description = "(Optional) A block indicating the routing behavior when associated health check fails. Conflicts with any other routing policy."
  default     = []
}

variable "route53_record_geolocation_routing_policy" {
  description = "(Optional) A block indicating a routing policy based on the geolocation of the requestor. Conflicts with any other routing policy."
  default     = []
}

variable "route53_record_latency_routing_policy" {
  description = "(Optional) A block indicating a routing policy based on the latency between the requestor and an AWS region. Conflicts with any other routing policy."
  default     = []
}

variable "route53_record_multivalue_answer_routing_policy" {
  description = "(Optional) Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy."
  default     = null
}

variable "route53_record_allow_overwrite" {
  description = "(Optional) Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments."
  default     = false
}

#---------------------------------------------------
# Route53 HC
#---------------------------------------------------
variable "enable_route53_health_check" {
  description = "Create http route53 health check"
  default     = false
}

variable "route53_health_check_name" {
  description = "Name for route53 HC"
  default     = ""
}

variable "route53_health_check_type" {
  description = "(Required) The protocol to use when performing health checks. Valid values are HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED and CLOUDWATCH_METRIC."
  default     = "HTTP"
}

variable "route53_health_check_failure_threshold" {
  description = "(Required) Failure threshold for http route53 health check"
  default     = null
}

variable "route53_health_check_request_interval" {
  description = "(Required) Request interval for http route53 health check"
  default     = null
}

variable "route53_health_check_fqdn" {
  description = "FQDN for http route53 health check"
  default     = null
}

variable "route53_health_check_port" {
  description = "Port for http route53 health check"
  default     = null
}

variable "route53_health_check_resource_path" {
  description = "(Optional) Resource path for http route53 health check"
  default     = null
}

variable "route53_health_check_measure_latency" {
  description = "(Optional) measure latency for http route53 health check"
  default     = null
}

variable "route53_health_check_child_health_threshold" {
  description = "(Optional) The minimum number of child health checks that must be healthy for Route 53 to consider the parent health check to be healthy. Valid values are integers between 0 and 256, inclusive"
  default     = null
}

variable "route53_health_check_child_healthchecks" {
  description = "(Optional) For a specified parent health check, a list of HealthCheckId values for the associated child health checks."
  default     = null
}

variable "route53_health_check_cloudwatch_alarm_name" {
  description = "(Optional) The name of the CloudWatch alarm."
  default     = null
}

variable "route53_health_check_cloudwatch_alarm_region" {
  description = "(Optional) The CloudWatchRegion that the CloudWatch alarm was created in."
  default     = null
}

variable "route53_health_check_insufficient_data_health_status" {
  description = "(Optional) The status of the health check when CloudWatch has insufficient data about the state of associated alarm. Valid values are Healthy , Unhealthy and LastKnownStatus."
  default     = null
}

variable "route53_health_check_disabled" {
  description = "(Optional) A boolean value that stops Route 53 from performing health checks. "
  default     = null
}

variable "route53_health_check_reference_name" {
  description = "(Optional) This is a reference name used in Caller Reference (helpful for identifying single health_check set amongst others)"
  default     = null
}

variable "route53_health_check_ip_address" {
  description = "(Optional) The IP address of the endpoint to be checked."
  default     = null
}

variable "route53_health_check_search_string" {
  description = "(Optional) String searched in the first 5120 bytes of the response body for check to be considered healthy. Only valid with HTTP_STR_MATCH and HTTPS_STR_MATCH."
  default     = null
}

variable "route53_health_check_invert_healthcheck" {
  description = "(Optional) A boolean value that indicates whether the status of health check should be inverted. For example, if a health check is healthy but Inverted is True , then Route 53 considers the health check to be unhealthy."
  default     = null
}

variable "route53_health_check_enable_sni" {
  description = "(Optional) A boolean value that indicates whether Route53 should send the fqdn to the endpoint when performing the health check. This defaults to AWS' defaults: when the type is 'HTTPS' enable_sni defaults to true, when type is anything else enable_sni defaults to false."
  default     = null
}

variable "route53_health_check_regions" {
  description = "(Optional) A list of AWS regions that you want Amazon Route 53 health checkers to check the specified endpoint from."
  default     = null
}

#---------------------------------------------------
# Route53 delegation set
#---------------------------------------------------
variable "enable_route53_delegation_set" {
  description = "Enable route53 delegation set usage"
  default     = false
}

variable "route53_delegation_set_reference_name" {
  description = "(Optional) This is a reference name used in Caller Reference (helpful for identifying single delegation set amongst others)"
  default     = null
}

#---------------------------------------------------
# Route53 zone association
#---------------------------------------------------
variable "enable_route53_zone_association" {
  description = "Enable route53 zone association"
  default     = false
}

variable "route53_zone_association_zone_id" {
  description = "(Required) The private hosted zone to associate."
  default     = ""
}

variable "route53_zone_association_vpc_id" {
  description = "(Required) The VPC to associate with the private hosted zone."
  default     = ""
}

variable "route53_zone_association_vpc_region" {
  description = "(Optional) The VPC's region. Defaults to the region of the AWS provider."
  default     = ""
}

#---------------------------------------------------
# Route53 query log
#---------------------------------------------------
variable "enable_route53_query_log" {
  description = "Enable route53 query log usage"
  default     = false
}

variable "route53_query_log_cloudwatch_log_group_arn" {
  description = "(Required) CloudWatch log group ARN to send query logs."
  default     = ""
}

variable "route53_query_log_zone_id" {
  description = "(Required) Route53 hosted zone ID to enable query logs."
  default     = ""
}

#---------------------------------------------------
# AWS route53 vpc association authorization
#---------------------------------------------------
variable "enable_route53_vpc_association_authorization" {
  description = "Enable route53 vpc association authorization usage"
  default     = false
}

variable "route53_vpc_association_authorization_zone_id" {
  description = "(Required) The private hosted zone to associate."
  default     = ""
}

variable "route53_vpc_association_authorization_vpc_id" {
  description = "(Required) The VPC to associate with the private hosted zone."
  default     = ""
}

#---------------------------------------------------
# AWS Route53 key signing key
#---------------------------------------------------
variable "enable_route53_key_signing_key" {
  description = "Enable Route53 key signing key usage"
  default     = false
}

variable "route53_key_signing_key_name" {
  description = "Name of the key-signing key (KSK). Must be unique for each key-singing key in the same hosted zone."
  default     = ""
}

variable "route53_key_signing_key_hosted_zone_id" {
  description = "Identifier of the Route 53 Hosted Zone."
  default     = ""
}

variable "route53_key_signing_key_key_management_service_arn" {
  description = "(Required) Amazon Resource Name (ARN) of the Key Management Service (KMS) Key. This must be unique for each key-signing key (KSK) in a single hosted zone. This key must be in the us-east-1 Region and meet certain requirements, which are described in the Route 53 Developer Guide and Route 53 API Reference."
  default     = null
}

variable "route53_key_signing_key_status" {
  description = "(Optional) Status of the key-signing key (KSK). Valid values: ACTIVE, INACTIVE. Defaults to ACTIVE"
  default     = null
}