locals {
  name        = "captainua-global"
  environment = "prod"
  region      = "us-east-1"

  rds_security_group = "sg-0f9b50fc4e2f255ef"

  db_name     = "RdsGlobalcaptainua"
  db_username = "captainua_admin"
  db_password = var.db_password

  tags = tomap({
    "Environment"   = local.environment,
    "Createdby"     = "Vitalii Natarov",
    "Orchestration" = "Terraform"
  })
}