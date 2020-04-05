#---------------------------------------------------
# AWS Codebuild source credential
#---------------------------------------------------
resource "aws_codebuild_source_credential" "codebuild_source_credential" {
    count           = var.enable_codebuild_source_credential ? 1 : 0

    auth_type       = upper(var.codebuild_source_credential_auth_type)
    server_type     = upper(var.codebuild_source_credential_server_type)
    token           = var.codebuild_source_credential_token

    user_name       = var.codebuild_source_credential_user_name

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = []
}
