#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-ASG"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}    

variable "create_lc" {
    description = "Whether to create launch configuration"
    default     = true
}

variable "create_asg" {
    description = "Whether to create autoscaling group"
    default     = true
}

variable "enable_asg_azs" {
    description = "Enable ASG with AZS. If not, will use vpc_zone_identifier"
    default     = false
}

variable "load_balancer_type" {
    description = "Type of load balancer. Ex: ELB, ALB etc"
    default     = "elb"
}

# Launch configuration
variable "launch_configuration" {
    description = "The name of the launch configuration to use (if it is created outside of this module)"
    default     = ""
}

variable "ec2_instance_type" {
    description = "Type of instance t2.micro, m1.xlarge, c1.medium etc"
    default     = "t2.micro"
}

variable "iam_instance_profile" {
    description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
    default     = ""
}

variable "key_path" {
    description = "Key path to your RSA|DSA key"
    default     = "/Users/captain/.ssh/id_rsa.pub"
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the launch configuration"
  type        = "list"
}

variable "enable_associate_public_ip_address" {
    description = "Enabling associate public ip address (Associate a public ip address with an instance in a VPC)"
    default     = false
}

variable "user_data" {
    description = "The user data to provide when launching the instance"
    default     = ""
}

variable "monitoring" {
    description = "If true, the launched EC2 instance will have detailed monitoring enabled"
    default     = false
}

variable "ebs_optimized" {
    description = "If true, the launched EC2 instance will be EBS-optimized"
    default     = false
}

variable "root_block_device" {
    description = "Customize details about the root block device of the instance. See Block Devices below for details"
    default     = []
}

variable "ebs_block_device" {
    description = "Additional EBS block devices to attach to the instance"
    default     = []
}

variable "ephemeral_block_device" {
    description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
    default     = []
}

variable "spot_price" {
    description = "The price to use for reserving spot instances"
    default     = 0
}

variable "placement_tenancy" {
    description = "The tenancy of the instance. Valid values are 'default' or 'dedicated'"
    default     = "default"
}

variable "availability_zones" {
    description = "Availability zones for AWS ASG"
    type        = "map"
    default     = {
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

variable "ami" {
    description = "I added only 3 regions to show the map feature but you can add all"
    type        = "map"
    default     = {
        us-east-1 = "ami-9887c6e7"
        us-west-2 = "ami-3ecc8f46"
        eu-west-1 = "ami-6e28b517"
    }
}

variable "enable_create_before_destroy" {
    description = "Create before destroy"
    default     = true
}

# Autoscaling group
variable "asg_max_size" {
    description = "Max size of instances to making autoscaling"
    default     = "1"
}

variable "asg_size_scale" {
    description = "Size of instances to making autoscaling(up/down)"
    default     = "1"
}

variable "asg_min_size" {
    description = "Min size of instances to making autoscaling"
    default     = "1"
}

variable "adjustment_type" {
    description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity."
    default     = "ChangeInCapacity"
}

variable "asg_recurrence_scale_up" {
    description = " Cronjob time for scale-up"
    default     = "0 9 * * *"
}

variable "asg_recurrence_scale_down" {
    description = " Cronjob time for scale-down"
    default     = "0 17 * * *"
}

variable "enable_autoscaling_schedule" {
    description = "Enabling autoscaling schedule"
    default     = false
}   

variable "desired_capacity" {
    description = "Desired numbers of servers in ASG"
    default     = 1
}

variable "vpc_zone_identifier" {
    description = "A list of subnet IDs to launch resources in"
    type        = "list"
}

variable "default_cooldown" {
    description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
    default     = 300
}

variable "health_check_grace_period" {
    description = "Time (in seconds) after instance comes into service before checking health."
    default     = 300
}

variable "health_check_type" {
    description = "Controls how health checking is done. Need to choose 'EC2' or 'ELB'"
    default     = "EC2"
}

variable "force_delete" {
    description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate."
    default     = true
}

variable "load_balancers" {
    description = "A list of elastic load balancer names to add to the autoscaling group names"
    default     = []
}

variable "target_group_arns" {
    description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
    default     = []
}

variable "termination_policies" {
    description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default"
    type        = "list"
    default     = ["Default"]
}

variable "suspended_processes" {
    description = "A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly."
    default     = []
}

variable "placement_group" {
  description = "The name of the placement group into which you'll launch your instances, if any"
  default     = ""
}

variable "metrics_granularity" {
    description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
    default     = "1Minute"
}

variable "enabled_metrics" {
    description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
    type        = "list"
    
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

variable "wait_for_capacity_timeout" {
    description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
    default     = "10m"
}

variable "min_elb_capacity" {
    description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
    default     = 0
}

variable "wait_for_elb_capacity" {
    description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior."
    default     = false
}

variable "protect_from_scale_in" {
    description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events."
    default     = false
}

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
    default     = [
        "autoscaling:EC2_INSTANCE_LAUNCH",
        "autoscaling:EC2_INSTANCE_TERMINATE",
        "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
        "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
    ]
}

variable "autoscaling_notification_topic_arn" {
    description = "(Required) The Topic ARN for notifications to be sent through"
    default     = ""
}

variable "enable_autoscaling_lifecycle_hook" {
    description = "Enable autoscaling lifecycle hook"
    default     = false
}

variable "autoscaling_lifecycle_hook_default_result" {
    description = "Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON. The default value for this parameter is ABANDON."
    default     = "ABANDON"
}

variable "autoscaling_lifecycle_hook_heartbeat_timeout" {
    description = "(Optional) Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out. When the lifecycle hook times out, Auto Scaling performs the action defined in the DefaultResult parameter"
    default     = ""
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

variable "autoscaling_group_name" {
    description = "(Required) The name of the Auto Scaling group to which you want to assign the lifecycle hook"
    default     = ""
}
