#-----------------------------------------------------------
# identity user
#-----------------------------------------------------------
output "identity_user_state" {
  description = "The user's current state."
  value       = element(concat(oci_identity_user.identity_user.*.state, [""]), 0)
}

output "identity_user_name" {
  description = "The name you assign to the user during creation. This is the user's login for the Console. The name must be unique across all users in the tenancy and cannot be changed."
  value       = element(concat(oci_identity_user.identity_user.*.name, [""]), 0)
}

output "identity_user_id" {
  description = "The OCID of the user."
  value       = element(concat(oci_identity_user.identity_user.*.id, [""]), 0)
}

output "identity_user_identity_provider_id" {
  description = "The OCID of the IdentityProvider this user belongs to."
  value       = element(concat(oci_identity_user.identity_user.*.identity_provider_id, [""]), 0)
}

output "identity_user_description" {
  description = "The description you assign to the user. Does not have to be unique, and it's changeable."
  value       = element(concat(oci_identity_user.identity_user.*.description, [""]), 0)
}

output "identity_user_email" {
  description = "The email address you assign to the user. The email address must be unique across all users in the tenancy."
  value       = element(concat(oci_identity_user.identity_user.*.email, [""]), 0)
}

output "identity_user_email_verified" {
  description = "Whether the email address has been validated."
  value       = element(concat(oci_identity_user.identity_user.*.email_verified, [""]), 0)
}

output "identity_user_external_identifier" {
  description = "Identifier of the user in the identity provider"
  value       = element(concat(oci_identity_user.identity_user.*.external_identifier, [""]), 0)
}

output "identity_user_compartment_id" {
  description = "The OCID of the tenancy containing the user."
  value       = element(concat(oci_identity_user.identity_user.*.compartment_id, [""]), 0)
}

output "identity_user_db_user_name" {
  description = "DB username of the DB credential. Has to be unique across the tenancy."
  value       = element(concat(oci_identity_user.identity_user.*.db_user_name, [""]), 0)
}

output "identity_user_capabilities" {
  description = "Properties indicating how the user is allowed to authenticate."
  value       = concat(oci_identity_user.identity_user.*.capabilities, [""])
}

#-----------------------------------------------------------
# identity domain
#-----------------------------------------------------------
output "identity_domain_type" {
  description = "The type of the domain."
  value       = element(concat(oci_identity_domain.identity_domain.*.type, [""]), 0)
}

output "identity_domain_url" {
  description = "Region agnostic domain URL."
  value       = element(concat(oci_identity_domain.identity_domain.*.url, [""]), 0)
}

output "identity_domain_state" {
  description = "The current state."
  value       = element(concat(oci_identity_domain.identity_domain.*.state, [""]), 0)
}

output "identity_domain_home_region" {
  description = "The home region for the domain. See Regions and Availability Domains for the full list of supported region names. Example: us-phoenix-1"
  value       = element(concat(oci_identity_domain.identity_domain.*.home_region, [""]), 0)
}

output "identity_domain_home_region_url" {
  description = "Region specific domain URL."
  value       = element(concat(oci_identity_domain.identity_domain.*.home_region_url, [""]), 0)
}

output "identity_domain_id" {
  description = "The OCID of the domain"
  value       = element(concat(oci_identity_domain.identity_domain.*.id, [""]), 0)
}

output "identity_domain_is_hidden_on_login" {
  description = "Indicates whether domain is hidden on login screen or not."
  value       = element(concat(oci_identity_domain.identity_domain.*.is_hidden_on_login, [""]), 0)
}

output "identity_domain_license_type" {
  description = "The License type of Domain"
  value       = element(concat(oci_identity_domain.identity_domain.*.license_type, [""]), 0)
}

output "identity_domain_lifecycle_details" {
  description = "Any additional details about the current state of the Domain."
  value       = element(concat(oci_identity_domain.identity_domain.*.lifecycle_details, [""]), 0)
}

output "identity_domain_compartment_id" {
  description = "The OCID of the compartment containing the domain."
  value       = element(concat(oci_identity_domain.identity_domain.*.compartment_id, [""]), 0)
}

output "identity_domain_description" {
  description = "The domain descripition"
  value       = element(concat(oci_identity_domain.identity_domain.*.description, [""]), 0)
}

output "identity_domain_display_name" {
  description = "The mutable display name of the domain"
  value       = element(concat(oci_identity_domain.identity_domain.*.display_name, [""]), 0)
}

