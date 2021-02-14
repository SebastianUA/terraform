#---------------------------------------------------
# acm certificate
#---------------------------------------------------
output "aws_acm_certificate_id" {
  description = "The ARN of the certificate"
  value = element(concat(
    aws_acm_certificate.acm_certificate.*.id,
    aws_acm_certificate.acm_certificate_private_ca.*.id,
    aws_acm_certificate.acm_certificate_exist.*.id,
    [""]),
  0)
}

output "aws_acm_certificate_arn" {
  description = "The ARN of the certificate"
  value = element(concat(
    aws_acm_certificate.acm_certificate.*.arn,
    aws_acm_certificate.acm_certificate_private_ca.*.arn,
    aws_acm_certificate.acm_certificate_exist.*.arn,
    [""]),
  0)
}

output "aws_acm_certificate_domain_name" {
  description = "The domain name for which the certificate is issued"
  value = element(concat(
    aws_acm_certificate.acm_certificate.*.domain_name,
    aws_acm_certificate.acm_certificate_private_ca.*.domain_name,
    aws_acm_certificate.acm_certificate_exist.*.domain_name,
    [""]),
  0)
}

output "aws_acm_certificate_domain_validation_options" {
  description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used"
  value = element(concat(
    aws_acm_certificate.acm_certificate.*.domain_validation_options,
    aws_acm_certificate.acm_certificate_private_ca.*.domain_validation_options,
    aws_acm_certificate.acm_certificate_exist.*.domain_validation_options,
    [""]),
  0)
}

#---------------------------------------------------
# AWS ACM (Amazon Certificate Manager) certificate validation
#---------------------------------------------------
output "acm_certificate_validation_id" {
  description = "The time at which the certificate was issued"
  value       = element(concat(aws_acm_certificate_validation.acm_certificate_validation.*.id, [""]), 0)
}

#---------------------------------------------------
# acmpca
#---------------------------------------------------
output "acmpca_certificate_authority_id" {
  description = "Amazon Resource Name (ARN) of the certificate authority."
  value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority.*.id, [""]), 0)
}

output "acmpca_certificate_authority_arn" {
  description = "Amazon Resource Name (ARN) of the certificate authority."
  value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority.*.arn, [""]), 0)
}

output "acmpca_certificate_authority_certificate" {
  description = "Base64-encoded certificate authority (CA) certificate. Only available after the certificate authority certificate has been imported."
  value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority.*.certificate, [""]), 0)
}

output "acmpca_certificate_authority_certificate_chain" {
  description = "Base64-encoded certificate chain that includes any intermediate certificates and chains up to root on-premises certificate that you used to sign your private CA certificate. The chain does not include your private CA certificate. Only available after the certificate authority certificate has been imported."
  value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority.*.certificate_chain, [""]), 0)
}

output "acmpca_certificate_authority_certificate_signing_request" {
  description = "The base64 PEM-encoded certificate signing request (CSR) for your private CA certificate."
  value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority.*.certificate_signing_request, [""]), 0)
}

output "acmpca_certificate_authority_not_after" {
  description = "Date and time after which the certificate authority is not valid. Only available after the certificate authority certificate has been imported."
  value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority.*.not_after, [""]), 0)
}

output "acmpca_certificate_authority_not_before" {
  description = "Date and time before which the certificate authority is not valid. Only available after the certificate authority certificate has been imported."
  value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority.*.not_before, [""]), 0)
}

output "acmpca_certificate_authority_serial" {
  description = "Serial number of the certificate authority. Only available after the certificate authority certificate has been imported."
  value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority.*.serial, [""]), 0)
}

output "acmpca_certificate_authority_status" {
  description = "Status of the certificate authority."
  value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority.*.status, [""]), 0)
}
