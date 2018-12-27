#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-Route53"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}    
#---------------------------------------------------
# Route53 zone
#---------------------------------------------------
# Route53
variable "enable_route53_zone" {
    description = " If true, then create route53 zone;"
    default     = false
}

variable "domain_name_for_route53_zone" {
    description = " Domain name for route53_zone"
    default     = "domain.localdomain"
}

variable "route53_zone_force_destroy" {
    description = "(Optional) Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
    default     = true
}

variable "route53_zone_delegation_set_id" {
    description = "(Optional) The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc and vpc_id as delegation sets can only be used for public zones."
    default     = ""
}

variable "route53_zone_vpc_id" {
    description = "(Required) ID of the VPC to associate."
    default     = ""
}

variable "route53_zone_vpc_region" {
    description = "(Optional) Region of the VPC to associate. Defaults to AWS provider region."
    default     = ""
}

#---------------------------------------------------
# Route53 record 
#---------------------------------------------------
variable "enable_route53_record" {
    description = "Enable route53 record usage"
    default     = false
}

variable "route53_record_names" {
    description = "Route53 record name"
    type        = "list"
    default     = []
}

variable "route53_record_type" {
    description = "The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT"
    default     = "A"
}

variable "route53_record_ttl" {
    description = "Route53 record ttl"
    default     = "30"
}

variable "parent_zone_id" {
    description = "Perent Zone ID"
    default     = ""
}

variable "target_dns_name" {
    description = "Target DNS name which needs to add to route53"
    default     = ""
}

variable "target_zone_id" {
    description = "Target Zone ID which needs to add to route53"
    default     = ""
}

variable "evaluate_target_health" {
    description = "Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set"
    default     = "false"
}

variable "set_identifier" {
    description = "(Optional) Unique identifier to differentiate records with routing policies from one another. Required if using failover, geolocation, latency, or weighted routing policies documented below."
    default     = ""
}

variable "weighted_routing_policy_weight" {
    description = "(Required) A numeric value indicating the relative weight of the record."
    default     = ""
}
#---------------------------------------------------
# Route53 HC
#---------------------------------------------------
variable "create_http_route53_health_check" {
    description = "Create http route53 health check"
    default     = "false"
}

variable "create_https_route53_health_check" {
    description = "Create https route53 health check"
    default     = "false"
}

variable "fqdn_for_http_route53_health_check" {
    description = "FQDN for http route53 health check"
    default     = ""
}

variable "fqdn_for_https_route53_health_check" {
    description = "FQDN for https route53 health check"
    default     = ""
}

variable "port_for_http_route53_health_check" {
    description = "Port for http route53 health check"
    default     = "80"
}

variable "port_for_https_route53_health_check" {
    description = "Port for https route53 health check"
    default     = "443"
}

variable "type_for_http_route53_health_check" {
    description = "Type for http route53 health check"
    default     = "HTTP"
}

variable "type_for_https_route53_health_check" {
    description = "Type for https route53 health check"
    default     = "HTTPS"
}    

variable "resource_path_for_http_route53_health_check" {
    description = " Resource path for http route53 health check"
    default     = "/"
}

variable "resource_path_for_https_route53_health_check" {
    description = " Resource path for https route53 health check"
    default     = "/"
}

variable "failure_threshold_for_http_route53_health_check" {
    description = "Failure threshold for http route53 health check"
    default     = "5"
}

variable "failure_threshold_for_https_route53_health_check" {
    description = "Failure threshold for https route53 health check"
    default     = "5"
}

variable "request_interval_for_http_route53_health_check" {
    description = " Request interval for http route53 health check"
    default     = 30
}

variable "request_interval_for_https_route53_health_check" {
    description = " Request interval for https route53 health check"
    default     = 30
}

variable "measure_latency_for_http_route53_health_check" {
    description = "measure latency for http route53 health check"
    default     = "1"
}

variable "measure_latency_for_https_route53_health_check" {
    description = "measure latency for https route53 health check"
    default     = "1"
}

variable "create_calculated_route53_health_check" {
    description = "Create calculated route53 health check"
    default     = false
}

variable "child_health_threshold_for_calculated_route53_health_check" {
    description = "(Optional) The minimum number of child health checks that must be healthy for Route 53 to consider the parent health check to be healthy. Valid values are integers between 0 and 256, inclusive"
    default     = 1
}

variable "child_healthchecks_for_calculated_route53_health_check" {
    description = "(Optional) For a specified parent health check, a list of HealthCheckId values for the associated child health checks."
    type        = "list"
    default     = []
}

variable "type_for_calculated_route53_health_check" {
    description = "(Required) The protocol to use when performing health checks. Valid values are HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED and CLOUDWATCH_METRIC. But for this point you shoulf use CALCULATED."
    default     = "CALCULATED"
}

variable "create_cloudwatch_route53_health_check" {
    description = "Create loudwatch route53 health check"
    default     = false
}

variable "type_for_cloudwatch_route53_health_check" {
    description = "(Required) The protocol to use when performing health checks. Valid values are HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED and CLOUDWATCH_METRIC. But for this point you shoulf use CLOUDWATCH_METRIC"
    default     = "CLOUDWATCH_METRIC"
}

variable "cloudwatch_alarm_name_for_cloudwatch_route53_health_check" {
    description = "(Optional) The name of the CloudWatch alarm."
    default     = ""
}

variable "cloudwatch_alarm_region_for_cloudwatch_route53_health_check" {
    description = "(Optional) The CloudWatchRegion that the CloudWatch alarm was created in."
    default     = "us-east-1"
}

variable "insufficient_data_health_status_for_cloudwatch_route53_health_check" {
    description = "(Optional) The status of the health check when CloudWatch has insufficient data about the state of associated alarm. Valid values are Healthy , Unhealthy and LastKnownStatus."
    default     = "Healthy"
}

#---------------------------------------------------
# Route53 delegation set
#---------------------------------------------------
variable "enable_route53_delegation_set" {
    description = "Enable route53 delegation set"
    default     = false
}

variable "reference_name" {
    description = "(Optional) This is a reference name used in Caller Reference (helpful for identifying single delegation set amongst others)"
    default     = "DynDNS"
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
    description = "Enable route53 query log"
    default     = false
}

variable "cloudwatch_log_group_arn" {
    description = "(Required) CloudWatch log group ARN to send query logs."
    default     = ""
}

variable "route53_query_log_zone_id" {
    description = "(Required) Route53 hosted zone ID to enable query logs."
    default     = ""
}



