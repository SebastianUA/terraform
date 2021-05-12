#---------------------------------------------------
# AWS EMR cluster
#---------------------------------------------------
resource "aws_emr_cluster" "emr_cluster" {
  count = var.enable_emr_cluster ? 1 : 0

  name          = var.emr_cluster_name != "" ? var.emr_cluster_name : "${lower(var.name)}-emr-cluster-${lower(var.environment)}"
  release_label = var.emr_cluster_release_label
  service_role  = var.emr_cluster_service_role

  scale_down_behavior               = var.emr_cluster_scale_down_behavior
  additional_info                   = var.emr_cluster_additional_info
  security_configuration            = var.emr_cluster_security_configuration != "" && !var.enable_emr_security_configuration ? var.emr_cluster_security_configuration : element(concat(aws_emr_security_configuration.emr_security_configuration.*.id, [""]), 0)
  log_uri                           = var.emr_cluster_log_uri
  applications                      = var.emr_cluster_applications
  termination_protection            = var.emr_cluster_termination_protection
  keep_job_flow_alive_when_no_steps = var.emr_cluster_keep_job_flow_alive_when_no_steps
  ebs_root_volume_size              = var.emr_cluster_ebs_root_volume_size
  custom_ami_id                     = var.emr_cluster_custom_ami_id
  configurations                    = var.emr_cluster_configurations
  configurations_json               = var.emr_cluster_configurations_json
  visible_to_all_users              = var.emr_cluster_visible_to_all_users
  autoscaling_role                  = var.emr_cluster_autoscaling_role
  step_concurrency_level            = var.emr_cluster_step_concurrency_level

  dynamic "master_instance_group" {
    iterator = master_instance_group
    for_each = var.emr_cluster_master_instance_group

    content {
      instance_type = lookup(master_instance_group.value, "instance_type", null)

      name           = lookup(master_instance_group.value, "name", null)
      bid_price      = lookup(master_instance_group.value, "bid_price", null)
      instance_count = lookup(master_instance_group.value, "instance_count", null)

      dynamic "ebs_config" {
        iterator = ebs_config
        for_each = length(keys(lookup(master_instance_group.value, "ebs_config", {}))) > 0 ? [lookup(master_instance_group.value, "ebs_config", {})] : []

        content {
          size = lookup(ebs_config.value, "size", null)
          type = lookup(ebs_config.value, "type", null)

          iops                 = lookup(ebs_config.value, "iops", null)
          volumes_per_instance = lookup(ebs_config.value, "volumes_per_instance", null)
        }
      }
    }
  }

  dynamic "master_instance_fleet" {
    iterator = master_instance_fleet
    for_each = var.emr_cluster_master_instance_fleet

    content {
      name                      = lookup(master_instance_fleet.value, "name", null)
      target_on_demand_capacity = lookup(master_instance_fleet.value, "target_on_demand_capacity", null)
      target_spot_capacity      = lookup(master_instance_fleet.value, "target_spot_capacity", null)

      dynamic "instance_type_configs" {
        iterator = instance_type_configs
        for_each = lookup(master_instance_fleet.value, "instance_type_configs", [])

        content {
          instance_type                              = lookup(instance_type_configs.value, "instance_type", null)
          bid_price                                  = lookup(instance_type_configs.value, "bid_price", null)
          bid_price_as_percentage_of_on_demand_price = lookup(instance_type_configs.value, "bid_price_as_percentage_of_on_demand_price", null)

          weighted_capacity = lookup(instance_type_configs.value, "weighted_capacity", null)

          dynamic "configurations" {
            iterator = configurations
            for_each = length(keys(lookup(instance_type_configs.value, "configurations", {}))) > 0 ? [lookup(instance_type_configs.value, "configurations", {})] : []

            content {
              classification = lookup(configurations.value, "classification", null)
              properties     = lookup(configurations.value, "properties", null)
            }
          }

          dynamic "ebs_config" {
            iterator = ebs_config
            for_each = length(keys(lookup(instance_type_configs.value, "ebs_config", {}))) > 0 ? [lookup(instance_type_configs.value, "ebs_config", {})] : []

            content {
              size = lookup(ebs_config.value, "size", null)
              type = lookup(ebs_config.value, "type", null)

              iops                 = lookup(ebs_config.value, "iops", null)
              volumes_per_instance = lookup(ebs_config.value, "volumes_per_instance", null)
            }
          }
        }
      }

      dynamic "launch_specifications" {
        iterator = launch_specifications
        for_each = lookup(master_instance_fleet.value, "launch_specifications", [])

        content {
          dynamic "on_demand_specification" {
            iterator = on_demand_specification
            for_each = length(keys(lookup(launch_specifications.value, "on_demand_specification", {}))) > 0 ? [lookup(launch_specifications.value, "on_demand_specification", {})] : []

            content {
              allocation_strategy = lookup(on_demand_specification.value, "allocation_strategy", null)
            }
          }

          dynamic "spot_specification" {
            iterator = spot_specification
            for_each = length(keys(lookup(launch_specifications.value, "spot_specification", {}))) > 0 ? [lookup(launch_specifications.value, "spot_specification", {})] : []

            content {
              allocation_strategy      = lookup(spot_specification.value, "allocation_strategy", "capacity-optimized")
              block_duration_minutes   = lookup(spot_specification.value, "block_duration_minutes", null)
              timeout_action           = lookup(spot_specification.value, "timeout_action", null)
              timeout_duration_minutes = lookup(spot_specification.value, "timeout_duration_minutes", null)
            }
          }
        }
      }
    }
  }

  dynamic "core_instance_group" {
    iterator = core_instance_group
    for_each = var.emr_cluster_core_instance_group

    content {
      instance_type = lookup(core_instance_group.value, "instance_type", null)

      bid_price          = lookup(core_instance_group.value, "bid_price", null)
      autoscaling_policy = lookup(core_instance_group.value, "autoscaling_policy", null)
      instance_count     = lookup(core_instance_group.value, "instance_count", null)

      dynamic "ebs_config" {
        iterator = ebs_config
        for_each = length(keys(lookup(core_instance_group.value, "ebs_config", {}))) > 0 ? [lookup(core_instance_group.value, "ebs_config", {})] : []

        content {
          size = lookup(ebs_config.value, "size", null)
          type = lookup(ebs_config.value, "type", null)

          iops                 = lookup(ebs_config.value, "iops", null)
          volumes_per_instance = lookup(ebs_config.value, "volumes_per_instance", null)
        }
      }
    }
  }

  dynamic "core_instance_fleet" {
    iterator = core_instance_fleet
    for_each = var.emr_cluster_core_instance_fleet

    content {
      name                      = lookup(core_instance_fleet.value, "name", null)
      target_on_demand_capacity = lookup(core_instance_fleet.value, "target_on_demand_capacity", null)
      target_spot_capacity      = lookup(core_instance_fleet.value, "target_spot_capacity", null)

      dynamic "instance_type_configs" {
        iterator = instance_type_configs
        for_each = lookup(core_instance_fleet.value, "instance_type_configs", [])

        content {
          instance_type                              = lookup(instance_type_configs.value, "instance_type", null)
          bid_price                                  = lookup(instance_type_configs.value, "bid_price", null)
          bid_price_as_percentage_of_on_demand_price = lookup(instance_type_configs.value, "bid_price_as_percentage_of_on_demand_price", null)

          weighted_capacity = lookup(instance_type_configs.value, "weighted_capacity", null)

          dynamic "configurations" {
            iterator = configurations
            for_each = length(keys(lookup(instance_type_configs.value, "configurations", {}))) > 0 ? [lookup(instance_type_configs.value, "configurations", {})] : []

            content {
              classification = lookup(configurations.value, "classification", null)
              properties     = lookup(configurations.value, "properties", null)
            }
          }

          dynamic "ebs_config" {
            iterator = ebs_config
            for_each = length(keys(lookup(instance_type_configs.value, "ebs_config", {}))) > 0 ? [lookup(instance_type_configs.value, "ebs_config", {})] : []

            content {
              size = lookup(ebs_config.value, "size", null)
              type = lookup(ebs_config.value, "type", null)

              iops                 = lookup(ebs_config.value, "iops", null)
              volumes_per_instance = lookup(ebs_config.value, "volumes_per_instance", null)
            }
          }
        }
      }

      dynamic "launch_specifications" {
        iterator = launch_specifications
        for_each = lookup(core_instance_fleet.value, "launch_specifications", [])

        content {
          dynamic "on_demand_specification" {
            iterator = on_demand_specification
            for_each = length(keys(lookup(launch_specifications.value, "on_demand_specification", {}))) > 0 ? [lookup(launch_specifications.value, "on_demand_specification", {})] : []

            content {
              allocation_strategy = lookup(on_demand_specification.value, "allocation_strategy", null)
            }
          }

          dynamic "spot_specification" {
            iterator = spot_specification
            for_each = length(keys(lookup(launch_specifications.value, "spot_specification", {}))) > 0 ? [lookup(launch_specifications.value, "spot_specification", {})] : []

            content {
              allocation_strategy      = lookup(spot_specification.value, "allocation_strategy", "capacity-optimized")
              block_duration_minutes   = lookup(spot_specification.value, "block_duration_minutes", null)
              timeout_action           = lookup(spot_specification.value, "timeout_action", null)
              timeout_duration_minutes = lookup(spot_specification.value, "timeout_duration_minutes", null)
            }
          }
        }
      }
    }
  }

  dynamic "ec2_attributes" {
    iterator = ec2_attributes
    for_each = var.emr_cluster_ec2_attributes

    content {
      key_name                          = lookup(ec2_attributes.value, "key_name", null)
      subnet_id                         = lookup(ec2_attributes.value, "subnet_id", null)
      additional_master_security_groups = lookup(ec2_attributes.value, "additional_master_security_groups", null)
      additional_slave_security_groups  = lookup(ec2_attributes.value, "additional_slave_security_groups", null)
      emr_managed_master_security_group = lookup(ec2_attributes.value, "emr_managed_master_security_group", null)
      emr_managed_slave_security_group  = lookup(ec2_attributes.value, "emr_managed_slave_security_group", null)
      service_access_security_group     = lookup(ec2_attributes.value, "service_access_security_group", null)
      instance_profile                  = lookup(ec2_attributes.value, "instance_profile", null)

    }
  }

  dynamic "kerberos_attributes" {
    iterator = kerberos_attributes
    for_each = var.emr_cluster_kerberos_attributes

    content {
      kdc_admin_password = lookup(kerberos_attributes.value, "kdc_admin_password", null)
      realm              = lookup(kerberos_attributes.value, "realm", null)

      ad_domain_join_password              = lookup(kerberos_attributes.value, "ad_domain_join_password", null)
      ad_domain_join_user                  = lookup(kerberos_attributes.value, "ad_domain_join_user", null)
      cross_realm_trust_principal_password = lookup(kerberos_attributes.value, "cross_realm_trust_principal_password", null)
    }
  }

  dynamic "bootstrap_action" {
    iterator = bootstrap_action
    for_each = var.emr_cluster_bootstrap_action

    content {
      name = lookup(bootstrap_action.value, "name", null)
      path = lookup(bootstrap_action.value, "path", null)

      args = lookup(bootstrap_action.value, "args", null)
    }
  }

  dynamic "step" {
    iterator = step
    for_each = var.emr_cluster_step

    content {
      name              = lookup(step.value, "name", null)
      action_on_failure = lookup(step.value, "action_on_failure", null)

      dynamic "hadoop_jar_step" {
        iterator = hadoop_jar_step
        for_each = length(keys(lookup(step.value, "hadoop_jar_step", {}))) > 0 ? [lookup(step.value, "hadoop_jar_step", {})] : []

        content {
          args       = lookup(hadoop_jar_step.value, "args", null)
          jar        = lookup(hadoop_jar_step.value, "jar", null)
          main_class = lookup(hadoop_jar_step.value, "main_class", null)
          properties = lookup(hadoop_jar_step.value, "properties", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.emr_cluster_name != "" ? var.emr_cluster_name : "${lower(var.name)}-emr-cluster-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_emr_security_configuration.emr_security_configuration
  ]
}
