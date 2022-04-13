#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "ami" {
  description = "I added only 3 regions to show the map feature but you can add all"
  default = {
    us-east-1 = "ami-9887c6e7"
    us-west-2 = "ami-3ecc8f46"
    eu-west-1 = "ami-6e28b517"
  }

  // validation {
  //   condition     = length(var.ami[.var.region]) > 4 && substr(var.ami[.var.region], 0, 4) == "ami-"
  //   error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  // }
}

#-----------------------------------------------------------
# Launch AWS configuration
#-----------------------------------------------------------
variable "enable_lc" {
  description = "Whether to create launch configuration"
  default     = false
}

variable "lc_name" {
  description = "Custome name for lc"
  default     = ""
}

variable "lc_name_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name."
  default     = null
}

variable "lc_image_id" {
  description = "The EC2 image ID to launch."
  default     = ""

  // validation {
  //   condition     = length(var.lc_image_id) > 4 && substr(var.lc_image_id, 0, 4) == "ami-"
  //   error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  // }
}

variable "lc_instance_type" {
  description = "(Required) The size of instance to launch(t2.micro, m1.xlarge, c1.medium etc)."
  default     = "t2.micro"
}

variable "lc_security_groups" {
  description = "A list of security group IDs to assign to the launch configuration"
  default     = []
}

variable "lc_iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  default     = ""
}

variable "lc_key_name" {
  description = "(Optional) The key name that should be used for the instance."
  default     = null
}

variable "lc_user_data" {
  description = "(Optional) The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  default     = null
}

variable "lc_associate_public_ip_address" {
  description = "Enabling associate public ip address (Associate a public ip address with an instance in a VPC)"
  default     = null
}

variable "lc_enable_monitoring" {
  description = "(Optional) Enables/disables detailed monitoring. This is enabled by default. If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = true
}

variable "lc_placement_tenancy" {
  description = "The tenancy of the instance. Valid values are 'default' or 'dedicated'"
  default     = "default"
}

variable "lc_spot_price" {
  description = "(Optional; Default: On-demand price) The maximum price to use for reserving spot instances."
  default     = null
}

variable "lc_ebs_optimized" {
  description = "(Optional) If true, the launched EC2 instance will be EBS-optimized."
  default     = null
}

variable "lc_ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  default     = []
}

variable "lc_root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default     = {}
}

variable "lc_ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  default     = []
}

#-----------------------------------------------------------
# AWS ASG with launch_template
#-----------------------------------------------------------
variable "enable_lt" {
  description = "Enable ASG with launch_template"
  default     = false
}

variable "lt_name" {
  description = "The name of the launch template. If you leave this blank, Terraform will auto-generate a unique name."
  default     = ""
}

variable "lt_name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  default     = null
}

variable "lt_description" {
  description = "Description of the launch template."
  default     = null
}

variable "lt_default_version" {
  description = "Default Version of the launch template."
  default     = null
}

variable "lt_update_default_version" {
  description = "Whether to update Default Version each update. Conflicts with default_version."
  default     = null
}

variable "lt_image_id" {
  description = "The AMI from which to launch the instance."
  default     = ""

  // validation {
  //   condition     = length(var.lt_image_id) > 4 && substr(var.lt_image_id, 0, 4) == "ami-"
  //   error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  // }
}

variable "lt_kernel_id" {
  description = "The kernel ID."
  default     = null
}

variable "lt_ram_disk_id" {
  description = "The ID of the RAM disk."
  default     = null
}

variable "lt_instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance. Can be stop or terminate. (Default: stop)."
  default     = "stop"
}

variable "lt_instance_type" {
  description = "The type of the instance."
  default     = "t2.micro"
}

variable "lt_disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = null
}

variable "lt_ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized."
  default     = null
}

variable "lt_security_group_names" {
  description = "A list of security group names to associate with. If you are creating Instances in a VPC, use vpc_security_group_ids instead."
  default     = null
}

variable "lt_vpc_security_group_ids" {
  description = "A list of security group IDs to associate with."
  default     = null
}

variable "lt_key_name" {
  description = "The key name to use for the instance."
  default     = null
}

variable "lt_user_data" {
  description = "The Base64-encoded user data to provide when launching the instance."
  default     = null
}

variable "lt_block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI."
  default     = []
}

variable "lt_capacity_reservation_specification" {
  description = "Targeting for EC2 capacity reservations."
  default     = []
}

variable "lt_cpu_options" {
  description = "The CPU options for the instance. See CPU Options below for more details."
  default     = []
}

variable "lt_credit_specification" {
  description = "Customize the credit specification of the instance. See Credit Specification below for more details."
  default     = []
}

variable "lt_elastic_gpu_specifications" {
  description = "The elastic GPU to attach to the instance. See Elastic GPU below for more details."
  default     = []
}

variable "lt_elastic_inference_accelerator" {
  description = "(Optional) Configuration block containing an Elastic Inference Accelerator to attach to the instance. See Elastic Inference Accelerator below for more details."
  default     = []
}

