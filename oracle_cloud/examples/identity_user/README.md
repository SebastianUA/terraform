# Work with IDENTITY_USER via terraform

A terraform module for making IDENTITY_USER.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.21.0"
    }
  }
}

provider "oci" {
  # config_file = var.provider_oci_config_file
  # profile     = var.provider_oci_profile

  fingerprint      = var.provider_oci_fingerprint
  private_key_path = var.provider_oci_private_key_path
  region           = var.provider_oci_region
  tenancy_ocid     = var.provider_oci_tenancy_ocid
  user_ocid        = var.provider_oci_user_ocid
}

module "identity_user" {
  source = "../../modules/identity_user"

  enable_identity_user = true

  identity_user_compartment_id = ""
  identity_user_description    = ""
  identity_user_name           = ""

  tags = {}
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `compartment_id` - (Required) (Updatable) The OCID of the compartment to (`default = null`)
- `tags` - Add additional tags (`default = {}`)
- `enable_identity_user` - Enable identity user usages (`default = False`)
- `identity_user_description` - (Required) (Updatable) The description you assign to the user during creation. Does not have to be unique, and it's changeable. (`default = null`)
- `identity_user_name` - The name you assign to the user during creation. This is the user's login for the Console. The name must be unique across all users in the tenancy and cannot be changed. (`default = ""`)
- `identity_user_email` - (Optional) (Updatable) The email you assign to the user. Has to be unique across the tenancy. (`default = null`)
- `identity_user_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `identity_user_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the User * update - (Defaults to 20 minutes), when updating the User * delete - (Defaults to 20 minutes), when destroying the User (`default = {}`)
- `enable_identity_domain` - Enable identity domain usages (`default = False`)
- `identity_domain_description` - (Required) (Updatable) Domain entity description (`default = null`)
- `identity_domain_display_name` - (Required) (Updatable) The mutable display name of the domain. (`default = null`)
- `identity_domain_home_region` - (Required) The region's name. See Regions and Availability Domains for the full list of supported region names. Example: us-phoenix-1 (`default = null`)
- `identity_domain_license_type` - (Required) The License type of Domain (`default = null`)
- `identity_domain_admin_email` - (Optional) The admin email address (`default = null`)
- `identity_domain_admin_first_name` - (Optional) The admin first name (`default = null`)
- `identity_domain_admin_last_name` - (Optional) The admin last name (`default = null`)
- `identity_domain_is_hidden_on_login` - (Optional) (Updatable) Indicates whether domain is hidden on login screen or not. (`default = null`)
- `identity_domain_is_notification_bypassed` - (Optional) Indicates if admin user created in IDCS stripe would like to receive notification like welcome email or not. Required field only if admin information is provided, otherwise optional. (`default = null`)
- `identity_domain_admin_user_name` - (Optional) The admin user name (`default = null`)
- `identity_domain_is_primary_email_required` - (Optional) Optional field to indicate whether users in the domain are required to have a primary email address or not Defaults to true (`default = null`)
- `identity_domain_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `identity_domain_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Domain * update - (Defaults to 20 minutes), when updating the Domain * delete - (Defaults to 20 minutes), when destroying the Domain (`default = {}`)
- `enable_identity_domain_replication_to_region` - Enable identity domain replication to region usages (`default = False`)
- `identity_domain_replication_to_region_domain_id` - The OCID of the domain (`default = ""`)
- `identity_domain_replication_to_region_replica_region` - (Optional) A region for which domain replication is requested for. See Regions and Availability Domains for the full list of supported region names. Example: us-phoenix-1 (`default = null`)
- `identity_domain_replication_to_region_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Domain Replication To Region * update - (Defaults to 20 minutes), when updating the Domain Replication To Region * delete - (Defaults to 20 minutes), when destroying the Domain Replication To Region (`default = {}`)
- `enable_identity_user_capabilities_management` - Enable identity user capabilities management usages (`default = False`)
- `identity_user_capabilities_management_user_id` - The OCID of the user. (`default = ""`)
- `identity_user_capabilities_management_can_use_api_keys` - (Optional) (Updatable) Indicates if the user can use API keys. (`default = null`)
- `identity_user_capabilities_management_can_use_auth_tokens` - (Optional) (Updatable) Indicates if the user can use SWIFT passwords / auth tokens. (`default = null`)
- `identity_user_capabilities_management_can_use_console_password` - (Optional) (Updatable) Indicates if the user can log in to the console. (`default = null`)
- `identity_user_capabilities_management_can_use_customer_secret_keys` - (Optional) (Updatable) Indicates if the user can use SigV4 symmetric keys. (`default = null`)
- `identity_user_capabilities_management_can_use_smtp_credentials` - (Optional) (Updatable) Indicates if the user can use SMTP passwords. (`default = null`)
- `enable_identity_ui_password` - Enable identity ui password usages (`default = False`)
- `identity_ui_password_user_id` - The OCID of the user. (`default = ""`)
- `identity_ui_password_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ui Password * update - (Defaults to 20 minutes), when updating the Ui Password * delete - (Defaults to 20 minutes), when destroying the Ui Password (`default = {}`)
- `enable_identity_smtp_credential` - Enable identity smtp credential usages (`default = False`)
- `identity_smtp_credential_description` - (Required) (Updatable) The description you assign to the SMTP credentials during creation. Does not have to be unique, and it's changeable. (`default = null`)
- `identity_smtp_credential_user_id` - The OCID of the user. (`default = ""`)
- `identity_smtp_credential_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Smtp Credential * update - (Defaults to 20 minutes), when updating the Smtp Credential * delete - (Defaults to 20 minutes), when destroying the Smtp Credential (`default = {}`)
- `enable_identity_db_credential` - Enable identity db credential usages (`default = False`)
- `identity_db_credential_description` - (Required) The description you assign to the DB credentials during creation. (`default = null`)
- `identity_db_credential_password` - (Required) The password for the DB credentials during creation. (`default = null`)
- `identity_db_credential_user_id` - The OCID of the user. (`default = ""`)
- `identity_db_credential_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Db Credential * update - (Defaults to 20 minutes), when updating the Db Credential * delete - (Defaults to 20 minutes), when destroying the Db Credential (`default = {}`)
- `enable_identity_customer_secret_key` - Enable identity customer secret key usages (`default = False`)
- `identity_customer_secret_key_display_name` - AAAAA (`default = null`)
- `identity_customer_secret_key_display_name` - (Required) (Updatable) The name you assign to the secret key during creation. Does not have to be unique, and it's changeable. (`default = ""`)
- `identity_customer_secret_key_user_id` - The OCID of the user. (`default = ""`)
- `identity_customer_secret_key_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Customer Secret Key * update - (Defaults to 20 minutes), when updating the Customer Secret Key * delete - (Defaults to 20 minutes), when destroying the Customer Secret Key (`default = {}`)
- `enable_identity_auth_token` - Enable identity auth token usages (`default = False`)
- `identity_auth_token_description` - (Required) (Updatable) The description you assign to the auth token during creation. Does not have to be unique, and it's changeable. (`default = null`)
- `identity_auth_token_user_id` - The OCID of the user. (`default = ""`)
- `identity_auth_token_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Auth Token * update - (Defaults to 20 minutes), when updating the Auth Token * delete - (Defaults to 20 minutes), when destroying the Auth Token (`default = {}`)
- `enable_identity_api_key` - Enable identity api key usages (`default = False`)
- `identity_api_key_key_value` - (Required) The public key. Must be an RSA key in PEM format. (`default = null`)
- `identity_api_key_user_id` - The OCID of the user. (`default = ""`)
- `identity_api_key_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Api Key * update - (Defaults to 20 minutes), when updating the Api Key * delete - (Defaults to 20 minutes), when destroying the Api Key (`default = {}`)

## Module Output Variables
----------------------
- `identity_user_state` - The user's current state.
- `identity_user_name` - The name you assign to the user during creation. This is the user's login for the Console. The name must be unique across all users in the tenancy and cannot be changed.
- `identity_user_id` - The OCID of the user.
- `identity_user_identity_provider_id` - The OCID of the IdentityProvider this user belongs to.
- `identity_user_description` - The description you assign to the user. Does not have to be unique, and it's changeable.
- `identity_user_email` - The email address you assign to the user. The email address must be unique across all users in the tenancy.
- `identity_user_email_verified` - Whether the email address has been validated.
- `identity_user_external_identifier` - Identifier of the user in the identity provider
- `identity_user_compartment_id` - The OCID of the tenancy containing the user.
- `identity_user_db_user_name` - DB username of the DB credential. Has to be unique across the tenancy.
- `identity_user_capabilities` - Properties indicating how the user is allowed to authenticate.
- `identity_domain_type` - The type of the domain.
- `identity_domain_url` - Region agnostic domain URL.
- `identity_domain_state` - The current state.
- `identity_domain_home_region` - The home region for the domain. See Regions and Availability Domains for the full list of supported region names. Example: us-phoenix-1
- `identity_domain_home_region_url` - Region specific domain URL.
- `identity_domain_id` - The OCID of the domain
- `identity_domain_is_hidden_on_login` - Indicates whether domain is hidden on login screen or not.
- `identity_domain_license_type` - The License type of Domain
- `identity_domain_lifecycle_details` - Any additional details about the current state of the Domain.
- `identity_domain_compartment_id` - The OCID of the compartment containing the domain.
- `identity_domain_description` - The domain descripition
- `identity_domain_display_name` - The mutable display name of the domain
- `identity_user_capabilities_management_user_id` - The OCID of the user.
- `identity_user_capabilities_management_can_use_api_keys` - Indicates if the user can use API keys.
- `identity_user_capabilities_management_can_use_auth_tokens` - Indicates if the user can use SWIFT passwords / auth tokens.
- `identity_user_capabilities_management_can_use_console_password` - Indicates if the user can log in to the console.
- `identity_user_capabilities_management_can_use_customer_secret_keys` - Indicates if the user can use SigV4 symmetric keys.
- `identity_user_capabilities_management_can_use_smtp_credentials` - Indicates if the user can use SMTP passwords.
- `identity_ui_password_inactive_status` - The detailed status of INACTIVE lifecycleState.
- `identity_ui_password_password` - The user's password for the Console.
- `identity_ui_password_state` - The password's current state.
- `identity_ui_password_user_id` - The OCID of the user.
- `identity_smtp_credential_description` - The description you assign to the SMTP credential. Does not have to be unique, and it's changeable.
- `identity_smtp_credential_id` - The OCID of the SMTP credential.
- `identity_smtp_credential_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_smtp_credential_password` - The SMTP password.
- `identity_smtp_credential_state` - The credential's current state.
- `identity_smtp_credential_user_id` - The OCID of the user the SMTP credential belongs to.
- `identity_smtp_credential_username` - The SMTP user name.
- `identity_db_credential_id` - The OCID of the DB credential.
- `identity_db_credential_description` - The description you assign to the DB credential. Does not have to be unique, and it's changeable.
- `identity_db_credential_lifecycle_details` - The detailed status of INACTIVE lifecycleState.
- `identity_db_credential_state` - The credential's current state. After creating a DB credential, make sure its lifecycleState changes from CREATING to ACTIVE before using it.
- `identity_db_credential_user_id` - The OCID of the user the DB credential belongs to.
- `identity_customer_secret_key_display_name` - The display name you assign to the secret key. Does not have to be unique, and it's changeable.
- `identity_customer_secret_key_id` - The access key portion of the key pair.
- `identity_customer_secret_key_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_customer_secret_key_key` - The secret key.
- `identity_customer_secret_key_state` - The secret key's current state.
- `identity_customer_secret_key_user_id` - The OCID of the user the password belongs to.
- `identity_auth_token_description` - The description you assign to the auth token. Does not have to be unique, and it's changeable.
- `identity_auth_token_id` - The OCID of the auth token.
- `identity_auth_token_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_auth_token_state` - The token's current state.
- `identity_auth_token_token` - The auth token. The value is available only in the response for CreateAuthToken, and not for ListAuthTokens or UpdateAuthToken.
- `identity_auth_token_user_id` - The OCID of the user the auth token belongs to.
- `identity_api_key_fingerprint` - The key's fingerprint (e.g., 12:34:56:78:90:ab:cd:ef:12:34:56:78:90:ab:cd:ef).
- `identity_api_key_id` - An Oracle-assigned identifier for the key, in this format: TENANCY_OCID/USER_OCID/KEY_FINGERPRINT.
- `identity_api_key_inactive_status` - The detailed status of INACTIVE lifecycleState.
- `identity_api_key_key_value` - The key's value.
- `identity_api_key_state` - state
- `identity_api_key_user_id` - The OCID of the user the key belongs to.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
