#---------------------------------------------------
# acm_certificate
#---------------------------------------------------

output "aws_acm_certificate_id" {
    description = "The ARN of the certificate"
    value       = "${aws_acm_certificate.acm_certificate.*.id}"
}

output "aws_acm_certificate_arn" {
    description = "The ARN of the certificate"
    value       = "${aws_acm_certificate.acm_certificate.0.arn}"
}

output "aws_acm_certificate_domain_name" {
    description = "The domain name for which the certificate is issued"
    value       = "${aws_acm_certificate.acm_certificate.*.domain_name}"
}

output "aws_acm_certificate_domain_validation_options" {
    description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used"
    value       = "aws_acm_certificate.acm_certificate.*.domain_validation_options}"
}

#---------------------------------------------------
#
#---------------------------------------------------