variable "lt_iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. See Instance Profile below for more details."
  default     = []
}

variable "lt_instance_market_options" {
  description = "The market (purchasing) option for the instance. See Market Options below for details."
  default     = []
}

variable "lt_license_specification" {
  description = "A list of license specifications to associate with. See License Specification below for more details."
  default     = []
}

variable "lt_metadata_options" {
  description = "(Optional) Customize the metadata options for the instance. See Metadata Options below for more details."
  default     = []
}

variable "lt_monitoring" {
  description = "The monitoring option for the instance. See Monitoring below for more details."
  default     = []
}

variable "lt_network_interfaces" {
  description = "Customize network interfaces to be attached at instance boot time. See Network Interfaces below for more details."
  default     = []
}

variable "lt_placement" {
  description = "The placement of the instance. See Placement below for more details."
  default     = []
}

variable "lt_hibernation_options" {
  description = "The hibernation options for the instance. See Hibernation Options below for more details."
  default     = []
}

variable "lt_tag_specifications" {
  description = "The tags to apply to the resources during launch. See Tag Specifications below for more details."
  default     = []
}

variable "lt_tags" {
  description = "(Optional) A map of tags to assign to the launch template."
  default     = {}
}

#-----------------------------------------------------------
# AWS ASG
#-----------------------------------------------------------
variable "enable_asg" {
  description = "Whether to create autoscaling group"
  default     = false
}

variable "asg_name" {
  description = "Whether to create autoscaling group"
  default     = ""
}

variable "asg_name_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name. If empty, will use name"
  default     = null
}

variable "asg_availability_zones" {
  description = "Availability zones for AWS ASG"
  default = {
    us-east-1      = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
    us-east-2      = "us-east-2a,eu-east-2b,eu-east-2c"
    us-west-1      = "us-west-1a,us-west-1c"
    us-west-2      = "us-west-2a,us-west-2b,us-west-2c"
    ca-central-1   = "ca-central-1a,ca-central-1b"
    eu-west-1      = "eu-west-1a,eu-west-1b,eu-west-1c"
    eu-west-2      = "eu-west-2a,eu-west-2b"
    eu-central-1   = "eu-central-1a,eu-central-1b,eu-central-1c"
    ap-south-1     = "ap-south-1a,ap-south-1b"
    sa-east-1      = "sa-east-1a,sa-east-1c"
    ap-northeast-1 = "ap-northeast-1a,ap-northeast-1c"
    ap-southeast-1 = "ap-southeast-1a,ap-southeast-1b"
    ap-southeast-2 = "ap-southeast-2a,ap-southeast-2b,ap-southeast-2c"
    ap-northeast-1 = "ap-northeast-1a,ap-northeast-1c"
    ap-northeast-2 = "ap-northeast-2a,ap-northeast-2c"
  }
}

variable "asg_launch_configuration" {
  description = "The name of the launch configuration to use (if it is created outside of this module)"
  default     = ""
}

variable "asg_launch_template" {
  description = "(Optional) Nested argument with Launch template specification to use to launch instances."
  default     = []
}

variable "asg_vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in"
  default     = []
}

variable "asg_max_size" {
  description = "Max size of instances to making autoscaling"
  default     = 1
}

variable "asg_min_size" {
  description = "Min size of instances to making autoscaling"
  default     = 1
}

variable "asg_desired_capacity" {
  description = "Desired numbers of servers in ASG"
  default     = 1
}

variable "asg_health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health."
  default     = 300
}

variable "asg_health_check_type" {
  description = "Controls how health checking is done. Need to choose 'EC2' or 'ELB'"
  default     = "EC2"
}

variable "asg_min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  default     = null
}

variable "asg_wait_for_elb_capacity" {
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior."
  default     = null
}

variable "asg_target_group_arns" {
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  default     = null
}

variable "asg_load_balancers" {
  description = "(Optional) A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use target_group_arns instead."
  default     = null
}

variable "asg_default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "asg_force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate."
  default     = true
}

variable "asg_termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default"
  default     = ["Default"]
}

variable "asg_suspended_processes" {
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly."
  default     = []
}

variable "asg_placement_group" {
  description = "The name of the placement group into which you'll launch your instances, if any"
  default     = ""
}

variable "asg_metrics_granularity" {
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
  default     = "1Minute"
}

variable "asg_enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "asg_wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  default     = "10m"
}

variable "asg_protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events."
  default     = false
}

variable "asg_timeouts" {
  description = "Set timeouts for ASG"
  default     = {}
}

variable "asg_mixed_instances_policy" {
  description = "(Optional) Configuration block containing settings to define launch targets for Auto Scaling groups."
  default     = []
}

variable "asg_initial_lifecycle_hook" {
  description = "(Optional) One or more Lifecycle Hooks to attach to the autoscaling group before instances are launched. The syntax is exactly the same as the separate aws_autoscaling_lifecycle_hook resource, without the autoscaling_group_name attribute. Please note that this will only work when creating a new autoscaling group. For all other use-cases, please use aws_autoscaling_lifecycle_hook resource."
  default     = []
}

