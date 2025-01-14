#-----------------------------------------------------------
# identity user capabilities management
#-----------------------------------------------------------
resource "oci_identity_user_capabilities_management" "identity_user_capabilities_management" {
  count = var.enable_identity_user_capabilities_management ? 1 : 0

  # Required
  user_id = var.identity_user_capabilities_management_user_id != "" && !var.enable_identity_user ? var.identity_user_capabilities_management_user_id : (var.enable_identity_user ? element(oci_identity_user.identity_user.*.id, 0) : null)

  # Optional 
  can_use_api_keys             = var.identity_user_capabilities_management_can_use_api_keys
  can_use_auth_tokens          = var.identity_user_capabilities_management_can_use_auth_tokens
  can_use_console_password     = var.identity_user_capabilities_management_can_use_console_password
  can_use_customer_secret_keys = var.identity_user_capabilities_management_can_use_customer_secret_keys
  can_use_smtp_credentials     = var.identity_user_capabilities_management_can_use_smtp_credentials

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}