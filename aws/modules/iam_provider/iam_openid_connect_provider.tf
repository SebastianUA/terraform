#-----------------------------------------------------------
# IAM openid connect provider
#-----------------------------------------------------------
resource "aws_iam_openid_connect_provider" "iam_openid_connect_provider" {
    count                   = var.enable_iam_openid_connect_provider ? 1 : 0

    url                     = var.iam_openid_connect_provider_url
    client_id_list          = var.iam_openid_connect_provider_client_id_list
    thumbprint_list         = var.iam_openid_connect_provider_thumbprint_list

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = []
}
