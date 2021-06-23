#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS cognito user pool
#---------------------------------------------------
variable "enable_cognito_user_pool" {
  description = "Enable cognito user pool usage"
  default     = false
}

variable "cognito_user_pool_name" {
  description = "Name of the user pool."
  default     = ""
}

variable "cognito_user_pool_alias_attributes" {
  description = "(Optional) Attributes supported as an alias for this user pool. Valid values: phone_number, email, or preferred_username. Conflicts with username_attributes."
  default     = null
}

variable "cognito_user_pool_auto_verified_attributes" {
  description = "(Optional) Attributes to be auto-verified. Valid values: email, phone_number."
  default     = null
}

variable "cognito_user_pool_email_verification_message" {
  description = "(Optional) String representing the email verification message. Conflicts with verification_message_template configuration block email_message argument."
  default     = null
}

variable "cognito_user_pool_email_verification_subject" {
  description = "(Optional) String representing the email verification subject. Conflicts with verification_message_template configuration block email_subject argument."
  default     = null
}

variable "cognito_user_pool_mfa_configuration" {
  description = "(Optional) Multi-Factor Authentication (MFA) configuration for the User Pool. Defaults of OFF. Valid values are OFF (MFA Tokens are not required), ON (MFA is required for all users to sign in; requires at least one of sms_configuration or software_token_mfa_configuration to be configured), or OPTIONAL (MFA Will be required only for individual users who have MFA Enabled; requires at least one of sms_configuration or software_token_mfa_configuration to be configured)."
  default     = null
}

variable "cognito_user_pool_sms_authentication_message" {
  description = "(Optional) String representing the SMS authentication message. The Message must contain the {####} placeholder, which will be replaced with the code."
  default     = null
}

variable "cognito_user_pool_sms_verification_message" {
  description = "(Optional) String representing the SMS verification message. Conflicts with verification_message_template configuration block sms_message argument."
  default     = null
}

variable "cognito_user_pool_username_attributes" {
  description = "(Optional) Whether email addresses or phone numbers can be specified as usernames when a user signs up. Conflicts with alias_attributes."
  default     = null
}

variable "cognito_user_pool_account_recovery_setting" {
  description = "(Optional) Configuration block to define which verified available method a user can use to recover their forgotten password."
  default     = []
}

variable "cognito_user_pool_admin_create_user_config" {
  description = "(Optional) Configuration block for creating a new user profile."
  default     = []
}

variable "cognito_user_pool_device_configuration" {
  description = "(Optional) Configuration block for the user pool's device tracking."
  default     = []
}

variable "cognito_user_pool_email_configuration" {
  description = "(Optional) Configuration block for configuring email."
  default     = []
}

variable "cognito_user_pool_lambda_config" {
  description = "(Optional) Configuration block for the AWS Lambda triggers associated with the user pool."
  default     = []
}

variable "cognito_user_pool_password_policy" {
  description = "(Optional) Configuration blocked for information about the user pool password policy."
  default     = []
}

variable "cognito_user_pool_schema" {
  description = "(Optional) Configuration block for the schema attributes of a user pool. Detailed below. Schema attributes from the standard attribute set only need to be specified if they are different from the default configuration. Attributes can be added, but not modified or removed. Maximum of 50 attributes."
  default     = []
}

variable "cognito_user_pool_sms_configuration" {
  description = "(Optional) Configuration block for Short Message Service (SMS) settings. Detailed below. These settings apply to SMS user verification and SMS Multi-Factor Authentication (MFA). Due to Cognito API restrictions, the SMS configuration cannot be removed without recreating the Cognito User Pool. For user data safety, this resource will ignore the removal of this configuration by disabling drift detection. To force resource recreation after this configuration has been applied, see the taint command."
  default     = {}
}

variable "cognito_user_pool_software_token_mfa_configuration" {
  description = "(Optional) Configuration block for software token Mult-Factor Authentication (MFA) settings."
  default     = {}
}

variable "cognito_user_pool_user_pool_add_ons" {
  description = "(Optional) Configuration block for user pool add-ons to enable user pool advanced security mode features."
  default     = {}
}

variable "cognito_user_pool_username_configuration" {
  description = "(Optional) Configuration block for username configuration."
  default     = {}
}

variable "cognito_user_pool_verification_message_template" {
  description = "(Optional) Configuration block for verification message templates."
  default     = []
}

#---------------------------------------------------
# AWS cognito user pool domain
#---------------------------------------------------
variable "enable_cognito_user_pool_domain" {
  description = "Enable cognito user pool domain usage"
  default     = false
}

variable "cognito_user_pool_domain_domain" {
  description = "(Required) The domain string."
  default     = null
}

variable "cognito_user_pool_domain_user_pool_id" {
  description = "The user pool ID."
  default     = ""
}

variable "cognito_user_pool_domain_certificate_arn" {
  description = "(Optional) The ARN of an ISSUED ACM certificate in us-east-1 for a custom domain."
  default     = null
}

