#---------------------------------------------------
# AWS codedeploy deployment config
#---------------------------------------------------
resource "aws_codedeploy_deployment_config" "codedeploy_deployment_config_canary" {
  count = var.enable_codedeploy_deployment_config_canary ? 1 : 0

  deployment_config_name = var.codedeploy_deployment_config_canary_deployment_config_name != "" ? lower(var.codedeploy_deployment_config_canary_deployment_config_name) : "${lower(var.name)}-deployment-config-canary-${lower(var.environment)}"
  compute_platform       = var.codedeploy_deployment_config_canary_compute_platform

  minimum_healthy_hosts {
    type  = upper(var.minimum_healthy_hosts_canary_type)
    value = var.minimum_healthy_hosts_canary_value
  }

  traffic_routing_config {
    type = var.traffic_routing_config_canary_type

    time_based_canary {
      interval   = var.traffic_routing_config_canary_time_based_canary_interval
      percentage = var.traffic_routing_config_canary_time_based_canary_percentage
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

resource "aws_codedeploy_deployment_config" "codedeploy_deployment_config_linear" {
  count = var.enable_codedeploy_deployment_config_linear ? 1 : 0

  deployment_config_name = var.codedeploy_deployment_config_linear_deployment_config_name != "" ? lower(var.codedeploy_deployment_config_linear_deployment_config_name) : "${lower(var.name)}-deployment-config-linear-${lower(var.environment)}"
  compute_platform       = var.codedeploy_deployment_config_linear_compute_platform

  minimum_healthy_hosts {
    type  = upper(var.minimum_healthy_hosts_linear_type)
    value = var.minimum_healthy_hosts_linear_value
  }

  traffic_routing_config {
    type = var.traffic_routing_config_linear_type

    time_based_linear {
      interval   = var.traffic_routing_config_linear_time_based_linear_interval
      percentage = var.traffic_routing_config_linear_time_based_linear_percentage
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
