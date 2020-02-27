#---------------------------------------------------
# acm_certificate
#---------------------------------------------------

output "aws_acm_certificate_id" {
    description = "The ARN of the certificate"
    value       = "${aws_acm_certificate.acm_certificate.*.id}"
}

output "aws_acm_certificate_arn" {
    description = "The ARN of the certificate"
    value       = "${aws_acm_certificate.acm_certificate.*.arn}"
}

output "aws_acm_certificate_domain_name" {
    description = "The domain name for which the certificate is issued"
    value       = "${aws_acm_certificate.acm_certificate.*.domain_name}"
}

output "aws_acm_certificate_domain_validation_options" {
    description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used"
    value       = "${aws_acm_certificate.acm_certificate.*.domain_validation_options}"
}

#output "aws_acm_certificate_resource_record_name" {
#    description = ""
#    value       = "${aws_acm_certificate.acm_certificate.domain_validation_options.*.resource_record_name}"
#}
#
#output "aws_acm_certificate_resource_record_type" {
#    description = ""
#    value       = "${aws_acm_certificate.acm_certificate.domain_validation_options.*.resource_record_type}"
#}
#
#output "aws_acm_certificate_resource_record_value" {
#    description = ""
#    value       = "${aws_acm_certificate.acm_certificate.domain_validation_options.*.resource_record_value}"
#}

#---------------------------------------------------
# acmpca
#---------------------------------------------------
output "acmpca_certificate_authority_default_id" {
    description = "Amazon Resource Name (ARN) of the certificate authority."
    value       = "${aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.id}"
}

output "acmpca_certificate_authority_default_arn" {
    description = "Amazon Resource Name (ARN) of the certificate authority."
    value       = "${aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.arn}"
}

output "acmpca_certificate_authority_default_certificate" {
    description = "Base64-encoded certificate authority (CA) certificate. Only available after the certificate authority certificate has been imported."
    value       = "${aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.certificate}"
}

output "acmpca_certificate_authority_default_certificate_chain" {
    description = "Base64-encoded certificate chain that includes any intermediate certificates and chains up to root on-premises certificate that you used to sign your private CA certificate. The chain does not include your private CA certificate. Only available after the certificate authority certificate has been imported."
    value       = "${aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.certificate_chain}"
}

output "acmpca_certificate_authority_default_certificate_signing_request" {
    description = "The base64 PEM-encoded certificate signing request (CSR) for your private CA certificate."
    value       = "${aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.certificate_signing_request}"
}

output "acmpca_certificate_authority_default_not_after" {
    description = "Date and time after which the certificate authority is not valid. Only available after the certificate authority certificate has been imported."
    value       = "${aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.not_after}"
}

output "acmpca_certificate_authority_default_not_before" {
    description = "Date and time before which the certificate authority is not valid. Only available after the certificate authority certificate has been imported."
    value       = "${aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.not_before}"
}

output "acmpca_certificate_authority_default_serial" {
    description = "Serial number of the certificate authority. Only available after the certificate authority certificate has been imported."
    value       = "${aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.serial}"
}

output "acmpca_certificate_authority_default_status" {
    description = "Status of the certificate authority."
    value       = "${aws_acmpca_certificate_authority.acmpca_certificate_authority_default.*.status}"
}
