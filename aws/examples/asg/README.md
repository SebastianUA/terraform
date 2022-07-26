# Work with ASG via terraform

A terraform module for making ASG.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
module "key_pair" {
  source = "../../modules/key_pair"

  enable_key_pair          = true
  key_pair_key_name        = "test"
  key_pair_key_name_prefix = null
  key_pair_public_key      = file("/Users/captain/.ssh/id_rsa.pub")

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "lt" {
  source      = "../../modules/asg"
  name        = "my-first"
  region      = "us-west-2"
  environment = "test"

  enable_lt      = true
  lt_name        = ""
  lt_description = null
  lt_user_data   = null
  lt_image_id    = "ami-08f72eed8a0d9f8e8"

}

module "asg" {
  source      = "../../modules/asg"
  name        = "my-first"
  region      = "us-west-2"
  environment = "test"

  #lc
  enable_lc   = "true"
  lc_image_id = "ami-08f72eed8a0d9f8e8"


  lc_instance_type        = "t2.micro"
  lc_security_groups      = ["sg-07b62c0d0ea37056d"]
  lc_iam_instance_profile = ""

  lc_key_name  = module.key_pair.aws_key_id
  lc_user_data = null #file("./additional_files/bootstrap.sh")

  lc_enable_monitoring = "true"
  lc_placement_tenancy = "default"

  lc_root_block_device = {
    volume_size = 8
    volume_type = "gp3"
  }

  lc_ebs_block_device = [
    {
      device_name = "/dev/sdm"
      volume_size = 50
      volume_type = "gp3"

      delete_on_termination = null
      encrypted             = null
      iops                  = null
    }
  ]


  lc_associate_public_ip_address = null

  # asg
  enable_asg                    = true
  asg_vpc_zone_identifier       = ["subnet-0e2b323b731655057", "subnet-0ffa47878036f1641", "subnet-096406cfdf907ee11"]
  asg_max_size                  = 1
  asg_min_size                  = 0
  asg_desired_capacity          = 1
  asg_wait_for_capacity_timeout = 0

  enable_autoscaling_policy = true
  autoscaling_policy_stack = [
    {
      name                   = "scale_up"
      scaling_adjustment     = 4
      adjustment_type        = "ChangeInCapacity"
      cooldown               = 300
      autoscaling_group_name = ""

      target_tracking_configuration    = []
      predictive_scaling_configuration = []
    },
    {
      name                   = "scale_down"
      scaling_adjustment     = 2
      adjustment_type        = "ChangeInCapacity"
      cooldown               = 300
      autoscaling_group_name = ""

      target_tracking_configuration    = []
      predictive_scaling_configuration = []
    },
    {
      name                   = "test"
      adjustment_type        = "ChangeInCapacity"
      cooldown               = 300
      autoscaling_group_name = ""

      step_adjustment = [
        {
          scaling_adjustment          = 1
          metric_interval_lower_bound = 1.0
          metric_interval_upper_bound = 2.0
        }
      ]

      target_tracking_configuration    = []
      predictive_scaling_configuration = []
    }
  ]

  asg_tags = [
    {
      key                 = "Orchestration"
      value               = "Terraform"
      propagate_at_launch = true
    },
    {
      key                 = "Env"
      value               = "stage"
      propagate_at_launch = true
    }
  ]

