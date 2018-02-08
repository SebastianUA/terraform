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
# Route53
variable "create_primary_public_route53_zone" {
    description = " If true, then create primary public route53 zone;"
    default     = "false"
}
variable "domain_name_for_primary_public_route53_zone" {
    description = " Domain name for primary_public route53_zone"
    default     = "domain.localdomain"
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
#variable "route53_record_ttl" {
#    description = "Route53 record ttl"
#    default     = "30"
#}
#variable "route53_record_records" {
#    description = "Route53 records"  
#    type        = "list"
#    default     = []
#}
#variable "route53_zone_private_zone_internal" {
#    description = " Internal or external zone"
#    default     = "false"
#}
variable "parent_zone_id" {
    description = "Perent Zone ID"
    default     = ""
}
variable "target_dns_name" {
    description = "Target DNS name which needs to add to route53"
    #type        = "list"
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

