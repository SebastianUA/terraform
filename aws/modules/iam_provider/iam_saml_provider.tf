#-----------------------------------------------------------
# IAM saml provider
#-----------------------------------------------------------
resource "aws_iam_saml_provider" "iam_saml_provider" {
    count                   = var.enable_iam_saml_provider ? 1 : 0

    name                    = var.iam_saml_provider_name != "" ? var.iam_saml_provider_name : "${lower(var.name)}-saml-${lower(var.environment)}"
    saml_metadata_document  = var.iam_saml_provider_saml_metadata_document

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = []
}