#---------------------------------------------------
# AWS cognito user pool ui customization
#---------------------------------------------------
variable "enable_cognito_user_pool_ui_customization" {
  description = "Enable cognito user pool ui customization usage"
  default     = false
}

variable "cognito_user_pool_ui_customization_user_pool_id" {
  description = "The user pool ID for the user pool."
  default     = ""
}

variable "cognito_user_pool_ui_customization_client_id" {
  description = "(Optional) The client ID for the client app. Defaults to ALL. If ALL is specified, the css and/or image_file settings will be used for every client that has no UI customization set previously."
  default     = null
}

variable "cognito_user_pool_ui_customization_css" {
  description = "(Optional) - The CSS values in the UI customization, provided as a String. At least one of css or image_file is required."
  default     = null
}

variable "cognito_user_pool_ui_customization_image_file" {
  description = "(Optional) - The uploaded logo image for the UI customization, provided as a base64-encoded String. Drift detection is not possible for this argument. At least one of css or image_file is required."
  default     = null
}

#---------------------------------------------------
# AWS cognito user pool client
#---------------------------------------------------
variable "enable_cognito_user_pool_client" {
  description = "Enable cognito user pool client usage"
  default     = false
}

variable "cognito_user_pool_client_name" {
  description = "Name of the application client."
  default     = ""
}

variable "cognito_user_pool_client_user_pool_id" {
  description = "User pool the client belongs to."
  default     = ""
}

variable "cognito_user_pool_client_access_token_validity" {
  description = "(Optional) Time limit, between 5 minutes and 1 day, after which the access token is no longer valid and cannot be used. This value will be overridden if you have entered a value in token_validity_units."
  default     = null
}

variable "cognito_user_pool_client_allowed_oauth_flows_user_pool_client" {
  description = "(Optional) Whether the client is allowed to follow the OAuth protocol when interacting with Cognito user pools."
  default     = null
}

variable "cognito_user_pool_client_allowed_oauth_flows" {
  description = "(Optional) List of allowed OAuth flows (code, implicit, client_credentials)."
  default     = null
}

variable "cognito_user_pool_client_allowed_oauth_scopes" {
  description = "(Optional) List of allowed OAuth scopes (phone, email, openid, profile, and aws.cognito.signin.user.admin)."
  default     = null
}

variable "cognito_user_pool_client_callback_urls" {
  description = "(Optional) List of allowed callback URLs for the identity providers."
  default     = null
}

variable "cognito_user_pool_client_default_redirect_uri" {
  description = "(Optional) Default redirect URI. Must be in the list of callback URLs."
  default     = null
}

variable "cognito_user_pool_client_explicit_auth_flows" {
  description = "(Optional) List of authentication flows (ADMIN_NO_SRP_AUTH, CUSTOM_AUTH_FLOW_ONLY, USER_PASSWORD_AUTH, ALLOW_ADMIN_USER_PASSWORD_AUTH, ALLOW_CUSTOM_AUTH, ALLOW_USER_PASSWORD_AUTH, ALLOW_USER_SRP_AUTH, ALLOW_REFRESH_TOKEN_AUTH)."
  default     = null
}

variable "cognito_user_pool_client_generate_secret" {
  description = "(Optional) Should an application secret be generated."
  default     = null
}

variable "cognito_user_pool_client_id_token_validity" {
  description = "(Optional) Time limit, between 5 minutes and 1 day, after which the ID token is no longer valid and cannot be used. This value will be overridden if you have entered a value in token_validity_units."
  default     = null
}

variable "cognito_user_pool_client_logout_urls" {
  description = "(Optional) List of allowed logout URLs for the identity providers."
  default     = null
}

variable "cognito_user_pool_client_prevent_user_existence_errors" {
  description = "(Optional) Choose which errors and responses are returned by Cognito APIs during authentication, account confirmation, and password recovery when the user does not exist in the user pool. When set to ENABLED and the user does not exist, authentication returns an error indicating either the username or password was incorrect, and account confirmation and password recovery return a response indicating a code was sent to a simulated destination. When set to LEGACY, those APIs will return a UserNotFoundException exception if the user does not exist in the user pool."
  default     = null
}

variable "cognito_user_pool_client_read_attributes" {
  description = "Optional) List of user pool attributes the application client can read from."
  default     = null
}

variable "cognito_user_pool_client_refresh_token_validity" {
  description = "(Optional) Time limit in days refresh tokens are valid for."
  default     = null
}

variable "cognito_user_pool_client_supported_identity_providers" {
  description = "(Optional) List of provider names for the identity providers that are supported on this client."
  default     = null
}

variable "cognito_user_pool_client_write_attributes" {
  description = "(Optional) List of user pool attributes the application client can write to."
  default     = null
}

