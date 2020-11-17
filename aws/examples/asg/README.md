# Work with AWS ASG via terraform

A terraform module for making ASG.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#############################################################
# AWS key pair
#############################################################
module "key_pair" {
  source = "../../modules/key_pair"

  enable_key_pair = true
  key_name        = "test-key"
  public_key      = file("./additional_files/prod-bastion_ukraine.pub")
}

module "asg" {
  source      = "../../modules/asg"
  name        = "my-first"
  region      = "us-west-2"
  environment = "test"

  #lc
  enable_lc = "true"
  ami = {
    us-west-2 = "ami-08f72eed8a0d9f8e8"
  }

  ec2_instance_type    = "t2.micro"
  security_groups      = ["sg-07b62c0d0ea37056d"]
  iam_instance_profile = ""

  key_name  = element(module.key_pair.aws_key_id, 0)
  user_data = file("./additional_files/bootstrap.sh")

  enable_monitoring = "true"
  placement_tenancy = "default"

  root_block_device = [
    {
      volume_size = "8"
      volume_type = "gp2"
    },
  ]

  #enable_associate_public_ip_address  = true

  # asg
  enable_asg                = "true"
  vpc_zone_identifier       = ["subnet-0e2b323b731655057", "subnet-0ffa47878036f1641", "subnet-096406cfdf907ee11"]
  asg_max_size              = 1
  asg_min_size              = 0
  desired_capacity          = 1
  wait_for_capacity_timeout = "0"
  tags = [
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

  # ASG attachment
  #load_balancer_type                  = "ALB"
  #load_balancers                      = ["test-lb"]
  #alb_target_group_arn                = "lb_arn_here"

  # ASG policy
  enable_autoscaling_policy = true
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch. (`default = ""`)
- `enable_asg` - Whether to create autoscaling group (`default = ""`)
- `asg_name` - Whether to create autoscaling group (`default = ""`)
- `enable_asg_azs` - Enable ASG with AZS. If not, will use vpc_zone_identifier (`default = ""`)
- `launch_configuration` - The name of the launch configuration to use (if it is created outside of this module) (`default = ""`)
- `name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with name. If empty, will use name (`default = ""`)
- `vpc_zone_identifier` - A list of subnet IDs to launch resources in (`default = ""`)
- `asg_max_size` - Max size of instances to making autoscaling (`default = 1`)
- `asg_min_size` - Min size of instances to making autoscaling (`default = 1`)
- `desired_capacity` - Desired numbers of servers in ASG (`default = 1`)
- `health_check_grace_period` - Time (in seconds) after instance comes into service before checking health. (`default = 300`)
- `health_check_type` - Controls how health checking is done. Need to choose 'EC2' or 'ELB' (`default = EC2`)
- `min_elb_capacity` - Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes (`default = null`)
- `wait_for_elb_capacity` - Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior. (`default = null`)
- `target_group_arns` - A list of aws_alb_target_group ARNs, for use with Application Load Balancing (`default = null`)
- `default_cooldown` - The amount of time, in seconds, after a scaling activity completes before another scaling activity can start (`default = 300`)
- `force_delete` - Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. (`default = True`)
- `termination_policies` - A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default (`default = ['Default']`)
- `suspended_processes` - A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly. (`default = ""`)
- `placement_group` - The name of the placement group into which you'll launch your instances, if any (`default = ""`)
- `metrics_granularity` - The granularity to associate with the metrics to collect. The only valid value is 1Minute (`default = 1Minute`)
- `enabled_metrics` - A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances (`default = ['GroupMinSize', 'GroupMaxSize', 'GroupDesiredCapacity', 'GroupInServiceInstances', 'GroupPendingInstances', 'GroupStandbyInstances', 'GroupTerminatingInstances', 'GroupTotalInstances']`)
- `wait_for_capacity_timeout` - A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. (`default = 10m`)
- `protect_from_scale_in` - Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events. (`default = ""`)
- `timeouts_delete` - (Default 10 minutes) Used for destroying ASG. (`default = 10m`)
- `load_balancer_type` - Type of load balancer. Ex: ELB, ALB etc (`default = elb`)
- `load_balancers` - An elastic load balancer name/ALB to add to the autoscaling group names (`default = ""`)
- `autoscaling_group_name` - (Required) Name of ASG to associate with the ELB or ALB. Also, The name of the Auto Scaling group to which you want to assign the lifecycle hoo (`default = ""`)
- `alb_target_group_arn` - (Optional) The ARN of an ALB Target Group. (`default = ""`)
- `enable_autoscaling_lifecycle_hook` - Enable autoscaling lifecycle hook (`default = ""`)
- `autoscaling_lifecycle_hook_name` - (Required) The name of the lifecycle hook. (`default = ""`)
- `autoscaling_lifecycle_hook_default_result` - Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON. The default value for this parameter is ABANDON. (`default = ABANDON`)
- `autoscaling_lifecycle_hook_heartbeat_timeout` - (Optional) Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out. When the lifecycle hook times out, Auto Scaling performs the action defined in the DefaultResult parameter (`default = 10`)
- `autoscaling_lifecycle_hook_lifecycle_transition` - (Required) The instance state to which you want to attach the lifecycle hook. (`default = autoscaling:EC2_INSTANCE_LAUNCHING`)
- `autoscaling_lifecycle_hook_notification_metadata` - (Optional) Contains additional information that you want to include any time Auto Scaling sends a message to the notification target. (`default = ""`)
- `autoscaling_lifecycle_hook_notification_target_arn` - (Optional) The ARN of the notification target that Auto Scaling will use to notify you when an instance is in the transition state for the lifecycle hook. This ARN target can be either an SQS queue or an SNS topic. (`default = ""`)
- `autoscaling_lifecycle_hook_role_arn` - (Optional) The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target. (`default = ""`)
- `enable_autoscaling_notification` - Enable autoscaling notification (`default = ""`)
- `autoscaling_groups_filter` - A filter used to scope the list e.g. by tags (`default = ""`)
- `autoscaling_notification_notifications` - (Required) A list of Notification Types that trigger notifications. (`default = ['autoscaling:EC2_INSTANCE_LAUNCH', 'autoscaling:EC2_INSTANCE_TERMINATE', 'autoscaling:EC2_INSTANCE_LAUNCH_ERROR', 'autoscaling:EC2_INSTANCE_TERMINATE_ERROR']`)
- `autoscaling_notification_topic_arn` - (Required) The Topic ARN for notifications to be sent through (`default = ""`)
- `enable_autoscaling_policy` - Enabling autoscaling schedule (`default = ""`)
- `autoscaling_scale_up_policy` - Set asg policy name for scale up (`default = ""`)
- `autoscaling_scale_down_policy` - Set asg policy name for scale down (`default = ""`)
- `asg_size_scale` - Size of instances to making autoscaling(up/down) (`default = 1`)
- `adjustment_type` - Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity. (`default = ChangeInCapacity`)
- `enable_autoscaling_schedule` - Enabling autoscaling schedule (`default = ""`)
- `scheduled_action_name_scale_out` - Set scheduled action name for scale out time (`default = ""`)
- `scheduled_action_name_scale_in` - Set scheduled action name for scale in time (`default = ""`)
- `asg_recurrence_scale_up` -  Cronjob time for scale-up (`default = 0 9 * * *`)
- `asg_recurrence_scale_down` -  Cronjob time for scale-down (`default = 0 17 * * *`)
- `enable_lc` - Whether to create launch configuration (`default = ""`)
- `launch_configuration_name` - Custome name for lc (`default = ""`)
- `enable_lc_spot` - Whether to create launch configuration (`default = ""`)
- `ec2_instance_type` - Type of instance t2.micro, m1.xlarge, c1.medium etc (`default = t2.micro`)
- `iam_instance_profile` - The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. (`default = ""`)
- `security_groups` - A list of security group IDs to assign to the launch configuration (`default = ""`)
- `enable_associate_public_ip_address` - Enabling associate public ip address (Associate a public ip address with an instance in a VPC) (`default = null`)
- `key_name` - Key name id (`default = ""`)
- `user_data` - The user data to provide when launching the instance (`default = ""`)
- `enable_monitoring` - If true, the launched EC2 instance will have detailed monitoring enabled (`default = ""`)
- `ebs_optimized` - If true, the launched EC2 instance will be EBS-optimized (`default = ""`)
- `root_block_device` - Customize details about the root block device of the instance. See Block Devices below for details (`default = ""`)
- `ebs_block_device` - Additional EBS block devices to attach to the instance (`default = ""`)
- `ephemeral_block_device` - Customize Ephemeral (also known as Instance Store) volumes on the instance (`default = ""`)
- `spot_price` - The price to use for reserving spot instances (`default = ""`)
- `placement_tenancy` - The tenancy of the instance. Valid values are 'default' or 'dedicated' (`default = default`)
- `availability_zones` - Availability zones for AWS ASG (`default = {'us-east-1': 'us-east-1b,us-east-1c,us-east-1d,us-east-1e', 'us-east-2': 'us-east-2a,eu-east-2b,eu-east-2c', 'us-west-1': 'us-west-1a,us-west-1c', 'us-west-2': 'us-west-2a,us-west-2b,us-west-2c', 'ca-central-1': 'ca-central-1a,ca-central-1b', 'eu-west-1': 'eu-west-1a,eu-west-1b,eu-west-1c', 'eu-west-2': 'eu-west-2a,eu-west-2b', 'eu-central-1': 'eu-central-1a,eu-central-1b,eu-central-1c', 'ap-south-1': 'ap-south-1a,ap-south-1b', 'sa-east-1': 'sa-east-1a,sa-east-1c', 'ap-northeast-1': ['ap-northeast-1a,ap-northeast-1c', 'ap-northeast-1a,ap-northeast-1c'], 'ap-southeast-1': 'ap-southeast-1a,ap-southeast-1b', 'ap-southeast-2': 'ap-southeast-2a,ap-southeast-2b,ap-southeast-2c', 'ap-northeast-2': 'ap-northeast-2a,ap-northeast-2c'}`)
- `ami` - I added only 3 regions to show the map feature but you can add all (`default = {'us-east-1': 'ami-9887c6e7', 'us-west-2': 'ami-3ecc8f46', 'eu-west-1': 'ami-6e28b517'}`)
- `enable_launch_template` - Enable ASG with launch_template (`default = ""`)
- `enable_launch_template_mixed_instances_policy` - Enable ASG with launch_template and mixed_instances_policy (`default = ""`)
- `launch_template` - (Optional) Nested argument with Launch template specification to use to launch instances. (`default = ""`)

## Module Output Variables
----------------------


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
