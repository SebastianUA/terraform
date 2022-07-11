# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Route53
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
module "route53_rds_single_mysql_cname" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/route53?ref=dev"

  providers = {
    aws = aws.captainua_main
  }

  name        = local.name
  environment = local.environment

  # Route53 record
  enable_route53_record         = true
  route53_record_type           = "CNAME"
  route53_record_parent_zone_id = "Z66BZRIEMM5NH9"
  route53_record_name           = "global-rds-us-east-1.internal.linux-notes.org"
  route53_record_ttl            = 300
  route53_record_records = [
    module.rds_single_mysql.db_instance_addresses
  ]

  tags = local.tags

  depends_on = [
    module.rds_single_mysql
  ]
}