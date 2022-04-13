#---------------------------------------------------
# Add autoscaling policy rules
#---------------------------------------------------
resource "aws_autoscaling_policy" "autoscaling_policy" {
  count = var.enable_autoscaling_policy && length(var.autoscaling_policy_stack) > 0 ? length(var.autoscaling_policy_stack) : 0

  name                   = lookup(var.autoscaling_policy_stack[count.index], "name", null)
  autoscaling_group_name = lookup(var.autoscaling_policy_stack[count.index], "autoscaling_group_name", (var.autoscaling_group_name != "" ? var.autoscaling_group_name : element(concat(aws_autoscaling_group.asg.*.name, [""]), 0)))

  scaling_adjustment      = lookup(var.autoscaling_policy_stack[count.index], "scaling_adjustment", null)
  policy_type             = lookup(var.autoscaling_policy_stack[count.index], "policy_type", null)
  adjustment_type         = lookup(var.autoscaling_policy_stack[count.index], "adjustment_type", null)
  metric_aggregation_type = lookup(var.autoscaling_policy_stack[count.index], "metric_aggregation_type", null)
  cooldown                = lookup(var.autoscaling_policy_stack[count.index], "cooldown", null)

  estimated_instance_warmup = lookup(var.autoscaling_policy_stack[count.index], "estimated_instance_warmup", null)

  dynamic "step_adjustment" {
    iterator = step_adjustment
    for_each = lookup(var.autoscaling_policy_stack[count.index], "step_adjustment", [])

    content {
      scaling_adjustment          = lookup(step_adjustment.value, "scaling_adjustment", null)
      metric_interval_lower_bound = lookup(step_adjustment.value, "metric_interval_lower_bound", null)
      metric_interval_upper_bound = lookup(step_adjustment.value, "metric_interval_upper_bound", null)
    }
  }

  dynamic "target_tracking_configuration" {
    iterator = target_tracking_configuration
    for_each = lookup(var.autoscaling_policy_stack[count.index], "target_tracking_configuration", [])

    content {
      target_value = lookup(target_tracking_configuration.value, "target_value", null)

      dynamic "predefined_metric_specification" {
        iterator = predefined_metric_specification
        for_each = lookup(target_tracking_configuration.value, "target_tracking_configuration", [])

        content {
          predefined_metric_type = lookup(predefined_metric_specification.value, "predefined_metric_type", null)

          resource_label = lookup(predefined_metric_specification.value, "resource_label", null)
        }
      }

      dynamic "customized_metric_specification" {
        iterator = customized_metric_specification
        for_each = lookup(target_tracking_configuration.value, "customized_metric_specification", [])

        content {
          metric_name = lookup(customized_metric_specification.value, "metric_name", null)
          namespace   = lookup(customized_metric_specification.value, "namespace", null)
          statistic   = lookup(customized_metric_specification.value, "statistic", null)

          unit = lookup(customized_metric_specification.value, "unit", null)


          dynamic "metric_dimension" {
            iterator = metric_dimension
            for_each = lookup(customized_metric_specification.value, "metric_dimension", [])

            content {
              name  = lookup(metric_dimension.value, "name", null)
              value = lookup(metric_dimension.value, "value", null)
            }
          }
        }
      }
    }
  }

  dynamic "predictive_scaling_configuration" {
    iterator = predictive_scaling_configuration
    for_each = lookup(var.autoscaling_policy_stack[count.index], "predictive_scaling_configuration", [])

    content {
      max_capacity_breach_behavior = lookup(predictive_scaling_configuration.value, "max_capacity_breach_behavior", null)
      max_capacity_buffer          = lookup(predictive_scaling_configuration.value, "max_capacity_buffer", null)
      scheduling_buffer_time       = lookup(predictive_scaling_configuration.value, "scheduling_buffer_time", null)

      mode = lookup(predictive_scaling_configuration.value, "mode", null)

      dynamic "metric_specification" {
        iterator = metric_specification
        for_each = lookup(predictive_scaling_configuration.value, "metric_specification", [])

        content {
          target_value = lookup(metric_specification.value, "target_value", null)

          dynamic "customized_capacity_metric_specification" {
            iterator = customized_capacity_metric_specification
            for_each = lookup(metric_specification.value, "customized_capacity_metric_specification", [])

            content {
              dynamic "metric_data_queries" {
                iterator = metric_data_queries
                for_each = lookup(customized_capacity_metric_specification.value, "metric_data_queries", [])

                content {
                  id = lookup(metric_data_queries.value, "id", null)

                  expression  = lookup(metric_data_queries.value, "expression", null)
                  label       = lookup(metric_data_queries.value, "label", null)
                  return_data = lookup(metric_data_queries.value, "return_data", null)

                  dynamic "metric_stat" {
                    iterator = metric_stat
                    for_each = lookup(metric_data_queries.value, "metric_stat", [])

                    content {
                      dynamic "metric" {
                        iterator = metric
                        for_each = lookup(metric_stat.value, "metric_stat", [])

                        content {
                          namespace   = lookup(metric.value, "namespace", null)
                          metric_name = lookup(metric.value, "metric_name", null)

                          dynamic "dimensions" {
                            iterator = dimensions
                            for_each = lookup(metric.value, "dimensions", [])

                            content {
                              name  = lookup(dimensions.value, "name", null)
                              value = lookup(dimensions.value, "value", null)
                            }
                          }
                        }
                      }
                      stat = lookup(metric_stat.value, "stat", null)
                      unit = lookup(metric_stat.value, "unit", null)
                    }
                  }
                }
              }
            }

          }

          dynamic "customized_load_metric_specification" {
            iterator = customized_load_metric_specification
            for_each = lookup(metric_specification.value, "customized_load_metric_specification", [])

            content {
              dynamic "metric_data_queries" {
                iterator = metric_data_queries
                for_each = lookup(customized_load_metric_specification.value, "metric_data_queries", [])

                content {
                  id = lookup(metric_data_queries.value, "id", null)

                  expression  = lookup(metric_data_queries.value, "expression", null)
                  label       = lookup(metric_data_queries.value, "label", null)
                  return_data = lookup(metric_data_queries.value, "return_data", null)

                  dynamic "metric_stat" {
                    iterator = metric_stat
                    for_each = lookup(customized_load_metric_specification.value, "metric_stat", [])

                    content {
                      dynamic "metric" {
                        iterator = metric
                        for_each = lookup(customized_load_metric_specification.value, "metric_stat", [])

                        content {
                          namespace   = lookup(metric.value, "namespace", null)
                          metric_name = lookup(metric.value, "metric_name", null)

                          dynamic "dimensions" {
                            iterator = dimensions
                            for_each = lookup(metric.value, "dimensions", [])

                            content {
                              name  = lookup(dimensions.value, "name", null)
                              value = lookup(dimensions.value, "value", null)
                            }
                          }
                        }
                      }
                      stat = lookup(metric_stat.value, "stat", null)
                      unit = lookup(metric_stat.value, "unit", null)
                    }
                  }
                }
              }
            }

          }

          dynamic "customized_scaling_metric_specification" {
            iterator = customized_scaling_metric_specification
            for_each = lookup(metric_specification.value, "customized_scaling_metric_specification", [])

            content {
              dynamic "metric_data_queries" {
                iterator = metric_data_queries
                for_each = lookup(customized_scaling_metric_specification.value, "metric_data_queries", [])

                content {
                  id = lookup(metric_data_queries.value, "id", null)

                  expression  = lookup(metric_data_queries.value, "expression", null)
                  label       = lookup(metric_data_queries.value, "label", null)
                  return_data = lookup(metric_data_queries.value, "return_data", null)

                  dynamic "metric_stat" {
                    iterator = metric_stat
                    for_each = lookup(customized_scaling_metric_specification.value, "metric_stat", [])

                    content {
                      dynamic "metric" {
                        iterator = metric
                        for_each = lookup(customized_scaling_metric_specification.value, "metric_stat", [])

                        content {
                          namespace   = lookup(metric.value, "namespace", null)
                          metric_name = lookup(metric.value, "metric_name", null)

                          dynamic "dimensions" {
                            iterator = dimensions
                            for_each = lookup(metric.value, "dimensions", [])

                            content {
                              name  = lookup(dimensions.value, "name", null)
                              value = lookup(dimensions.value, "value", null)
                            }
                          }
                        }
                      }
                      stat = lookup(metric_stat.value, "stat", null)
                      unit = lookup(metric_stat.value, "unit", null)
                    }
                  }
                }
              }
            }
          }

          dynamic "predefined_load_metric_specification" {
            iterator = predefined_load_metric_specification
            for_each = lookup(metric_specification.value, "predefined_load_metric_specification", [])

            content {
              predefined_metric_type = lookup(predefined_load_metric_specification.value, "predefined_metric_type", null)
              resource_label         = lookup(predefined_load_metric_specification.value, "resource_label", null)
            }
          }

          dynamic "predefined_metric_pair_specification" {
            iterator = predefined_metric_pair_specification
            for_each = lookup(metric_specification.value, "predefined_metric_pair_specification", [])

            content {
              predefined_metric_type = lookup(predefined_metric_pair_specification.value, "predefined_metric_type", null)
              resource_label         = lookup(predefined_metric_pair_specification.value, "resource_label", null)
            }
          }

          dynamic "predefined_scaling_metric_specification" {
            iterator = predefined_scaling_metric_specification
            for_each = lookup(metric_specification.value, "predefined_scaling_metric_specification", [])

            content {
              predefined_metric_type = lookup(predefined_scaling_metric_specification.value, "predefined_metric_type", null)
              resource_label         = lookup(predefined_scaling_metric_specification.value, "resource_label", null)
            }
          }

        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_autoscaling_group.asg
  ]
}
