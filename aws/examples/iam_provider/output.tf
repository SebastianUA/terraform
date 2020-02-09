output "aws_iam_openid_connect_provider_id" {
    description = ""
    value       = module.iam_provider.iam_openid_connect_provider_id
}

output "aws_iam_saml_provider_arn" {
    description = ""
    value       = module.iam_provider.iam_saml_provider_arn
}
