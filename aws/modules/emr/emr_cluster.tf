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
  security_configuration            = var.emr_cluster_security_configuration != "" && ! var.enable_emr_security_configuration ? var.emr_cluster_security_configuration : element(concat(aws_emr_security_configuration.emr_security_configuration.*.id, [""]), 0)
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
    }
  }

  dynamic "master_instance_group" {
    iterator = master_instance_group
    for_each = var.emr_cluster_master_instance_group_ebs_config
    content {
      instance_type = lookup(master_instance_group.value, "instance_type", null)

      name           = lookup(master_instance_group.value, "name", null)
      bid_price      = lookup(master_instance_group.value, "bid_price", null)
      instance_count = lookup(master_instance_group.value, "instance_count", null)

      ebs_config {
        size = lookup(master_instance_group.value, "ebs_config_size", null)
        type = lookup(master_instance_group.value, "ebs_config_type", null)

        iops                 = lookup(master_instance_group.value, "ebs_config_iops", null)
        volumes_per_instance = lookup(master_instance_group.value, "ebs_config_volumes_per_instance", null)
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
    }
  }

  dynamic "core_instance_group" {
    iterator = core_instance_group
    for_each = var.emr_cluster_core_instance_group_ebs_config
    content {
      instance_type = lookup(core_instance_group.value, "instance_type", null)

      bid_price          = lookup(core_instance_group.value, "bid_price", null)
      autoscaling_policy = lookup(core_instance_group.value, "autoscaling_policy", null)
      instance_count     = lookup(core_instance_group.value, "instance_count", null)

      ebs_config {
        size = lookup(core_instance_group.value, "ebs_config_size", null)
        type = lookup(core_instance_group.value, "ebs_config_type", null)

        iops                 = lookup(core_instance_group.value, "ebs_config_iops", null)
        volumes_per_instance = lookup(core_instance_group.value, "ebs_config_volumes_per_instance", null)
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

      hadoop_jar_step {
        args       = lookup(step.value, "hadoop_args", null)
        jar        = lookup(step.value, "hadoop_jar", null)
        main_class = lookup(step.value, "hadoop_main_class", null)
        properties = lookup(step.value, "hadoop_properties", null)
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
