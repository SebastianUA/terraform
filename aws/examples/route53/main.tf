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
    #fqdn_for_http_route53_health_check       = "linux-notes.org"
    
    #create_https_route53_health_check   = "true"
    #fqdn_for_https_route53_health_check = "linux-notes.org"
}
