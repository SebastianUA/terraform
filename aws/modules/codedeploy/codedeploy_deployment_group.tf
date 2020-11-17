#---------------------------------------------------
# AWS codedeploy deployment group
#---------------------------------------------------
# Deployment group deployment
resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group" {
  count = var.enable_deployment_group_deployment ? 1 : 0

  app_name              = var.codedeploy_deployment_group_app_name != "" && ! var.enable_codedeploy_app ? var.codedeploy_deployment_group_app_name : element(concat(aws_codedeploy_app.codedeploy_app.*.name, [""]), 0)
  deployment_group_name = var.codedeploy_deployment_group_deployment_group_name != "" ? lower(var.codedeploy_deployment_group_deployment_group_name) : "${lower(var.name)}-deployment-group-${lower(var.environment)}"
  service_role_arn      = var.codedeploy_deployment_group_service_role_arn

  deployment_config_name = var.codedeploy_deployment_group_deployment_config_name != null ? var.codedeploy_deployment_group_deployment_config_name : null
  autoscaling_groups     = var.codedeploy_deployment_group_autoscaling_groups

  auto_rollback_configuration {
    enabled = var.auto_rollback_configuration_enabled
    events  = var.auto_rollback_configuration_events
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codedeploy_app.codedeploy_app
  ]
}

# Deployment group with notify deployment
resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group_notify" {
  count = var.enable_deployment_group_notify_deployment ? 1 : 0

  app_name              = var.codedeploy_deployment_group_app_name != "" && ! var.enable_codedeploy_app ? var.codedeploy_deployment_group_app_name : element(concat(aws_codedeploy_app.codedeploy_app.*.name, [""]), 0)
  deployment_group_name = var.codedeploy_deployment_group_deployment_group_name != "" ? lower(var.codedeploy_deployment_group_deployment_group_name) : "${lower(var.name)}-deployment-group-${lower(var.environment)}"
  service_role_arn      = var.codedeploy_deployment_group_service_role_arn

  deployment_config_name = var.codedeploy_deployment_group_deployment_config_name != null ? var.codedeploy_deployment_group_deployment_config_name : null
  autoscaling_groups     = var.codedeploy_deployment_group_autoscaling_groups

  auto_rollback_configuration {
    enabled = var.auto_rollback_configuration_enabled
    events  = var.auto_rollback_configuration_events
  }

  trigger_configuration {
    trigger_events     = var.trigger_configuration_trigger_events
    trigger_name       = var.trigger_configuration_trigger_name != "" ? lower(var.trigger_configuration_trigger_name) : "${lower(var.name)}-notify-trigger-${lower(var.environment)}"
    trigger_target_arn = var.trigger_configuration_trigger_target_arn
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codedeploy_app.codedeploy_app
  ]
}

# Deployment group with ec2tag deployment
resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group_ec2tag" {
  count = var.enable_deployment_group_ec2tag ? 1 : 0

  app_name              = var.codedeploy_deployment_group_app_name != "" && ! var.enable_codedeploy_app ? var.codedeploy_deployment_group_app_name : element(concat(aws_codedeploy_app.codedeploy_app.*.name, [""]), 0)
  deployment_group_name = var.codedeploy_deployment_group_deployment_group_name != "" ? lower(var.codedeploy_deployment_group_deployment_group_name) : "${lower(var.name)}-deployment-group-${lower(var.environment)}"
  service_role_arn      = var.codedeploy_deployment_group_service_role_arn

  deployment_config_name = var.codedeploy_deployment_group_deployment_config_name != null ? var.codedeploy_deployment_group_deployment_config_name : null
  autoscaling_groups     = var.codedeploy_deployment_group_autoscaling_groups

  auto_rollback_configuration {
    enabled = var.auto_rollback_configuration_enabled
    events  = var.auto_rollback_configuration_events
  }

  ec2_tag_filter {
    key   = var.ec2_tag_filter_key
    type  = var.ec2_tag_filter_type != null ? upper(var.ec2_tag_filter_type) : null
    value = var.ec2_tag_filter_value
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codedeploy_app.codedeploy_app
  ]
}

