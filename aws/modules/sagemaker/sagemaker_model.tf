#---------------------------------------------------
# AWS Gagemaker model
#---------------------------------------------------
resource "aws_sagemaker_model" "sagemaker_model" {
  count = var.enable_sagemaker_model ? 1 : 0

  name               = var.sagemaker_model_name != "" ? lower(var.sagemaker_model_name) : "${lower(var.name)}-model-${lower(var.environment)}"
  execution_role_arn = var.sagemaker_model_execution_role_arn

  enable_network_isolation = var.sagemaker_model_enable_network_isolation

  dynamic "primary_container" {
    iterator = primary_container
    for_each = var.sagemaker_model_primary_container

    content {
      image = lookup(primary_container.value, "image", null)

      model_data_url     = lookup(primary_container.value, "model_data_url", null)
      container_hostname = lookup(primary_container.value, "container_hostname", null)
      environment        = lookup(primary_container.value, "environment", null)
    }
  }

  dynamic "container" {
    iterator = container
    for_each = var.sagemaker_model_container

    content {
      image = lookup(container.value, "image", null)

      model_data_url     = lookup(container.value, "model_data_url", null)
      container_hostname = lookup(container.value, "container_hostname", null)
      environment        = lookup(container.value, "environment", null)
    }
  }

  dynamic "vpc_config" {
    iterator = vpc_config
    for_each = var.sagemaker_model_vpc_config

    content {
      subnets            = lookup(vpc_config.value, "subnets", null)
      security_group_ids = lookup(vpc_config.value, "security_group_ids", null)
    }
  }

  tags = merge(
    {
      Name = var.sagemaker_model_name != "" ? lower(var.sagemaker_model_name) : "${lower(var.name)}-model-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
