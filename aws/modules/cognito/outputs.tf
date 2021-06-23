#---------------------------------------------------
# AWS cognito user pool
#---------------------------------------------------
output "cognito_user_pool_id" {
  description = "ID of the user pool."
  value       = element(concat(aws_cognito_user_pool.cognito_user_pool.*.id, [""]), 0)
}

output "cognito_user_pool_arn" {
  description = "ARN of the user pool."
  value       = element(concat(aws_cognito_user_pool.cognito_user_pool.*.arn, [""]), 0)
}

output "cognito_user_pool_creation_date" {
  description = "Date the user pool was created."
  value       = element(concat(aws_cognito_user_pool.cognito_user_pool.*.creation_date, [""]), 0)
}

output "cognito_user_pool_custom_domain" {
  description = "A custom domain name that you provide to Amazon Cognito. This parameter applies only if you use a custom domain to host the sign-up and sign-in pages for your application. For example: auth.example.com."
  value       = element(concat(aws_cognito_user_pool.cognito_user_pool.*.custom_domain, [""]), 0)
}

output "cognito_user_pool_domain" {
  description = "Holds the domain prefix if the user pool has a domain associated with it."
  value       = element(concat(aws_cognito_user_pool.cognito_user_pool.*.domain, [""]), 0)
}

output "cognito_user_pool_endpoint" {
  description = "Endpoint name of the user pool. Example format: cognito-idp.REGION.amazonaws.com/xxxx_yyyyy"
  value       = element(concat(aws_cognito_user_pool.cognito_user_pool.*.endpoint, [""]), 0)
}

output "cognito_user_pool_estimated_number_of_users" {
  description = "A number estimating the size of the user pool."
  value       = element(concat(aws_cognito_user_pool.cognito_user_pool.*.estimated_number_of_users, [""]), 0)
}

output "cognito_user_pool_last_modified_date" {
  description = "Date the user pool was last modified."
  value       = element(concat(aws_cognito_user_pool.cognito_user_pool.*.last_modified_date, [""]), 0)
}

output "cognito_user_pool_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_cognito_user_pool.cognito_user_pool.*.tags_all, [""])
}

#---------------------------------------------------
# AWS cognito user pool domain
#---------------------------------------------------
output "cognito_user_pool_domain_id" {
  description = "ID of the user pool domain."
  value       = element(concat(aws_cognito_user_pool_domain.cognito_user_pool_domain.*.id, [""]), 0)
}

output "cognito_user_pool_domain_aws_account_id" {
  description = "The AWS account ID for the user pool owner."
  value       = element(concat(aws_cognito_user_pool_domain.cognito_user_pool_domain.*.aws_account_id, [""]), 0)
}

output "cognito_user_pool_domain_cloudfront_distribution_arn" {
  description = "The URL of the CloudFront distribution. This is required to generate the ALIAS aws_route53_record"
  value       = element(concat(aws_cognito_user_pool_domain.cognito_user_pool_domain.*.cloudfront_distribution_arn, [""]), 0)
}

output "cognito_user_pool_domain_s3_bucket" {
  description = "The S3 bucket where the static files for this domain are stored."
  value       = element(concat(aws_cognito_user_pool_domain.cognito_user_pool_domain.*.s3_bucket, [""]), 0)
}

output "cognito_user_pool_domain_version" {
  description = "The app version."
  value       = element(concat(aws_cognito_user_pool_domain.cognito_user_pool_domain.*.version, [""]), 0)
}

#---------------------------------------------------
# AWS cognito user pool ui customization
#---------------------------------------------------
output "cognito_user_pool_ui_customization_id" {
  description = "ID of the user pool ui customization."
  value       = element(concat(aws_cognito_user_pool_ui_customization.cognito_user_pool_ui_customization.*.id, [""]), 0)
}

output "cognito_user_pool_ui_customization_creation_date" {
  description = "The creation date in RFC3339 format for the UI customization."
  value       = element(concat(aws_cognito_user_pool_ui_customization.cognito_user_pool_ui_customization.*.creation_date, [""]), 0)
}

