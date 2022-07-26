# Work with COGNITO via terraform

A terraform module for making COGNITO.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "cognito" {
  source      = "../../modules/cognito"
  name        = "TEST"
  environment = "stage"

  # enable cognito user pool
  enable_cognito_user_pool = true
  cognito_user_pool_name   = ""

  cognito_user_pool_mfa_configuration          = "ON"
  cognito_user_pool_sms_authentication_message = "Your code is {####}"

  cognito_user_pool_sms_configuration = {
    external_id    = "example"
    sns_caller_arn = "arn:aws:iam::123456789012:role/aws-cognito-role"
  }

  cognito_user_pool_software_token_mfa_configuration = {
    enabled = true
  }

  # enable cognito user pool domain
  enable_cognito_user_pool_domain = true
  cognito_user_pool_domain_domain = "linux-notes"

  # enable cognito user pool client
  enable_cognito_user_pool_client = true
  cognito_user_pool_client_name   = ""

  tags = tomap({ "Env" = "Stage", "CreatedBy" = "Vitaliy Natarov" })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_cognito_user_pool` - Enable cognito user pool usage (`default = False`)
- `cognito_user_pool_name` - Name of the user pool. (`default = ""`)
- `cognito_user_pool_alias_attributes` - (Optional) Attributes supported as an alias for this user pool. Valid values: phone_number, email, or preferred_username. Conflicts with username_attributes. (`default = null`)
- `cognito_user_pool_auto_verified_attributes` - (Optional) Attributes to be auto-verified. Valid values: email, phone_number. (`default = null`)
- `cognito_user_pool_email_verification_message` - (Optional) String representing the email verification message. Conflicts with verification_message_template configuration block email_message argument. (`default = null`)
- `cognito_user_pool_email_verification_subject` - (Optional) String representing the email verification subject. Conflicts with verification_message_template configuration block email_subject argument. (`default = null`)
- `cognito_user_pool_mfa_configuration` - (Optional) Multi-Factor Authentication (MFA) configuration for the User Pool. Defaults of OFF. Valid values are OFF (MFA Tokens are not required), ON (MFA is required for all users to sign in; requires at least one of sms_configuration or software_token_mfa_configuration to be configured), or OPTIONAL (MFA Will be required only for individual users who have MFA Enabled; requires at least one of sms_configuration or software_token_mfa_configuration to be configured). (`default = null`)
- `cognito_user_pool_sms_authentication_message` - (Optional) String representing the SMS authentication message. The Message must contain the {####} placeholder, which will be replaced with the code. (`default = null`)
- `cognito_user_pool_sms_verification_message` - (Optional) String representing the SMS verification message. Conflicts with verification_message_template configuration block sms_message argument. (`default = null`)
- `cognito_user_pool_username_attributes` - (Optional) Whether email addresses or phone numbers can be specified as usernames when a user signs up. Conflicts with alias_attributes. (`default = null`)
- `cognito_user_pool_account_recovery_setting` - (Optional) Configuration block to define which verified available method a user can use to recover their forgotten password. (`default = []`)
- `cognito_user_pool_admin_create_user_config` - (Optional) Configuration block for creating a new user profile. (`default = []`)
- `cognito_user_pool_device_configuration` - (Optional) Configuration block for the user pool's device tracking. (`default = []`)
- `cognito_user_pool_email_configuration` - (Optional) Configuration block for configuring email. (`default = []`)
- `cognito_user_pool_lambda_config` - (Optional) Configuration block for the AWS Lambda triggers associated with the user pool. (`default = []`)
- `cognito_user_pool_password_policy` - (Optional) Configuration blocked for information about the user pool password policy. (`default = []`)
- `cognito_user_pool_schema` - (Optional) Configuration block for the schema attributes of a user pool. Detailed below. Schema attributes from the standard attribute set only need to be specified if they are different from the default configuration. Attributes can be added, but not modified or removed. Maximum of 50 attributes. (`default = []`)
- `cognito_user_pool_sms_configuration` - (Optional) Configuration block for Short Message Service (SMS) settings. Detailed below. These settings apply to SMS user verification and SMS Multi-Factor Authentication (MFA). Due to Cognito API restrictions, the SMS configuration cannot be removed without recreating the Cognito User Pool. For user data safety, this resource will ignore the removal of this configuration by disabling drift detection. To force resource recreation after this configuration has been applied, see the taint command. (`default = {}`)
- `cognito_user_pool_software_token_mfa_configuration` - (Optional) Configuration block for software token Mult-Factor Authentication (MFA) settings. (`default = {}`)
- `cognito_user_pool_user_pool_add_ons` - (Optional) Configuration block for user pool add-ons to enable user pool advanced security mode features. (`default = {}`)
- `cognito_user_pool_username_configuration` - (Optional) Configuration block for username configuration. (`default = {}`)
- `cognito_user_pool_verification_message_template` - (Optional) Configuration block for verification message templates. (`default = []`)
- `enable_cognito_user_pool_domain` - Enable cognito user pool domain usage (`default = False`)
- `cognito_user_pool_domain_domain` - (Required) The domain string. (`default = null`)
- `cognito_user_pool_domain_user_pool_id` - The user pool ID. (`default = ""`)
- `cognito_user_pool_domain_certificate_arn` - (Optional) The ARN of an ISSUED ACM certificate in us-east-1 for a custom domain. (`default = null`)
- `enable_cognito_user_pool_ui_customization` - Enable cognito user pool ui customization usage (`default = False`)
- `cognito_user_pool_ui_customization_user_pool_id` - The user pool ID for the user pool. (`default = ""`)
- `cognito_user_pool_ui_customization_client_id` - (Optional) The client ID for the client app. Defaults to ALL. If ALL is specified, the css and/or image_file settings will be used for every client that has no UI customization set previously. (`default = null`)
- `cognito_user_pool_ui_customization_css` - (Optional) - The CSS values in the UI customization, provided as a String. At least one of css or image_file is required. (`default = null`)
- `cognito_user_pool_ui_customization_image_file` - (Optional) - The uploaded logo image for the UI customization, provided as a base64-encoded String. Drift detection is not possible for this argument. At least one of css or image_file is required. (`default = null`)
- `enable_cognito_user_pool_client` - Enable cognito user pool client usage (`default = False`)
- `cognito_user_pool_client_name` - Name of the application client. (`default = ""`)
- `cognito_user_pool_client_user_pool_id` - User pool the client belongs to. (`default = ""`)
- `cognito_user_pool_client_access_token_validity` - (Optional) Time limit, between 5 minutes and 1 day, after which the access token is no longer valid and cannot be used. This value will be overridden if you have entered a value in token_validity_units. (`default = null`)
- `cognito_user_pool_client_allowed_oauth_flows_user_pool_client` - (Optional) Whether the client is allowed to follow the OAuth protocol when interacting with Cognito user pools. (`default = null`)
- `cognito_user_pool_client_allowed_oauth_flows` - (Optional) List of allowed OAuth flows (code, implicit, client_credentials). (`default = null`)
- `cognito_user_pool_client_allowed_oauth_scopes` - (Optional) List of allowed OAuth scopes (phone, email, openid, profile, and aws.cognito.signin.user.admin). (`default = null`)
- `cognito_user_pool_client_callback_urls` - (Optional) List of allowed callback URLs for the identity providers. (`default = null`)
- `cognito_user_pool_client_default_redirect_uri` - (Optional) Default redirect URI. Must be in the list of callback URLs. (`default = null`)
- `cognito_user_pool_client_explicit_auth_flows` - (Optional) List of authentication flows (ADMIN_NO_SRP_AUTH, CUSTOM_AUTH_FLOW_ONLY, USER_PASSWORD_AUTH, ALLOW_ADMIN_USER_PASSWORD_AUTH, ALLOW_CUSTOM_AUTH, ALLOW_USER_PASSWORD_AUTH, ALLOW_USER_SRP_AUTH, ALLOW_REFRESH_TOKEN_AUTH). (`default = null`)
- `cognito_user_pool_client_generate_secret` - (Optional) Should an application secret be generated. (`default = null`)
- `cognito_user_pool_client_id_token_validity` - (Optional) Time limit, between 5 minutes and 1 day, after which the ID token is no longer valid and cannot be used. This value will be overridden if you have entered a value in token_validity_units. (`default = null`)
- `cognito_user_pool_client_logout_urls` - (Optional) List of allowed logout URLs for the identity providers. (`default = null`)
- `cognito_user_pool_client_prevent_user_existence_errors` - (Optional) Choose which errors and responses are returned by Cognito APIs during authentication, account confirmation, and password recovery when the user does not exist in the user pool. When set to ENABLED and the user does not exist, authentication returns an error indicating either the username or password was incorrect, and account confirmation and password recovery return a response indicating a code was sent to a simulated destination. When set to LEGACY, those APIs will return a UserNotFoundException exception if the user does not exist in the user pool. (`default = null`)
- `cognito_user_pool_client_read_attributes` - Optional) List of user pool attributes the application client can read from. (`default = null`)
- `cognito_user_pool_client_refresh_token_validity` - (Optional) Time limit in days refresh tokens are valid for. (`default = null`)
- `cognito_user_pool_client_supported_identity_providers` - (Optional) List of provider names for the identity providers that are supported on this client. (`default = null`)
- `cognito_user_pool_client_write_attributes` - (Optional) List of user pool attributes the application client can write to. (`default = null`)
- `cognito_user_pool_client_analytics_configuration` - (Optional) Configuration block for Amazon Pinpoint analytics for collecting metrics for this user pool. (`default = []`)
- `cognito_user_pool_client_token_validity_units` - (Optional) Configuration block for units in which the validity times are represented in. (`default = []`)
- `enable_cognito_user_group` - Enable cognito user group usage (`default = False`)
- `cognito_user_group_name` - The name of the user group. (`default = ""`)
- `cognito_user_group_pool_id` - The user pool ID. (`default = ""`)
- `cognito_user_group_description` - (Optional) The description of the user group. (`default = null`)
- `cognito_user_group_precedence` - (Optional) The precedence of the user group. (`default = null`)
- `cognito_user_group_role_arn` - (Optional) The ARN of the IAM role to be associated with the user group. (`default = null`)
- `enable_cognito_resource_server` - Enable cognito resource server usage (`default = False`)
- `cognito_resource_server_name` - A name for the resource server. (`default = ""`)
- `cognito_resource_server_user_pool_id` - The pool id (`default = ""`)
- `cognito_resource_server_identifier` - (Required) An identifier for the resource server. (`default = null`)
- `cognito_resource_server_scope` - (Optional) A list of Authorization Scope. (`default = []`)
- `enable_cognito_identity_provider` - Enable cognito identity provider (`default = False`)
- `cognito_identity_provider_user_pool_id` - The user pool id (`default = ""`)
- `cognito_identity_provider_provider_name` - (Required) - The provider name (`default = null`)
- `cognito_identity_provider_provider_type` - (Required) - The provider type. See AWS API for valid values (`default = null`)
- `cognito_identity_provider_attribute_mapping` - (Optional) - The map of attribute mapping of user pool attributes. AttributeMapping in AWS API documentation (`default = null`)
- `cognito_identity_provider_idp_identifiers` - (Optional) - The list of identity providers. (`default = null`)
- `cognito_identity_provider_provider_details` - (Optional) - The map of identity details, such as access token (`default = null`)
- `enable_cognito_identity_pool` - Enable cognito identity pool usage (`default = False`)
- `cognito_identity_pool_name` - The Cognito Identity Pool name. (`default = ""`)
- `cognito_identity_pool_allow_unauthenticated_identities` - (Required) - Whether the identity pool supports unauthenticated logins or not. (`default = null`)
- `cognito_identity_pool_allow_classic_flow` - (Optional) - Enables or disables the classic / basic authentication flow. Default is false. (`default = null`)
- `cognito_identity_pool_developer_provider_name` - (Optional) - The 'domain' by which Cognito will refer to your users. This name acts as a placeholder that allows your backend and the Cognito service to communicate about the developer provider. (`default = null`)
- `cognito_identity_pool_openid_connect_provider_arns` - (Optional) - Set of OpendID Connect provider ARNs. (`default = null`)
- `cognito_identity_pool_saml_provider_arns` - (Optional) - An array of Amazon Resource Names (ARNs) of the SAML provider for your identity. (`default = null`)
- `cognito_identity_pool_supported_login_providers` - (Optional) - Key-Value pairs mapping provider names to provider app IDs. (`default = null`)
- `cognito_identity_pool_cognito_identity_providers` - (Optional) - An array of Amazon Cognito Identity user pools and their client IDs. (`default = []`)
- `enable_cognito_identity_pool_roles_attachment` - Enable cognito identity pool roles attachment usage (`default = False`)
- `cognito_identity_pool_roles_attachment_identity_pool_id` - An identity pool ID in the format REGION:GUID. (`default = ""`)
- `cognito_identity_pool_roles_attachment_roles` - (Required) - The map of roles associated with this pool. For a given role, the key will be either 'authenticated' or 'unauthenticated' and the value will be the Role ARN. (`default = null`)
- `cognito_identity_pool_roles_attachment_role_mapping` - (Optional) - A List of Role Mapping. (`default = []`)

## Module Output Variables
----------------------
- `cognito_user_pool_id` - ID of the user pool.
- `cognito_user_pool_arn` - ARN of the user pool.
- `cognito_user_pool_creation_date` - Date the user pool was created.
- `cognito_user_pool_custom_domain` - A custom domain name that you provide to Amazon Cognito. This parameter applies only if you use a custom domain to host the sign-up and sign-in pages for your application. For example: auth.example.com.
- `cognito_user_pool_domain` - Holds the domain prefix if the user pool has a domain associated with it.
- `cognito_user_pool_endpoint` - Endpoint name of the user pool. Example format: cognito-idp.REGION.amazonaws.com/xxxx_yyyyy
- `cognito_user_pool_estimated_number_of_users` - A number estimating the size of the user pool.
- `cognito_user_pool_last_modified_date` - Date the user pool was last modified.
- `cognito_user_pool_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `cognito_user_pool_domain_id` - ID of the user pool domain.
- `cognito_user_pool_domain_aws_account_id` - The AWS account ID for the user pool owner.
- `cognito_user_pool_domain_cloudfront_distribution_arn` - The URL of the CloudFront distribution. This is required to generate the ALIAS aws_route53_record
- `cognito_user_pool_domain_s3_bucket` - The S3 bucket where the static files for this domain are stored.
- `cognito_user_pool_domain_version` - The app version.
- `cognito_user_pool_ui_customization_id` - ID of the user pool ui customization.
- `cognito_user_pool_ui_customization_creation_date` - The creation date in RFC3339 format for the UI customization.
- `cognito_user_pool_ui_customization_css_version` - The CSS version number.
- `cognito_user_pool_ui_customization_image_url` - The logo image URL for the UI customization.
- `cognito_user_pool_ui_customization_last_modified_date` - The last-modified date in RFC3339 format for the UI customization.
- `cognito_user_pool_client_id` - ID of the user pool client.
- `cognito_user_pool_client_client_secret` - Client secret of the user pool client.
- `cognito_user_group_id` - ID of the user group.
- `cognito_resource_server_id` - ID of the cognito resource server.
- `cognito_resource_server_scope_identifiers` - A list of all scopes configured for this resource server in the format identifier/scope_name.
- `cognito_identity_provider_id` - ID of the cognito identity provider.
- `cognito_identity_pool_id` - An identity pool ID in the format REGION:GUID.
- `cognito_identity_pool_arn` - The ARN of the identity pool.
- `cognito_identity_pool_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `cognito_identity_pool_roles_attachment_id` - The identity pool ID.
- `cognito_identity_pool_roles_attachment_identity_pool_id` - An identity pool ID in the format REGION:GUID.
- `cognito_identity_pool_roles_attachment_role_mapping` - The List of Role Mapping.
- `cognito_identity_pool_roles_attachment_roles` - The map of roles associated with this pool. For a given role, the key will be either 'authenticated' or 'unauthenticated' and the value will be the Role ARN.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