variable "cognito_user_pool_client_analytics_configuration" {
  description = "(Optional) Configuration block for Amazon Pinpoint analytics for collecting metrics for this user pool."
  default     = []
}

variable "cognito_user_pool_client_token_validity_units" {
  description = "(Optional) Configuration block for units in which the validity times are represented in."
  default     = []
}

#---------------------------------------------------
# AWS cognito user group
#---------------------------------------------------
variable "enable_cognito_user_group" {
  description = "Enable cognito user group usage"
  default     = false
}

variable "cognito_user_group_name" {
  description = "The name of the user group."
  default     = ""
}

variable "cognito_user_group_pool_id" {
  description = "The user pool ID."
  default     = ""
}

variable "cognito_user_group_description" {
  description = "(Optional) The description of the user group."
  default     = null
}

variable "cognito_user_group_precedence" {
  description = "(Optional) The precedence of the user group."
  default     = null
}

variable "cognito_user_group_role_arn" {
  description = "(Optional) The ARN of the IAM role to be associated with the user group."
  default     = null
}

#---------------------------------------------------
# AWS cognito resource server
#---------------------------------------------------
variable "enable_cognito_resource_server" {
  description = "Enable cognito resource server usage"
  default     = false
}

variable "cognito_resource_server_name" {
  description = "A name for the resource server."
  default     = ""
}

variable "cognito_resource_server_user_pool_id" {
  description = "The pool id"
  default     = ""
}

variable "cognito_resource_server_identifier" {
  description = "(Required) An identifier for the resource server."
  default     = null
}

variable "cognito_resource_server_scope" {
  description = "(Optional) A list of Authorization Scope."
  default     = []
}

#---------------------------------------------------
# AWS cognito identity provider
#---------------------------------------------------
variable "enable_cognito_identity_provider" {
  description = "Enable cognito identity provider"
  default     = false
}

variable "cognito_identity_provider_user_pool_id" {
  description = "The user pool id"
  default     = ""
}

variable "cognito_identity_provider_provider_name" {
  description = "(Required) - The provider name"
  default     = null
}

variable "cognito_identity_provider_provider_type" {
  description = "(Required) - The provider type. See AWS API for valid values"
  default     = null
}

variable "cognito_identity_provider_attribute_mapping" {
  description = "(Optional) - The map of attribute mapping of user pool attributes. AttributeMapping in AWS API documentation"
  default     = null
}

variable "cognito_identity_provider_idp_identifiers" {
  description = "(Optional) - The list of identity providers."
  default     = null
}

variable "cognito_identity_provider_provider_details" {
  description = "(Optional) - The map of identity details, such as access token"
  default     = null
}

#---------------------------------------------------
# AWS cognito identity pool
#---------------------------------------------------
variable "enable_cognito_identity_pool" {
  description = "Enable cognito identity pool usage"
  default     = false
}

variable "cognito_identity_pool_name" {
  description = "The Cognito Identity Pool name."
  default     = ""
}

variable "cognito_identity_pool_allow_unauthenticated_identities" {
  description = "(Required) - Whether the identity pool supports unauthenticated logins or not."
  default     = null
}

variable "cognito_identity_pool_allow_classic_flow" {
  description = "(Optional) - Enables or disables the classic / basic authentication flow. Default is false."
  default     = null
}

variable "cognito_identity_pool_developer_provider_name" {
  description = "(Optional) - The 'domain' by which Cognito will refer to your users. This name acts as a placeholder that allows your backend and the Cognito service to communicate about the developer provider."
  default     = null
}

variable "cognito_identity_pool_openid_connect_provider_arns" {
  description = "(Optional) - Set of OpendID Connect provider ARNs."
  default     = null
}

variable "cognito_identity_pool_saml_provider_arns" {
  description = "(Optional) - An array of Amazon Resource Names (ARNs) of the SAML provider for your identity."
  default     = null
}

variable "cognito_identity_pool_supported_login_providers" {
  description = "(Optional) - Key-Value pairs mapping provider names to provider app IDs."
  default     = null
}

variable "cognito_identity_pool_cognito_identity_providers" {
  description = "(Optional) - An array of Amazon Cognito Identity user pools and their client IDs."
  default     = []
}

#---------------------------------------------------
# AWS cognito identity pool roles attachment
#---------------------------------------------------
variable "enable_cognito_identity_pool_roles_attachment" {
  description = "Enable cognito identity pool roles attachment usage"
  default     = false
}

variable "cognito_identity_pool_roles_attachment_identity_pool_id" {
  description = "An identity pool ID in the format REGION:GUID."
  default     = ""
}

variable "cognito_identity_pool_roles_attachment_roles" {
  description = "(Required) - The map of roles associated with this pool. For a given role, the key will be either 'authenticated' or 'unauthenticated' and the value will be the Role ARN."
  default     = null
}

variable "cognito_identity_pool_roles_attachment_role_mapping" {
  description = "(Optional) - A List of Role Mapping."
  default     = []
}
