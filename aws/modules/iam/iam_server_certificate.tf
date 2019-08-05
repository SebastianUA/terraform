#-----------------------------------------------------------
# Create AWS IAM server certificate
#-----------------------------------------------------------
resource "aws_iam_server_certificate" "iam_server_certificate" {
    count            = "${var.enable_iam_server_certificate ? 1 : 0}"

    name             = "${length(var.iam_server_certificate_name) > 0 ? var.iam_server_certificate_name : "${lower(var.name)}-certificate-${lower(var.environment)}" }"
    certificate_body = "${file("${var.certificate_body_file}")}"
    private_key      = "${file("${var.private_key_file}")}"
                        
    lifecycle {
        create_before_destroy = true,
        ignore_changes          = []
    }

    depends_on  = []
}