output "cognito_user_pool_ui_customization_css_version" {
  description = "The CSS version number."
  value       = element(concat(aws_cognito_user_pool_ui_customization.cognito_user_pool_ui_customization.*.css_version, [""]), 0)
}

output "cognito_user_pool_ui_customization_image_url" {
  description = "The logo image URL for the UI customization."
  value       = element(concat(aws_cognito_user_pool_ui_customization.cognito_user_pool_ui_customization.*.image_url, [""]), 0)
}

output "cognito_user_pool_ui_customization_last_modified_date" {
  description = "The last-modified date in RFC3339 format for the UI customization."
  value       = element(concat(aws_cognito_user_pool_ui_customization.cognito_user_pool_ui_customization.*.last_modified_date, [""]), 0)
}

#---------------------------------------------------
# AWS cognito user pool client
#---------------------------------------------------
output "cognito_user_pool_client_id" {
  description = "ID of the user pool client."
  value       = element(concat(aws_cognito_user_pool_client.cognito_user_pool_client.*.id, [""]), 0)
}

output "cognito_user_pool_client_client_secret" {
  description = "Client secret of the user pool client."
  value       = element(concat(aws_cognito_user_pool_client.cognito_user_pool_client.*.client_secret, [""]), 0)
}

#---------------------------------------------------
# AWS cognito user group
#---------------------------------------------------
output "cognito_user_group_id" {
  description = "ID of the user group."
  value       = element(concat(aws_cognito_user_group.cognito_user_group.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS cognito resource server
#---------------------------------------------------
output "cognito_resource_server_id" {
  description = "ID of the cognito resource server."
  value       = element(concat(aws_cognito_resource_server.cognito_resource_server.*.id, [""]), 0)
}

output "cognito_resource_server_scope_identifiers" {
  description = "A list of all scopes configured for this resource server in the format identifier/scope_name."
  value       = element(concat(aws_cognito_resource_server.cognito_resource_server.*.scope_identifiers, [""]), 0)
}

#---------------------------------------------------
# AWS cognito identity provider
#---------------------------------------------------
output "cognito_identity_provider_id" {
  description = "ID of the cognito identity provider."
  value       = element(concat(aws_cognito_identity_provider.cognito_identity_provider.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS cognito identity pool
#---------------------------------------------------
output "cognito_identity_pool_id" {
  description = "An identity pool ID in the format REGION:GUID."
  value       = element(concat(aws_cognito_identity_pool.cognito_identity_pool.*.id, [""]), 0)
}

output "cognito_identity_pool_arn" {
  description = "The ARN of the identity pool."
  value       = element(concat(aws_cognito_identity_pool.cognito_identity_pool.*.arn, [""]), 0)
}

output "cognito_identity_pool_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_cognito_identity_pool.cognito_identity_pool.*.tags_all, [""])
}

#---------------------------------------------------
# AWS cognito identity pool roles attachment
#---------------------------------------------------
output "cognito_identity_pool_roles_attachment_id" {
  description = "The identity pool ID."
  value       = element(concat(aws_cognito_identity_pool_roles_attachment.cognito_identity_pool_roles_attachment.*.id, [""]), 0)
}

output "cognito_identity_pool_roles_attachment_identity_pool_id" {
  description = "An identity pool ID in the format REGION:GUID."
  value       = element(concat(aws_cognito_identity_pool_roles_attachment.cognito_identity_pool_roles_attachment.*.identity_pool_id, [""]), 0)
}

output "cognito_identity_pool_roles_attachment_role_mapping" {
  description = "The List of Role Mapping."
  value       = element(concat(aws_cognito_identity_pool_roles_attachment.cognito_identity_pool_roles_attachment.*.role_mapping, [""]), 0)
}

output "cognito_identity_pool_roles_attachment_roles" {
  description = "The map of roles associated with this pool. For a given role, the key will be either 'authenticated' or 'unauthenticated' and the value will be the Role ARN."
  value       = element(concat(aws_cognito_identity_pool_roles_attachment.cognito_identity_pool_roles_attachment.*.roles, [""]), 0)
}
