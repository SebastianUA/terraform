#---------------------------------------------------
# AWS EMR instance fleet
#---------------------------------------------------
resource "aws_emr_instance_fleet" "emr_instance_fleet" {
  count = var.enable_emr_instance_fleet ? 1 : 0

  cluster_id = var.emr_instance_fleet_cluster_id != "" ? var.emr_instance_fleet_cluster_id : (var.enable_emr_cluster ? aws_emr_cluster.emr_cluster.0.id : null)

  name                      = var.emr_instance_fleet_name != "" ? var.emr_instance_fleet_name : "${var.name}-emr-instance-fleet-${var.environment}"
  target_on_demand_capacity = var.emr_instance_fleet_target_on_demand_capacity
  target_spot_capacity      = var.emr_instance_fleet_target_spot_capacity

  instance_type_configs {
    instance_type                              = lookup(var.emr_instance_fleet_instance_type_configs, "instance_type", null)
    weighted_capacity                          = lookup(var.emr_instance_fleet_instance_type_configs, "weighted_capacity", null)
    bid_price_as_percentage_of_on_demand_price = lookup(var.emr_instance_fleet_instance_type_configs, "bid_price_as_percentage_of_on_demand_price", null)
    bid_price                                  = lookup(var.emr_instance_fleet_instance_type_configs, "bid_price", null)

    dynamic "ebs_config" {
      iterator = ebs_config
      for_each = var.emr_instance_fleet_ebs_config
      content {
        size = lookup(ebs_config.value, "size", null)
        type = lookup(ebs_config.value, "type", null)

        iops                 = lookup(ebs_config.value, "iops", null)
        volumes_per_instance = lookup(ebs_config.value, "volumes_per_instance", null)
      }
    }

    dynamic "configurations" {
      iterator = configurations
      for_each = var.emr_instance_fleet_configurations
      content {
        classification = lookup(configurations.value, "classification", null)
        properties     = lookup(configurations.value, "properties", null)
      }
    }
  }

  launch_specifications {
    dynamic "spot_specification" {
      iterator = spot_specification
      for_each = var.emr_instance_fleet_spot_specification
      content {
        allocation_strategy      = lookup(spot_specification.value, "allocation_strategy", null)
        block_duration_minutes   = lookup(spot_specification.value, "block_duration_minutes", null)
        timeout_action           = lookup(spot_specification.value, "timeout_action", null)
        timeout_duration_minutes = lookup(spot_specification.value, "timeout_duration_minutes", null)
      }
    }

    dynamic "on_demand_specification" {
      iterator = on_demand_specification
      for_each = var.emr_instance_fleet_on_demand_specification
      content {
        allocation_strategy = lookup(on_demand_specification.value, "allocation_strategy", null)
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_emr_cluster.emr_cluster
  ]
}