#-----------------------------------------------------------
# identity user capabilities management
#-----------------------------------------------------------

output "identity_user_capabilities_management_user_id" {
  description = "The OCID of the user."
  value       = element(concat(oci_identity_user_capabilities_management.identity_user_capabilities_management.*.user_id, [""]), 0)
}

output "identity_user_capabilities_management_can_use_api_keys" {
  description = "Indicates if the user can use API keys."
  value       = element(concat(oci_identity_user_capabilities_management.identity_user_capabilities_management.*.can_use_api_keys, [""]), 0)
}

output "identity_user_capabilities_management_can_use_auth_tokens" {
  description = "Indicates if the user can use SWIFT passwords / auth tokens."
  value       = element(concat(oci_identity_user_capabilities_management.identity_user_capabilities_management.*.can_use_auth_tokens, [""]), 0)
}

output "identity_user_capabilities_management_can_use_console_password" {
  description = "Indicates if the user can log in to the console."
  value       = element(concat(oci_identity_user_capabilities_management.identity_user_capabilities_management.*.can_use_console_password, [""]), 0)
}

output "identity_user_capabilities_management_can_use_customer_secret_keys" {
  description = "Indicates if the user can use SigV4 symmetric keys."
  value       = element(concat(oci_identity_user_capabilities_management.identity_user_capabilities_management.*.can_use_customer_secret_keys, [""]), 0)
}

output "identity_user_capabilities_management_can_use_smtp_credentials" {
  description = "Indicates if the user can use SMTP passwords."
  value       = element(concat(oci_identity_user_capabilities_management.identity_user_capabilities_management.*.can_use_smtp_credentials, [""]), 0)
}

#-----------------------------------------------------------
# identity ui password
#-----------------------------------------------------------
output "identity_ui_password_inactive_status" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_ui_password.identity_ui_password.*.inactive_status, [""]), 0)
}

output "identity_ui_password_password" {
  description = "The user's password for the Console."
  value       = element(concat(oci_identity_ui_password.identity_ui_password.*.password, [""]), 0)
}

output "identity_ui_password_state" {
  description = "The password's current state."
  value       = element(concat(oci_identity_ui_password.identity_ui_password.*.state, [""]), 0)
}

output "identity_ui_password_user_id" {
  description = "The OCID of the user."
  value       = element(concat(oci_identity_ui_password.identity_ui_password.*.user_id, [""]), 0)
}

#-----------------------------------------------------------
# identity smtp credential
#-----------------------------------------------------------
output "identity_smtp_credential_description" {
  description = "The description you assign to the SMTP credential. Does not have to be unique, and it's changeable."
  value       = element(concat(oci_identity_smtp_credential.identity_smtp_credential.*.description, [""]), 0)
}

output "identity_smtp_credential_id" {
  description = "The OCID of the SMTP credential."
  value       = element(concat(oci_identity_smtp_credential.identity_smtp_credential.*.id, [""]), 0)
}

output "identity_smtp_credential_inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_smtp_credential.identity_smtp_credential.*.inactive_state, [""]), 0)
}

output "identity_smtp_credential_password" {
  description = "The SMTP password."
  value       = element(concat(oci_identity_smtp_credential.identity_smtp_credential.*.password, [""]), 0)
}

output "identity_smtp_credential_state" {
  description = "The credential's current state."
  value       = element(concat(oci_identity_smtp_credential.identity_smtp_credential.*.state, [""]), 0)
}

output "identity_smtp_credential_user_id" {
  description = "The OCID of the user the SMTP credential belongs to."
  value       = element(concat(oci_identity_smtp_credential.identity_smtp_credential.*.user_id, [""]), 0)
}

output "identity_smtp_credential_username" {
  description = "The SMTP user name."
  value       = element(concat(oci_identity_smtp_credential.identity_smtp_credential.*.username, [""]), 0)
}

#-----------------------------------------------------------
# identity db credential
#-----------------------------------------------------------
output "identity_db_credential_id" {
  description = "The OCID of the DB credential."
  value       = element(concat(oci_identity_db_credential.identity_db_credential.*.id, [""]), 0)
}

output "identity_db_credential_description" {
  description = "The description you assign to the DB credential. Does not have to be unique, and it's changeable."
  value       = element(concat(oci_identity_db_credential.identity_db_credential.*.description, [""]), 0)
}

