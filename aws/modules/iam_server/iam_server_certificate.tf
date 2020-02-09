#-----------------------------------------------------------
# Create AWS IAM server certificate
#-----------------------------------------------------------
resource "aws_iam_server_certificate" "iam_server_certificate" {
    count               = var.enable_iam_server_certificate ? 1 : 0

    name                = var.iam_server_certificate_name != "" && var.iam_server_certificate_name_prefix == "" ? lower(var.iam_server_certificate_name) : null
    name_prefix         = var.iam_server_certificate_name_prefix != "" && var.iam_server_certificate_name == "" ? lower(var.iam_server_certificate_name_prefix) : null
    certificate_body    = var.iam_server_certificate_body
    private_key         = var.iam_server_certificate_private_key

    certificate_chain   = var.iam_server_certificate_chain
    path                = var.iam_server_certificate_path
                        
    lifecycle {
        create_before_destroy = true
        ignore_changes          = []
    }

    depends_on  = []
}