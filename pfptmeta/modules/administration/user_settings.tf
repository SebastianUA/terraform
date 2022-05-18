#-----------------------------------------------------------
# ProofPoint Meta user settings
#-----------------------------------------------------------
resource "pfptmeta_user_settings" "user_settings" {
  count = var.enable_user_settings ? 1 : 0

  name = var.user_settings_name != "" ? var.user_settings_name : "${lower(var.name)}-user-settings-${lower(var.environment)}"

  description          = var.user_settings_description
  enabled              = var.user_settings_enabled
  allowed_factors      = var.user_settings_allowed_factors
  apply_on_org         = var.user_settings_apply_on_org
  apply_to_entities    = var.user_settings_apply_to_entities
  max_devices_per_user = var.user_settings_max_devices_per_user
  mfa_required         = var.user_settings_mfa_required
  password_expiration  = var.user_settings_password_expiration
  prohibited_os        = var.user_settings_prohibited_os
  proxy_pops           = var.user_settings_proxy_pops
  sso_mandatory        = var.user_settings_sso_mandatory
}
