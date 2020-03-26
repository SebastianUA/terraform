#---------------------------------------------------
# acm certificate
#---------------------------------------------------
output "aws_acm_certificate_id" {
    description = "The ARN of the certificate"
    value       = element(concat(aws_acm_certificate.acm_certificate.*.id, [""]), 0)
}

output "aws_acm_certificate_arn" {
    description = "The ARN of the certificate"
    value       = element(concat(aws_acm_certificate.acm_certificate.*.arn, [""]), 0)
}

output "aws_acm_certificate_domain_name" {
    description = "The domain name for which the certificate is issued"
    value       = element(concat(aws_acm_certificate.acm_certificate.*.domain_name, [""]), 0)
}

output "aws_acm_certificate_domain_validation_options" {
    description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used"
    value       = element(concat(aws_acm_certificate.acm_certificate.*.domain_validation_options, [""]), 0)
}

#output "aws_acm_certificate_resource_record_name" {
#    description = ""
#    value       = element(concat(aws_acm_certificate.acm_certificate.domain_validation_options.*.resource_record_name, [""]), 0)
#}
#
#output "aws_acm_certificate_resource_record_type" {
#    description = ""
#    value       = element(concat(aws_acm_certificate.acm_certificate.domain_validation_options.*.resource_record_type, [""]), 0)
#}
#
#output "aws_acm_certificate_resource_record_value" {
#    description = ""
#    value       = element(concat(aws_acm_certificate.acm_certificate.domain_validation_options.*.resource_record_value, [""]), 0)
#}

#---------------------------------------------------
# acmpca
#---------------------------------------------------
output "acmpca_certificate_authority_default_id" {
    description = "Amazon Resource Name (ARN) of the certificate authority."
    value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.id, [""]), 0)
}

output "acmpca_certificate_authority_default_arn" {
    description = "Amazon Resource Name (ARN) of the certificate authority."
    value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.arn, [""]), 0)
}

output "acmpca_certificate_authority_default_certificate" {
    description = "Base64-encoded certificate authority (CA) certificate. Only available after the certificate authority certificate has been imported."
    value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.certificate, [""]), 0)
}

output "acmpca_certificate_authority_default_certificate_chain" {
    description = "Base64-encoded certificate chain that includes any intermediate certificates and chains up to root on-premises certificate that you used to sign your private CA certificate. The chain does not include your private CA certificate. Only available after the certificate authority certificate has been imported."
    value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.certificate_chain, [""]), 0)
}

output "acmpca_certificate_authority_default_certificate_signing_request" {
    description = "The base64 PEM-encoded certificate signing request (CSR) for your private CA certificate."
    value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.certificate_signing_request, [""]), 0)
}

output "acmpca_certificate_authority_default_not_after" {
    description = "Date and time after which the certificate authority is not valid. Only available after the certificate authority certificate has been imported."
    value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.not_after, [""]), 0)
}

output "acmpca_certificate_authority_default_not_before" {
    description = "Date and time before which the certificate authority is not valid. Only available after the certificate authority certificate has been imported."
    value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.not_before, [""]), 0)
}

output "acmpca_certificate_authority_default_serial" {
    description = "Serial number of the certificate authority. Only available after the certificate authority certificate has been imported."
    value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.serial, [""]), 0)
}

output "acmpca_certificate_authority_default_status" {
    description = "Status of the certificate authority."
    value       = element(concat(aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.status, [""]), 0)
}
