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