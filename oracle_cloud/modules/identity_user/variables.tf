#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# identity user
#-----------------------------------------------------------
variable "enable_identity_user" {
  description = "Enable identity user usages"
  default     = false
}

variable "identity_user_compartment_id" {
  description = "(Required) The OCID of the tenancy containing the user."
  default     = null
}

variable "identity_user_description" {
  description = "(Required) (Updatable) The description you assign to the user during creation. Does not have to be unique, and it's changeable."
  default     = null
}

variable "identity_user_name" {
  description = "The name you assign to the user during creation. This is the user's login for the Console. The name must be unique across all users in the tenancy and cannot be changed."
  default     = ""
}

variable "identity_user_email" {
  description = "(Optional) (Updatable) The email you assign to the user. Has to be unique across the tenancy."
  default     = null
}

variable "identity_user_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "identity_user_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the User * update - (Defaults to 20 minutes), when updating the User * delete - (Defaults to 20 minutes), when destroying the User"
  default     = {}
}

#-----------------------------------------------------------
# identity domain
#-----------------------------------------------------------
variable "enable_identity_domain" {
  description = "Enable identity domain usages"
  default     = false
}

variable "identity_domain_compartment_id" {
  description = "(Required) (Updatable) The OCID of the Compartment where domain is created"
  default     = null
}

variable "identity_domain_description" {
  description = "(Required) (Updatable) Domain entity description"
  default     = null
}

variable "identity_domain_display_name" {
  description = "(Required) (Updatable) The mutable display name of the domain."
  default     = null
}

variable "identity_domain_home_region" {
  description = "(Required) The region's name. See Regions and Availability Domains for the full list of supported region names. Example: us-phoenix-1"
  default     = null
}

variable "identity_domain_license_type" {
  description = "(Required) The License type of Domain"
  default     = null
}

variable "identity_domain_admin_email" {
  description = "(Optional) The admin email address"
  default     = null
}

variable "identity_domain_admin_first_name" {
  description = "(Optional) The admin first name"
  default     = null
}

variable "identity_domain_admin_last_name" {
  description = "(Optional) The admin last name"
  default     = null
}

variable "identity_domain_is_hidden_on_login" {
  description = "(Optional) (Updatable) Indicates whether domain is hidden on login screen or not."
  default     = null
}

variable "identity_domain_is_notification_bypassed" {
  description = "(Optional) Indicates if admin user created in IDCS stripe would like to receive notification like welcome email or not. Required field only if admin information is provided, otherwise optional."
  default     = null
}

variable "identity_domain_admin_user_name" {
  description = "(Optional) The admin user name"
  default     = null
}

variable "identity_domain_is_primary_email_required" {
  description = "(Optional) Optional field to indicate whether users in the domain are required to have a primary email address or not Defaults to true"
  default     = null
}

variable "identity_domain_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "identity_domain_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Domain * update - (Defaults to 20 minutes), when updating the Domain * delete - (Defaults to 20 minutes), when destroying the Domain"
  default     = {}
}

#-----------------------------------------------------------
# identity domain replication to region
#-----------------------------------------------------------
variable "enable_identity_domain_replication_to_region" {
  description = "Enable identity domain replication to region usages"
  default     = false
}

variable "identity_domain_replication_to_region_domain_id" {
  description = "The OCID of the domain"
  default     = ""
}

variable "identity_domain_replication_to_region_replica_region" {
  description = "(Optional) A region for which domain replication is requested for. See Regions and Availability Domains for the full list of supported region names. Example: us-phoenix-1"
  default     = null
}

variable "identity_domain_replication_to_region_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Domain Replication To Region * update - (Defaults to 20 minutes), when updating the Domain Replication To Region * delete - (Defaults to 20 minutes), when destroying the Domain Replication To Region"
  default     = {}
}

#-----------------------------------------------------------
# identity user capabilities management
#-----------------------------------------------------------
variable "enable_identity_user_capabilities_management" {
  description = "Enable identity user capabilities management usages"
  default     = false
}

variable "identity_user_capabilities_management_user_id" {
  description = "The OCID of the user."
  default     = ""
}

variable "identity_user_capabilities_management_can_use_api_keys" {
  description = "(Optional) (Updatable) Indicates if the user can use API keys."
  default     = null
}

variable "identity_user_capabilities_management_can_use_auth_tokens" {
  description = "(Optional) (Updatable) Indicates if the user can use SWIFT passwords / auth tokens."
  default     = null
}

