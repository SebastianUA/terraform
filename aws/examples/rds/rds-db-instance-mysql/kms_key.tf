#---------------------------------------------------------------
# AWS KMS
#---------------------------------------------------------------
module "kms_single_lhdb_mysql" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/kms?ref=v15.15.15"

  providers = {
    aws = aws.captainua_main
  }

  # KMS key
  enable_kms_key                  = true
  kms_key_name                    = "${local.name}-kms-key"
  kms_key_description             = "RDS Secret Encryption Key for ${local.name}"
  kms_key_deletion_window_in_days = 7
  kms_key_enable_key_rotation     = true

  tags = local.tags

  depends_on = []
}
