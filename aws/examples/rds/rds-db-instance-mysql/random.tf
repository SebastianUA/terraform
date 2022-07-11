# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Random password
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
module "random_rds_single_mysql_password" {
  source = "git@github.com:SebastianUA/terraform.git//random/modules/random?ref=dev"

  # Generate random password
  enable_password           = true
  password_length           = 13
  password_special          = true
  password_override_special = "_%@"

  depends_on = []
}