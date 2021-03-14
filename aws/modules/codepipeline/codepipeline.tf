#---------------------------------------------------
# AWS codepipeline
#---------------------------------------------------
resource "aws_codepipeline" "codepipeline" {
  count = var.enable_codepipeline ? length(var.codepipeline_stack) : 0

  name     = lookup(var.codepipeline_stack[count.index], "name", "${lower(var.name)}-codepipeline-${count.index + 1}-${lower(var.environment)}")
  role_arn = lookup(var.codepipeline_stack[count.index], "name", null)

  dynamic "artifact_store" {
    iterator = artifact_store
    for_each = length(keys(lookup(var.codepipeline_stack[count.index], "artifact_store", {}))) > 0 ? [lookup(var.codepipeline_stack[count.index], "artifact_store", {})] : []

    content {
      type     = lookup(artifact_store.value, "type", null)
      location = lookup(artifact_store.value, "location", null)

      region = lookup(artifact_store.value, "region", null)

      dynamic "encryption_key" {
        iterator = encryption_key
        for_each = length(keys(lookup(artifact_store.value, "encryption_key", {}))) > 0 ? [lookup(artifact_store.value, "encryption_key", {})] : []

        content {
          id   = lookup(encryption_key.value, "id", null)
          type = lookup(encryption_key.value, "type", null)
        }
      }
    }
  }

  dynamic "stage" {
    iterator = stage
    for_each = lookup(var.codepipeline_stack[count.index], "stage", [])

    content {
      name = lookup(stage.value, "name", "${lower(var.name)}-stage-${count.index + 1}-${lower(var.environment)}")

      dynamic "action" {
        iterator = action
        for_each = length(keys(lookup(stage.value, "action", {}))) > 0 ? [lookup(stage.value, "action", {})] : []

        content {
          name     = lookup(action.value, "name", null)
          category = lookup(action.value, "category", null)
          owner    = lookup(action.value, "owner", null)
          provider = lookup(action.value, "provider", null)
          version  = lookup(action.value, "version", null)

          configuration    = lookup(action.value, "configuration", null)
          input_artifacts  = lookup(action.value, "input_artifacts", null)
          output_artifacts = lookup(action.value, "output_artifacts", null)
          role_arn         = lookup(action.value, "role_arn", null)
          run_order        = lookup(action.value, "run_order", null)
          region           = lookup(action.value, "region", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = lookup(var.codepipeline_stack[count.index], "name", "${lower(var.name)}-codepipeline-${count.index + 1}-${lower(var.environment)}")
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
