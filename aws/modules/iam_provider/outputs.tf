#-----------------------------------------------------------
# IAM access key
#-----------------------------------------------------------
output "iam_openid_connect_provider_id" {
  description = "ID"
  value       = element(concat(aws_iam_openid_connect_provider.iam_openid_connect_provider.*.id, [""], ), 0)
}

output "iam_openid_connect_provider_arn" {
  description = "The ARN assigned by AWS for this provider."
  value       = element(concat(aws_iam_openid_connect_provider.iam_openid_connect_provider.*.arn, [""], ), 0)
}

#-----------------------------------------------------------
# IAM saml provider
#-----------------------------------------------------------
output "iam_saml_provider_arn" {
  description = "The ARN assigned by AWS for this provider."
  value       = element(concat(aws_iam_saml_provider.iam_saml_provider.*.arn, [""], ), 0)
}

output "iam_saml_provider_valid_until" {
  description = "The expiration date and time for the SAML provider in RFC1123 format, e.g. Mon, 02 Jan 2006 15:04:05 MST."
  value       = element(concat(aws_iam_saml_provider.iam_saml_provider.*.valid_until, [""], ), 0)
}