  enable_autoscaling_schedule = true
  autoscaling_schedule_stack = [
    {
      scheduled_action_name  = "scale_out"
      min_size               = 0
      max_size               = 0
      desired_capacity       = 0
      recurrence             = "0 9 * * *"
      autoscaling_group_name = ""
    },
    {
      scheduled_action_name  = "scale_in"
      min_size               = 0
      max_size               = 0
      desired_capacity       = 0
      recurrence             = "0 17 * * *"
      autoscaling_group_name = ""
    }
  ]

}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `ami` - I added only 3 regions to show the map feature but you can add all (`default = {'us-east-1': 'ami-9887c6e7', 'us-west-2': 'ami-3ecc8f46', 'eu-west-1': 'ami-6e28b517'}`)
- `enable_lc` - Whether to create launch configuration (`default = False`)
- `lc_name` - Custome name for lc (`default = ""`)
- `lc_name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with name. (`default = null`)
- `lc_image_id` - The EC2 image ID to launch. (`default = ""`)
- `lc_instance_type` - (Required) The size of instance to launch(t2.micro, m1.xlarge, c1.medium etc). (`default = t2.micro`)
- `lc_security_groups` - A list of security group IDs to assign to the launch configuration (`default = []`)
- `lc_iam_instance_profile` - The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. (`default = ""`)
- `lc_key_name` - (Optional) The key name that should be used for the instance. (`default = null`)
- `lc_user_data` - (Optional) The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead. (`default = null`)
- `lc_associate_public_ip_address` - Enabling associate public ip address (Associate a public ip address with an instance in a VPC) (`default = null`)
- `lc_enable_monitoring` - (Optional) Enables/disables detailed monitoring. This is enabled by default. If true, the launched EC2 instance will have detailed monitoring enabled (`default = True`)
- `lc_placement_tenancy` - The tenancy of the instance. Valid values are 'default' or 'dedicated' (`default = default`)
- `lc_spot_price` - (Optional; Default: On-demand price) The maximum price to use for reserving spot instances. (`default = null`)
- `lc_ebs_optimized` - (Optional) If true, the launched EC2 instance will be EBS-optimized. (`default = null`)
- `lc_ebs_block_device` - Additional EBS block devices to attach to the instance (`default = []`)
- `lc_root_block_device` - Customize details about the root block device of the instance. See Block Devices below for details (`default = {}`)
- `lc_ephemeral_block_device` - Customize Ephemeral (also known as Instance Store) volumes on the instance (`default = []`)
- `enable_lt` - Enable ASG with launch_template (`default = False`)
- `lt_name` - The name of the launch template. If you leave this blank, Terraform will auto-generate a unique name. (`default = ""`)
- `lt_name_prefix` - Creates a unique name beginning with the specified prefix. Conflicts with name. (`default = null`)
- `lt_description` - Description of the launch template. (`default = null`)
- `lt_default_version` - Default Version of the launch template. (`default = null`)
- `lt_update_default_version` - Whether to update Default Version each update. Conflicts with default_version. (`default = null`)
- `lt_image_id` - The AMI from which to launch the instance. (`default = ""`)
- `lt_kernel_id` - The kernel ID. (`default = null`)
- `lt_ram_disk_id` - The ID of the RAM disk. (`default = null`)
- `lt_instance_initiated_shutdown_behavior` - Shutdown behavior for the instance. Can be stop or terminate. (Default: stop). (`default = stop`)
- `lt_instance_type` - The type of the instance. (`default = t2.micro`)
- `lt_disable_api_termination` - If true, enables EC2 Instance Termination Protection (`default = null`)
- `lt_ebs_optimized` - If true, the launched EC2 instance will be EBS-optimized. (`default = null`)
- `lt_security_group_names` - A list of security group names to associate with. If you are creating Instances in a VPC, use vpc_security_group_ids instead. (`default = null`)
- `lt_vpc_security_group_ids` - A list of security group IDs to associate with. (`default = null`)
- `lt_key_name` - The key name to use for the instance. (`default = null`)
- `lt_user_data` - The Base64-encoded user data to provide when launching the instance. (`default = null`)
- `lt_block_device_mappings` - Specify volumes to attach to the instance besides the volumes specified by the AMI. (`default = []`)
- `lt_capacity_reservation_specification` - Targeting for EC2 capacity reservations. (`default = []`)
- `lt_cpu_options` - The CPU options for the instance. See CPU Options below for more details. (`default = []`)
- `lt_credit_specification` - Customize the credit specification of the instance. See Credit Specification below for more details. (`default = []`)
- `lt_elastic_gpu_specifications` - The elastic GPU to attach to the instance. See Elastic GPU below for more details. (`default = []`)
- `lt_elastic_inference_accelerator` - (Optional) Configuration block containing an Elastic Inference Accelerator to attach to the instance. See Elastic Inference Accelerator below for more details. (`default = []`)
- `lt_iam_instance_profile` - The IAM Instance Profile to launch the instance with. See Instance Profile below for more details. (`default = []`)
- `lt_instance_market_options` - The market (purchasing) option for the instance. See Market Options below for details. (`default = []`)
- `lt_license_specification` - A list of license specifications to associate with. See License Specification below for more details. (`default = []`)
- `lt_metadata_options` - (Optional) Customize the metadata options for the instance. See Metadata Options below for more details. (`default = []`)
- `lt_monitoring` - The monitoring option for the instance. See Monitoring below for more details. (`default = []`)
- `lt_network_interfaces` - Customize network interfaces to be attached at instance boot time. See Network Interfaces below for more details. (`default = []`)
- `lt_placement` - The placement of the instance. See Placement below for more details. (`default = []`)
- `lt_hibernation_options` - The hibernation options for the instance. See Hibernation Options below for more details. (`default = []`)
- `lt_tag_specifications` - The tags to apply to the resources during launch. See Tag Specifications below for more details. (`default = []`)
- `lt_tags` - (Optional) A map of tags to assign to the launch template. (`default = {}`)
- `enable_asg` - Whether to create autoscaling group (`default = False`)
- `asg_name` - Whether to create autoscaling group (`default = ""`)
- `asg_name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with name. If empty, will use name (`default = null`)
- `asg_availability_zones` - Availability zones for AWS ASG (`default = {'us-east-1': 'us-east-1b,us-east-1c,us-east-1d,us-east-1e', 'us-east-2': 'us-east-2a,eu-east-2b,eu-east-2c', 'us-west-1': 'us-west-1a,us-west-1c', 'us-west-2': 'us-west-2a,us-west-2b,us-west-2c', 'ca-central-1': 'ca-central-1a,ca-central-1b', 'eu-west-1': 'eu-west-1a,eu-west-1b,eu-west-1c', 'eu-west-2': 'eu-west-2a,eu-west-2b', 'eu-central-1': 'eu-central-1a,eu-central-1b,eu-central-1c', 'ap-south-1': 'ap-south-1a,ap-south-1b', 'sa-east-1': 'sa-east-1a,sa-east-1c', 'ap-northeast-1': 'ap-northeast-1a,ap-northeast-1c', 'ap-southeast-1': 'ap-southeast-1a,ap-southeast-1b', 'ap-southeast-2': 'ap-southeast-2a,ap-southeast-2b,ap-southeast-2c', 'ap-northeast-2': 'ap-northeast-2a,ap-northeast-2c'}`)
- `asg_launch_configuration` - The name of the launch configuration to use (if it is created outside of this module) (`default = ""`)
- `asg_launch_template` - (Optional) Nested argument with Launch template specification to use to launch instances. (`default = []`)
- `asg_vpc_zone_identifier` - A list of subnet IDs to launch resources in (`default = []`)
- `asg_max_size` - Max size of instances to making autoscaling (`default = 1`)
- `asg_min_size` - Min size of instances to making autoscaling (`default = 1`)
- `asg_desired_capacity` - Desired numbers of servers in ASG (`default = 1`)
- `asg_health_check_grace_period` - Time (in seconds) after instance comes into service before checking health. (`default = 300`)
- `asg_health_check_type` - Controls how health checking is done. Need to choose 'EC2' or 'ELB' (`default = EC2`)
- `asg_min_elb_capacity` - Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes (`default = null`)
- `asg_wait_for_elb_capacity` - Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior. (`default = null`)
- `asg_target_group_arns` - A list of aws_alb_target_group ARNs, for use with Application Load Balancing (`default = null`)
- `asg_load_balancers` - (Optional) A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use target_group_arns instead. (`default = null`)
- `asg_default_cooldown` - The amount of time, in seconds, after a scaling activity completes before another scaling activity can start (`default = 300`)
- `asg_force_delete` - Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. (`default = True`)
- `asg_termination_policies` - A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default (`default = ['Default']`)
- `asg_suspended_processes` - A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly. (`default = []`)
- `asg_placement_group` - The name of the placement group into which you'll launch your instances, if any (`default = ""`)
- `asg_metrics_granularity` - The granularity to associate with the metrics to collect. The only valid value is 1Minute (`default = 1Minute`)
- `asg_enabled_metrics` - A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances (`default = ['GroupMinSize', 'GroupMaxSize', 'GroupDesiredCapacity', 'GroupInServiceInstances', 'GroupPendingInstances', 'GroupStandbyInstances', 'GroupTerminatingInstances', 'GroupTotalInstances']`)
- `asg_wait_for_capacity_timeout` - A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. (`default = 10m`)
- `asg_protect_from_scale_in` - Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events. (`default = False`)
- `asg_timeouts` - Set timeouts for ASG (`default = {}`)
- `asg_mixed_instances_policy` - (Optional) Configuration block containing settings to define launch targets for Auto Scaling groups. (`default = []`)
- `asg_initial_lifecycle_hook` - (Optional) One or more Lifecycle Hooks to attach to the autoscaling group before instances are launched. The syntax is exactly the same as the separate aws_autoscaling_lifecycle_hook resource, without the autoscaling_group_name attribute. Please note that this will only work when creating a new autoscaling group. For all other use-cases, please use aws_autoscaling_lifecycle_hook resource. (`default = []`)
- `asg_max_instance_lifetime` - (Optional) The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds. (`default = null`)
- `asg_tags` - A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch. (`default = []`)
- `asg_warm_pool` - (Optional) If this block is configured, add a Warm Pool to the specified Auto Scaling group. (`default = []`)
- `asg_capacity_rebalance` - (Optional) Indicates whether capacity rebalance is enabled. Otherwise, capacity rebalance is disabled. (`default = null`)
- `asg_service_linked_role_arn` - (Optional) The ARN of the service-linked role that the ASG will use to call other AWS services (`default = null`)
- `aws_instance_refresh` - (Optional) If this block is configured, start an Instance Refresh when this Auto Scaling Group is updated. (`default = []`)
- `enable_asg_tag` - Enable asg tags (`default = False`)
- `asg_tag_autoscaling_group_name` - Set list of asg names for asg tag resource (`default = []`)
- `asg_tag_tags` - Set list of tags for asg tag resource (`default = []`)
- `enable_autoscaling_attachment` - Enable asg attachment (`default = False`)
- `load_balancer_type` - Type of load balancer. Ex: ELB, ALB etc (`default = ELB`)
- `load_balancers` - An elastic load balancer name/ALB to add to the autoscaling group names (`default = []`)
- `autoscaling_group_name` - (Required) Name of ASG to associate with the ELB or ALB. Also, The name of the Auto Scaling group to which you want to assign the lifecycle hoo (`default = ""`)
- `lb_target_group_arn` - (Optional) The ARN of an ALB Target Group. (`default = null`)
- `enable_autoscaling_lifecycle_hook` - Enable autoscaling lifecycle hook (`default = False`)
- `autoscaling_lifecycle_hook_name` - (Required) The name of the lifecycle hook. (`default = ""`)
- `autoscaling_lifecycle_hook_default_result` - Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON. The default value for this parameter is ABANDON. (`default = ABANDON`)
- `autoscaling_lifecycle_hook_heartbeat_timeout` - (Optional) Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out. When the lifecycle hook times out, Auto Scaling performs the action defined in the DefaultResult parameter (`default = 10`)
- `autoscaling_lifecycle_hook_lifecycle_transition` - (Required) The instance state to which you want to attach the lifecycle hook. (`default = autoscaling:EC2_INSTANCE_LAUNCHING`)
- `autoscaling_lifecycle_hook_notification_metadata` - (Optional) Contains additional information that you want to include any time Auto Scaling sends a message to the notification target. (`default = ""`)
- `autoscaling_lifecycle_hook_notification_target_arn` - (Optional) The ARN of the notification target that Auto Scaling will use to notify you when an instance is in the transition state for the lifecycle hook. This ARN target can be either an SQS queue or an SNS topic. (`default = ""`)
- `autoscaling_lifecycle_hook_role_arn` - (Optional) The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target. (`default = ""`)
- `enable_autoscaling_notification` - Enable autoscaling notification (`default = False`)
- `autoscaling_groups_filter` - A filter used to scope the list e.g. by tags (`default = []`)
- `autoscaling_notification_notifications` - (Required) A list of Notification Types that trigger notifications. (`default = ['autoscaling:EC2_INSTANCE_LAUNCH', 'autoscaling:EC2_INSTANCE_TERMINATE', 'autoscaling:EC2_INSTANCE_LAUNCH_ERROR', 'autoscaling:EC2_INSTANCE_TERMINATE_ERROR']`)
- `autoscaling_notification_topic_arns` - (Required) The Topic ARNs for notifications to be sent through (`default = []`)
- `enable_autoscaling_policy` - Enabling autoscaling schedule (`default = False`)
- `autoscaling_policy_stack` - Set autoscaling policy as stack (`default = []`)
- `enable_autoscaling_schedule` - Enabling autoscaling schedule (`default = False`)
- `autoscaling_schedule_stack` - Set autoscaling schedule as stack (`default = []`)

## Module Output Variables
----------------------
- `launch_configuration_id` - The ID of the launch configuration
- `launch_configuration_name` - The name of the launch configuration
- `launch_configuration_associate_public_ip_address` - Whether a Public IP address is associated with the instance.
- `launch_configuration_user_data` - The User Data of the instance.
- `launch_template_arn` - Amazon Resource Name (ARN) of the launch template.
- `launch_template_id` - The ID of the launch template.
- `launch_template_latest_version` - The latest version of the launch template.
- `autoscaling_group_id` - The autoscaling group id
- `autoscaling_group_name` - The autoscaling group name
- `autoscaling_group_arn` - The ARN for this AutoScaling Group
- `autoscaling_group_min_size` - The minimum size of the autoscale group
- `autoscaling_group_max_size` - The maximum size of the autoscale group
- `autoscaling_group_desired_capacity` - The number of Amazon EC2 instances that should be running in the group
- `autoscaling_group_default_cooldown` - Time between a scaling activity and the succeeding scaling activity
- `autoscaling_group_health_check_grace_period` - Time after instance comes into service before checking health
- `autoscaling_group_health_check_type` - EC2 or ELB. Controls how health checking is done
- `asg_tag_id` - ASG name and key, separated by a comma


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