# Deployment group with ec2tag and notify deployment
resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group_ec2tag_notify" {
  count = var.enable_deployment_group_ec2tag_notify ? 1 : 0

  app_name              = var.codedeploy_deployment_group_app_name != "" && ! var.enable_codedeploy_app ? var.codedeploy_deployment_group_app_name : element(concat(aws_codedeploy_app.codedeploy_app.*.name, [""]), 0)
  deployment_group_name = var.codedeploy_deployment_group_deployment_group_name != "" ? lower(var.codedeploy_deployment_group_deployment_group_name) : "${lower(var.name)}-deployment-group-${lower(var.environment)}"
  service_role_arn      = var.codedeploy_deployment_group_service_role_arn

  deployment_config_name = var.codedeploy_deployment_group_deployment_config_name != null ? var.codedeploy_deployment_group_deployment_config_name : null
  autoscaling_groups     = var.codedeploy_deployment_group_autoscaling_groups

  auto_rollback_configuration {
    enabled = var.auto_rollback_configuration_enabled
    events  = var.auto_rollback_configuration_events
  }

  ec2_tag_filter {
    key   = var.ec2_tag_filter_key
    type  = var.ec2_tag_filter_type != null ? upper(var.ec2_tag_filter_type) : null
    value = var.ec2_tag_filter_value
  }

  trigger_configuration {
    trigger_events     = var.trigger_configuration_trigger_events
    trigger_name       = var.trigger_configuration_trigger_name != "" ? lower(var.trigger_configuration_trigger_name) : "${lower(var.name)}-notify-trigger-${lower(var.environment)}"
    trigger_target_arn = var.trigger_configuration_trigger_target_arn
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codedeploy_app.codedeploy_app
  ]
}

# Deployment group with blue & green deployment
resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group_blue_green" {
  count = var.enable_deployment_group_blue_green ? 1 : 0

  app_name              = var.codedeploy_deployment_group_app_name != "" && ! var.enable_codedeploy_app ? var.codedeploy_deployment_group_app_name : element(concat(aws_codedeploy_app.codedeploy_app.*.name, [""]), 0)
  deployment_group_name = var.codedeploy_deployment_group_deployment_group_name != "" ? lower(var.codedeploy_deployment_group_deployment_group_name) : "${lower(var.name)}-deployment-group-${lower(var.environment)}"
  service_role_arn      = var.codedeploy_deployment_group_service_role_arn

  # For Blue-Green deployment should be - CodeDeployDefault.AllAtOnce
  deployment_config_name = var.codedeploy_deployment_group_deployment_config_name != null ? var.codedeploy_deployment_group_deployment_config_name : null
  autoscaling_groups     = var.codedeploy_deployment_group_autoscaling_groups

  auto_rollback_configuration {
    enabled = var.auto_rollback_configuration_enabled
    events  = var.auto_rollback_configuration_events
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = var.blue_green_deployment_config_deployment_ready_option_action_on_timeout != null ? upper(var.blue_green_deployment_config_deployment_ready_option_action_on_timeout) : null
      wait_time_in_minutes = var.blue_green_deployment_config_deployment_ready_option_wait_time_in_minutes
    }

    terminate_blue_instances_on_deployment_success {
      action                           = var.terminate_blue_instances_on_deployment_success_action != null ? upper(var.terminate_blue_instances_on_deployment_success_action) : null
      termination_wait_time_in_minutes = var.terminate_blue_instances_on_deployment_success_termination_wait_time_in_minutes
    }
  }

  deployment_style {
    # For Blue-Green deployment should be - WITH_TRAFFIC_CONTROL
    deployment_option = var.deployment_style_deployment_option
    # For Blue-Green deployment should be - BLUE_GREEN
    deployment_type = var.deployment_style_deployment_type
  }

  trigger_configuration {
    trigger_events     = var.trigger_configuration_trigger_events
    trigger_name       = var.trigger_configuration_trigger_name != "" ? lower(var.trigger_configuration_trigger_name) : "${lower(var.name)}-notify-trigger-${lower(var.environment)}"
    trigger_target_arn = var.trigger_configuration_trigger_target_arn
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codedeploy_app.codedeploy_app
  ]
}
