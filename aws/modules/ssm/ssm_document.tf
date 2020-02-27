#-----------------------------------------------------------
# AWS SSM document
#-----------------------------------------------------------
resource "aws_ssm_document" "ssm_document" {
    count               = var.enable_ssm_document ? 1 : 0

    name                = var.ssm_document_name != "" ? lower(var.ssm_document_name) : "${lower(var.name)}-document-${lower(var.environment)}"
    document_type       = var.ssm_document_document_type
    content             = var.ssm_document_content

    document_format     = upper(var.ssm_document_document_format)
    target_type         = var.ssm_document_target_type

    dynamic "attachments_source" {
        for_each = var.ssm_document_attachments_source
        content {
            key         = lookup(ssm_document_attachments_source.value, "key", null)
            values      = lookup(ssm_document_attachments_source.value, "values", null)
            name        = lookup(ssm_document_attachments_source.value, "name", null)
        }
    }

    tags = merge(
        {
            "Name"          = var.ssm_document_name != "" ? lower(var.ssm_document_name) : "${lower(var.name)}-document-${lower(var.environment)}"
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = []
}
