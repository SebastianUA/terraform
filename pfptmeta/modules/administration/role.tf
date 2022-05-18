#-----------------------------------------------------------
# ProofPoint Meta role
#-----------------------------------------------------------
resource "pfptmeta_role" "role" {
  count = var.enable_role ? 1 : 0

  name = var.role_name != "" ? var.role_name : "${lower(var.name)}-role-${lower(var.environment)}"

  description          = var.role_description
  all_read_privileges  = var.role_all_read_privileges
  all_suborgs          = var.role_all_suborgs
  all_write_privileges = var.role_all_write_privileges
  apply_to_orgs        = var.role_apply_to_orgs
  privileges           = var.role_privileges
  suborgs_expression   = var.role_suborgs_expression
}
