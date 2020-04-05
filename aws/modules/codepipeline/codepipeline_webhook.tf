#---------------------------------------------------
# AWS codepipeline webhook
#---------------------------------------------------
resource "aws_codepipeline_webhook" "codepipeline_webhook" {
    count                   = var.enable_codepipeline_webhook ? 1 : 0

    name                    = var.codepipeline_webhook_name != "" ? lower(var.codepipeline_webhook_name) : "${lower(var.name)}-codepipeline-webhook-${lower(var.environment)}"
    authentication          = upper(var.codepipeline_webhook_authentication)
    target_action           = var.codepipeline_webhook_target_action
    target_pipeline         = var.codepipeline_webhook_target_pipeline !="" && !var.enable_codepipeline ? var.codepipeline_webhook_target_pipeline : element(concat(aws_codepipeline.codepipeline.*.name, [""]), 0)

    filter {
        json_path    = var.codepipeline_webhook_filter1_json_path
        match_equals = var.codepipeline_webhook_filter1_match_equals
    }

    dynamic "authentication_configuration" {
        iterator = authconf
        for_each = var.codepipeline_webhook_authentication_configuration
        content {
            secret_token        = lookup(authconf.value, "secret_token", null)
            allowed_ip_range    = lookup(authconf.value, "allowed_ip_range", null)
        }
    }

    tags                    = merge(
        {
            "Name"  = var.codepipeline_webhook_name != "" ? lower(var.codepipeline_webhook_name) : "${lower(var.name)}-codepipeline-webhook-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = [
        aws_codepipeline.codepipeline
    ]
}