output "identity_db_credential_lifecycle_details" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = concat(oci_identity_db_credential.identity_db_credential.*.lifecycle_details, [""])
}

output "identity_db_credential_state" {
  description = "The credential's current state. After creating a DB credential, make sure its lifecycleState changes from CREATING to ACTIVE before using it."
  value       = element(concat(oci_identity_db_credential.identity_db_credential.*.state, [""]), 0)
}

output "identity_db_credential_user_id" {
  description = "The OCID of the user the DB credential belongs to."
  value       = element(concat(oci_identity_db_credential.identity_db_credential.*.user_id, [""]), 0)
}

#-----------------------------------------------------------
# identity customer secret key
#-----------------------------------------------------------
output "identity_customer_secret_key_display_name" {
  description = "The display name you assign to the secret key. Does not have to be unique, and it's changeable."
  value       = element(concat(oci_identity_customer_secret_key.identity_customer_secret_key.*.display_name, [""]), 0)
}

output "identity_customer_secret_key_id" {
  description = "The access key portion of the key pair."
  value       = element(concat(oci_identity_customer_secret_key.identity_customer_secret_key.*.id, [""]), 0)
}

output "identity_customer_secret_key_inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_customer_secret_key.identity_customer_secret_key.*.inactive_state, [""]), 0)
}

output "identity_customer_secret_key_key" {
  description = "The secret key."
  value       = element(concat(oci_identity_customer_secret_key.identity_customer_secret_key.*.key, [""]), 0)
}

output "identity_customer_secret_key_state" {
  description = "The secret key's current state."
  value       = element(concat(oci_identity_customer_secret_key.identity_customer_secret_key.*.state, [""]), 0)
}

output "identity_customer_secret_key_user_id" {
  description = "The OCID of the user the password belongs to."
  value       = element(concat(oci_identity_customer_secret_key.identity_customer_secret_key.*.user_id, [""]), 0)
}

#-----------------------------------------------------------
# identity auth token
#-----------------------------------------------------------
output "identity_auth_token_description" {
  description = "The description you assign to the auth token. Does not have to be unique, and it's changeable."
  value       = element(concat(oci_identity_auth_token.identity_auth_token.*.description, [""]), 0)
}

output "identity_auth_token_id" {
  description = "The OCID of the auth token."
  value       = element(concat(oci_identity_auth_token.identity_auth_token.*.id, [""]), 0)
}

output "identity_auth_token_inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_auth_token.identity_auth_token.*.inactive_state, [""]), 0)
}

output "identity_auth_token_state" {
  description = "The token's current state."
  value       = element(concat(oci_identity_auth_token.identity_auth_token.*.state, [""]), 0)
}

output "identity_auth_token_token" {
  description = "The auth token. The value is available only in the response for CreateAuthToken, and not for ListAuthTokens or UpdateAuthToken."
  value       = element(concat(oci_identity_auth_token.identity_auth_token.*.token, [""]), 0)
}

output "identity_auth_token_user_id" {
  description = "The OCID of the user the auth token belongs to."
  value       = element(concat(oci_identity_auth_token.identity_auth_token.*.user_id, [""]), 0)
}

#-----------------------------------------------------------
# identity api key
#-----------------------------------------------------------
output "identity_api_key_fingerprint" {
  description = "The key's fingerprint (e.g., 12:34:56:78:90:ab:cd:ef:12:34:56:78:90:ab:cd:ef)."
  value       = element(concat(oci_identity_api_key.identity_api_key.*.fingerprint, [""]), 0)
}

output "identity_api_key_id" {
  description = "An Oracle-assigned identifier for the key, in this format: TENANCY_OCID/USER_OCID/KEY_FINGERPRINT."
  value       = element(concat(oci_identity_api_key.identity_api_key.*.id, [""]), 0)
}

output "identity_api_key_inactive_status" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_api_key.identity_api_key.*.inactive_status, [""]), 0)
}

output "identity_api_key_key_value" {
  description = "The key's value."
  value       = concat(oci_identity_api_key.identity_api_key.*.key_value, [""])
}

output "identity_api_key_state" {
  description = "state"
  value       = element(concat(oci_identity_api_key.identity_api_key.*.state, [""]), 0)
}

output "identity_api_key_user_id" {
  description = "The OCID of the user the key belongs to."
  value       = element(concat(oci_identity_api_key.identity_api_key.*.user_id, [""]), 0)
}