variable "asg_max_instance_lifetime" {
  description = "(Optional) The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds."
  default     = null
}

variable "asg_tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
  type        = list(map(string))
  default     = []
}

variable "asg_warm_pool" {
  description = "(Optional) If this block is configured, add a Warm Pool to the specified Auto Scaling group."
  default     = []
}

variable "asg_capacity_rebalance" {
  description = "(Optional) Indicates whether capacity rebalance is enabled. Otherwise, capacity rebalance is disabled."
  default     = null
}

variable "asg_service_linked_role_arn" {
  description = "(Optional) The ARN of the service-linked role that the ASG will use to call other AWS services"
  default     = null
}

variable "aws_instance_refresh" {
  description = "(Optional) If this block is configured, start an Instance Refresh when this Auto Scaling Group is updated."
  default     = []
}

#---------------------------------------------------
# AWS ASG tag
#---------------------------------------------------
variable "enable_asg_tag" {
  description = "Enable asg tags"
  default     = false
}

variable "asg_tag_autoscaling_group_name" {
  description = "Set list of asg names for asg tag resource"
  default     = []
}

variable "asg_tag_tags" {
  description = "Set list of tags for asg tag resource"
  default     = []
}

#-----------------------------------------------------------
# AWS autoscaling_attachment
#-----------------------------------------------------------
variable "enable_autoscaling_attachment" {
  description = "Enable asg attachment"
  default     = false
}

variable "load_balancer_type" {
  description = "Type of load balancer. Ex: ELB, ALB etc"
  default     = "ELB"
}

variable "load_balancers" {
  description = "An elastic load balancer name/ALB to add to the autoscaling group names"
  default     = []
}

variable "autoscaling_group_name" {
  description = "(Required) Name of ASG to associate with the ELB or ALB. Also, The name of the Auto Scaling group to which you want to assign the lifecycle hoo"
  default     = ""
}

variable "lb_target_group_arn" {
  description = "(Optional) The ARN of an ALB Target Group."
  default     = null
}

#-----------------------------------------------------------
# AWS autoscaling lifecycle hook
#-----------------------------------------------------------
variable "enable_autoscaling_lifecycle_hook" {
  description = "Enable autoscaling lifecycle hook"
  default     = false
}

variable "autoscaling_lifecycle_hook_name" {
  description = "(Required) The name of the lifecycle hook."
  default     = ""
}

variable "autoscaling_lifecycle_hook_default_result" {
  description = "Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON. The default value for this parameter is ABANDON."
  default     = "ABANDON"
}

variable "autoscaling_lifecycle_hook_heartbeat_timeout" {
  description = "(Optional) Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out. When the lifecycle hook times out, Auto Scaling performs the action defined in the DefaultResult parameter"
  default     = 10
}

variable "autoscaling_lifecycle_hook_lifecycle_transition" {
  description = "(Required) The instance state to which you want to attach the lifecycle hook."
  default     = "autoscaling:EC2_INSTANCE_LAUNCHING"
}

variable "autoscaling_lifecycle_hook_notification_metadata" {
  description = "(Optional) Contains additional information that you want to include any time Auto Scaling sends a message to the notification target."
  default     = ""
}

variable "autoscaling_lifecycle_hook_notification_target_arn" {
  description = "(Optional) The ARN of the notification target that Auto Scaling will use to notify you when an instance is in the transition state for the lifecycle hook. This ARN target can be either an SQS queue or an SNS topic."
  default     = ""
}

variable "autoscaling_lifecycle_hook_role_arn" {
  description = "(Optional) The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target."
  default     = ""
}

#-----------------------------------------------------------
# AWS autoscaling_notification
#-----------------------------------------------------------
variable "enable_autoscaling_notification" {
  description = "Enable autoscaling notification"
  default     = false
}

variable "autoscaling_groups_filter" {
  description = "A filter used to scope the list e.g. by tags"
  default     = []
}

variable "autoscaling_notification_notifications" {
  description = "(Required) A list of Notification Types that trigger notifications."
  default = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
}

variable "autoscaling_notification_topic_arns" {
  description = "(Required) The Topic ARNs for notifications to be sent through"
  default     = []
}

#-----------------------------------------------------------
# autoscaling policy rules
#-----------------------------------------------------------
variable "enable_autoscaling_policy" {
  description = "Enabling autoscaling schedule"
  default     = false
}

variable "autoscaling_policy_stack" {
  description = "Set autoscaling policy as stack"
  default     = []
}

#-----------------------------------------------------------
# ASW ASG Scale-up/Scale-down
#-----------------------------------------------------------
variable "enable_autoscaling_schedule" {
  description = "Enabling autoscaling schedule"
  default     = false
}

variable "autoscaling_schedule_stack" {
  description = "Set autoscaling schedule as stack"
  default     = []
}