variable "identity_user_capabilities_management_can_use_console_password" {
  description = "(Optional) (Updatable) Indicates if the user can log in to the console."
  default     = null
}

variable "identity_user_capabilities_management_can_use_customer_secret_keys" {
  description = "(Optional) (Updatable) Indicates if the user can use SigV4 symmetric keys."
  default     = null
}

variable "identity_user_capabilities_management_can_use_smtp_credentials" {
  description = "(Optional) (Updatable) Indicates if the user can use SMTP passwords."
  default     = null
}

#-----------------------------------------------------------
# identity ui password
#-----------------------------------------------------------
variable "enable_identity_ui_password" {
  description = "Enable identity ui password usages"
  default     = false
}

variable "identity_ui_password_user_id" {
  description = "The OCID of the user."
  default     = ""
}

variable "identity_ui_password_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ui Password * update - (Defaults to 20 minutes), when updating the Ui Password * delete - (Defaults to 20 minutes), when destroying the Ui Password"
  default     = {}
}

#-----------------------------------------------------------
# identity smtp credential
#-----------------------------------------------------------
variable "enable_identity_smtp_credential" {
  description = "Enable identity smtp credential usages"
  default     = false
}

variable "identity_smtp_credential_description" {
  description = "(Required) (Updatable) The description you assign to the SMTP credentials during creation. Does not have to be unique, and it's changeable."
  default     = null
}

variable "identity_smtp_credential_user_id" {
  description = "The OCID of the user."
  default     = ""
}

variable "identity_smtp_credential_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Smtp Credential * update - (Defaults to 20 minutes), when updating the Smtp Credential * delete - (Defaults to 20 minutes), when destroying the Smtp Credential"
  default     = {}
}

#-----------------------------------------------------------
# identity db credential
#-----------------------------------------------------------
variable "enable_identity_db_credential" {
  description = "Enable identity db credential usages"
  default     = false
}

variable "identity_db_credential_description" {
  description = "(Required) The description you assign to the DB credentials during creation."
  default     = null
}

variable "identity_db_credential_password" {
  description = "(Required) The password for the DB credentials during creation."
  default     = null
}

variable "identity_db_credential_user_id" {
  description = "The OCID of the user."
  default     = ""
}

variable "identity_db_credential_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Db Credential * update - (Defaults to 20 minutes), when updating the Db Credential * delete - (Defaults to 20 minutes), when destroying the Db Credential"
  default     = {}
}

#-----------------------------------------------------------
# identity customer secret key
#-----------------------------------------------------------
variable "enable_identity_customer_secret_key" {
  description = "Enable identity customer secret key usages"
  default     = false
}

variable "identity_customer_secret_key_display_name" {
  description = "AAAAA"
  default     = null
}

variable "identity_customer_secret_key_display_name" {
  description = "(Required) (Updatable) The name you assign to the secret key during creation. Does not have to be unique, and it's changeable."
  default     = ""
}

variable "identity_customer_secret_key_user_id" {
  description = "The OCID of the user."
  default     = ""
}

variable "identity_customer_secret_key_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Customer Secret Key * update - (Defaults to 20 minutes), when updating the Customer Secret Key * delete - (Defaults to 20 minutes), when destroying the Customer Secret Key"
  default     = {}
}

#-----------------------------------------------------------
# identity auth token
#-----------------------------------------------------------
variable "enable_identity_auth_token" {
  description = "Enable identity auth token usages"
  default     = false
}

variable "identity_auth_token_description" {
  description = "(Required) (Updatable) The description you assign to the auth token during creation. Does not have to be unique, and it's changeable."
  default     = null
}

variable "identity_auth_token_user_id" {
  description = "The OCID of the user."
  default     = ""
}

variable "identity_auth_token_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Auth Token * update - (Defaults to 20 minutes), when updating the Auth Token * delete - (Defaults to 20 minutes), when destroying the Auth Token"
  default     = {}
}

#-----------------------------------------------------------
# identity api key
#-----------------------------------------------------------
variable "enable_identity_api_key" {
  description = "Enable identity api key usages"
  default     = false
}

variable "identity_api_key_key_value" {
  description = "(Required) The public key. Must be an RSA key in PEM format."
  default     = null
}

variable "identity_api_key_user_id" {
  description = "The OCID of the user."
  default     = ""
}

variable "identity_api_key_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Api Key * update - (Defaults to 20 minutes), when updating the Api Key * delete - (Defaults to 20 minutes), when destroying the Api Key"
  default     = {}
}
