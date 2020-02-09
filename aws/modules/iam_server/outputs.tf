#-----------------------------------------------------------
# IAM server certificate
#-----------------------------------------------------------
output "iam_server_certificate_id" {
    description = "The unique Server Certificate name"
    value       = element(concat(aws_iam_server_certificate.iam_server_certificate.*.id, [""]), 0)
}

output "iam_server_certificate_arn" {
    description = "The Amazon Resource Name (ARN) specifying the server certificate."
    value       = element(concat(aws_iam_server_certificate.iam_server_certificate.*.arn, [""]), 0)
}

output "iam_server_certificate_name" {
    description = "The name of the Server Certificate"
    value       = element(concat(aws_iam_server_certificate.iam_server_certificate.*.name, [""]), 0)
}