#---------------------------------------------------
# AWS Sagemaker workteam
#---------------------------------------------------
resource "aws_sagemaker_workteam" "sagemaker_workteam" {
  count = var.enable_sagemaker_workteam ? 1 : 0

  workteam_name  = var.sagemaker_workteam_name != "" ? var.sagemaker_workteam_name : "${lower(var.name)}-workteam-${lower(var.environment)}"
  workforce_name = var.sagemaker_workteam_workforce_name != "" ? var.sagemaker_workteam_workforce_name : (var.enable_sagemaker_workforce ? aws_sagemaker_workforce.sagemaker_workforce[count.index].id : null)
  description    = var.sagemaker_workteam_description

  dynamic "member_definition" {
    iterator = member_definition
    for_each = var.sagemaker_workteam_member_definition

    content {
      dynamic "cognito_member_definition" {
        iterator = cognito_member_definition
        for_each = length(keys(lookup(member_definition.value, "cognito_member_definition", {}))) > 0 ? [lookup(member_definition.value, "cognito_member_definition", {})] : []

        content {
          client_id  = lookup(cognito_member_definition.value, "client_id", null)
          user_pool  = lookup(cognito_member_definition.value, "user_pool", null)
          user_group = lookup(cognito_member_definition.value, "user_group", null)
        }
      }

      dynamic "oidc_member_definition" {
        iterator = oidc_member_definition
        for_each = length(keys(lookup(member_definition.value, "oidc_member_definition", {}))) > 0 ? [lookup(member_definition.value, "oidc_member_definition", {})] : []

        content {
          groups = lookup(oidc_member_definition.value, "groups", null)
        }
      }
    }
  }

  dynamic "notification_configuration" {
    iterator = notification_configuration
    for_each = var.sagemaker_workteam_notification_configuration

    content {
      notification_topic_arn = lookup(notification_configuration.value, "notification_topic_arn", null)
    }
  }

  tags = merge(
    {
      Name = var.sagemaker_workteam_name != "" ? var.sagemaker_workteam_name : "${lower(var.name)}-workteam-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_workforce.sagemaker_workforce
  ]
}