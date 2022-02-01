#---------------------------------------------------
# Vault auth backend
#---------------------------------------------------
resource "vault_auth_backend" "auth_backend" {
  count = var.enable_auth_backend ? 1 : 0

  type = var.auth_backend_type

  path        = var.auth_backend_path
  description = var.auth_backend_description
  local       = var.auth_backend_local

  dynamic "tune" {
    iterator = tune
    for_each = var.auth_backend_tune

    content {
      max_lease_ttl      = lookup(tune.value, "max_lease_ttl", null)
      listing_visibility = lookup(tune.value, "listing_visibility", null)

      default_lease_ttl            = lookup(tune.value, "default_lease_ttl", null)
      audit_non_hmac_response_keys = lookup(tune.value, "audit_non_hmac_response_keys", null)
      audit_non_hmac_request_keys  = lookup(tune.value, "audit_non_hmac_request_keys", null)
      passthrough_request_headers  = lookup(tune.value, "passthrough_request_headers", null)
      allowed_response_headers     = lookup(tune.value, "allowed_response_headers", null)
      token_type                   = lookup(tune.value, "token_type", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}