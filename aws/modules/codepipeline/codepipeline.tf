#---------------------------------------------------
# AWS codepipeline
#---------------------------------------------------
resource "aws_codepipeline" "codepipeline" {
    count           = var.enable_codepipeline ? 1 : 0

    name            = var.codepipeline_name != "" ? lower(var.codepipeline_name) : "${lower(var.name)}-codepipeline-${lower(var.environment)}"
    role_arn        = var.codepipeline_role_arn

    artifact_store {
        type            = upper(var.codepipeline_artifact_store_type)
        location        = var.codepipeline_artifact_store_location

        region          = var.codepipeline_artifact_store_region

        dynamic "encryption_key" {
            iterator = encrptkey
            for_each = var.codepipeline_artifact_store_encryption_key
            content {
                id      = lookup(encrptkey.value, "id", null)
                type    = lookup(encrptkey.value, "type", null)
            }
        }
    }

    stage {
        name        = var.codepipeline_stage1_name !="" ? var.codepipeline_stage1_name : "Source"

        action {
            name                = var.codepipeline_stage1_action_name !="" ? var.codepipeline_stage1_action_name : "Source"
            category            = var.codepipeline_stage1_action_category !="" ? var.codepipeline_stage1_action_category : "Source"
            owner               = var.codepipeline_stage1_action_owner !="" ? var.codepipeline_stage1_action_owner : "AWS"
            provider            = var.codepipeline_stage1_action_provider !="" ? var.codepipeline_stage1_action_provider : "CodeCommit"
            version             = var.codepipeline_stage1_action_version

            configuration       = var.codepipeline_stage1_action_configuration
            input_artifacts     = var.codepipeline_stage1_action_input_artifacts
            output_artifacts    = var.codepipeline_stage1_action_output_artifacts
            role_arn            = var.codepipeline_stage1_action_role_arn
            run_order           = var.codepipeline_stage1_action_run_order
            region              = var.codepipeline_stage1_action_region
        }
    }

    stage {
        name        = var.codepipeline_stage2_name !="" ? var.codepipeline_stage2_name : "Build"

        action {
            name                = var.codepipeline_stage2_action_name !="" ? var.codepipeline_stage2_action_name : "Build"
            category            = var.codepipeline_stage2_action_category !="" ? var.codepipeline_stage2_action_category : "Build"
            owner               = var.codepipeline_stage2_action_owner !="" ? var.codepipeline_stage2_action_owner : "AWS"
            provider            = var.codepipeline_stage2_action_provider !="" ? var.codepipeline_stage2_action_provider : "CodeBuild"
            version             = var.codepipeline_stage2_action_version

            configuration       = var.codepipeline_stage2_action_configuration
            input_artifacts     = var.codepipeline_stage2_action_input_artifacts
            output_artifacts    = var.codepipeline_stage2_action_output_artifacts
            role_arn            = var.codepipeline_stage2_action_role_arn
            run_order           = var.codepipeline_stage2_action_run_order
            region              = var.codepipeline_stage2_action_region
        }
    }

    stage {
        name        = var.codepipeline_stage3_name !="" ? var.codepipeline_stage3_name : "Deploy"

        action {
            name                = var.codepipeline_stage3_action_name !="" ? var.codepipeline_stage3_action_name : "Deploy"
            category            = var.codepipeline_stage3_action_category !="" ? var.codepipeline_stage3_action_category : "Deploy"
            owner               = var.codepipeline_stage3_action_owner !="" ? var.codepipeline_stage3_action_owner : "AWS"
            provider            = var.codepipeline_stage3_action_provider !="" ? var.codepipeline_stage3_action_provider : "ECS"
            version             = var.codepipeline_stage3_action_version

            configuration       = var.codepipeline_stage3_action_configuration
            input_artifacts     = var.codepipeline_stage3_action_input_artifacts
            output_artifacts    = var.codepipeline_stage3_action_output_artifacts
            role_arn            = var.codepipeline_stage3_action_role_arn
            run_order           = var.codepipeline_stage3_action_run_order
            region              = var.codepipeline_stage3_action_region
        }
    }

    tags            = merge(
        {
            "Name"  = var.codepipeline_name != "" ? lower(var.codepipeline_name) : "${lower(var.name)}-codepipeline-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = []
}
