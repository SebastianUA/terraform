# Work with AWS CodeDeploy via terraform

A terraform module for making CodeDeploy.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
    profile                 = "default"
}

module "codedeploy" {
    source                                              = "../../modules/codedeploy"
    name                                                = "TEST"
    region                                              = "us-east-1"
    environment                                         = "stage"

    enable_codedeploy_app                               = true
    codedeploy_app_name                                 = ""
    codedeploy_app_compute_platform                     = "Server"

    # Canary
    enable_codedeploy_deployment_config_canary          = true

    # Liner
    enable_codedeploy_deployment_config_linear          = false

    enable_deployment_group_deployment                  = true
    codedeploy_deployment_group_service_role_arn        = "arn:aws:iam::167127734783:role/admin-role"

}

```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `region` - The region where to deploy this code (e.g. us-east-1). (`default     = "us-east-1"`). 
- `environment` - Environment for service (`  default     = "STAGE"`).
- `orchestration` - Type of orchestration (`  default     = "Terraform"`).
- `createdby` - Created by (`  default     = "Vitaliy Natarov"`).
- `enable_codedeploy_app` - Enable codedeploy app usage (`default     = false`).
- `codedeploy_app_name` - The name of the application. (`default     = ""`).
- `codedeploy_app_compute_platform` - (Optional) The compute platform can either be ECS, Lambda, or Server. Default is Server. (`default     = "Server"`).
- `enable_codedeploy_deployment_config_canary` - Enable codedeploy deployment config canary usage (`default     = false`).
- `codedeploy_deployment_config_canary_deployment_config_name` - The name of the deployment config. (`default     = ""`).
- `codedeploy_deployment_config_canary_compute_platform` - (Optional) The compute platform can be Server, Lambda, or ECS. Default is Server. (`default     = "Server"`).
- `minimum_healthy_hosts_canary_type` - (Required) The type can either be FLEET_PERCENT or HOST_COUNT. (`default     = "HOST_COUNT"`).
- `minimum_healthy_hosts_canary_value` - (Required) The value when the type is FLEET_PERCENT represents the minimum number of healthy instances as a percentage of the total number of instances in the deployment. If you specify FLEET_PERCENT, at the start of the deployment, AWS CodeDeploy converts the percentage to the equivalent number of instance and rounds up fractional instances. When the type is HOST_COUNT, the value represents the minimum number of healthy instances as an absolute value. (`default     = 2`).
- `traffic_routing_config_canary_type` - (Optional) Type of traffic routing config. One of TimeBasedCanary, TimeBasedLinear, AllAtOnce. (`default     = "TimeBasedCanary"`).
- `traffic_routing_config_canary_time_based_canary_interval` - (Optional) The number of minutes between the first and second traffic shifts of a TimeBasedCanary deployment. (`default     = 10`).
- `traffic_routing_config_canary_time_based_canary_percentage` - (Optional) The percentage of traffic to shift in the first increment of a TimeBasedCanary deployment. (`default     = 10`).
- `enable_codedeploy_deployment_config_linear` - Enable codedeploy deployment config linear usage (`default     = false`).
- `codedeploy_deployment_config_linear_deployment_config_name` - The name of the deployment config. (`default     = ""`).
- `codedeploy_deployment_config_linear_compute_platform` - (Optional) The compute platform can be Server, Lambda, or ECS. (`default     = "Lambda"`).
- `minimum_healthy_hosts_linear_type` - (Required) The type can either be FLEET_PERCENT or HOST_COUNT. (`default     = "HOST_COUNT"`).
- `minimum_healthy_hosts_linear_value` - (Required) The value when the type is FLEET_PERCENT represents the minimum number of healthy instances as a percentage of the total number of instances in the deployment. If you specify FLEET_PERCENT, at the start of the deployment, AWS CodeDeploy converts the percentage to the equivalent number of instance and rounds up fractional instances. When the type is HOST_COUNT, the value represents the minimum number of healthy instances as an absolute value. (`default     = 2`).
- `traffic_routing_config_linear_type` - (Optional) Type of traffic routing config. One of TimeBasedCanary, TimeBasedLinear, AllAtOnce. (`default     = "TimeBasedLinear"`).
- `traffic_routing_config_linear_time_based_linear_interval` - (Required) The type can either be FLEET_PERCENT or HOST_COUNT. (`default     = "HOST_COUNT"`).
- `traffic_routing_config_linear_time_based_linear_percentage` - (Required) The value when the type is FLEET_PERCENT represents the minimum number of healthy instances as a percentage of the total number of instances in the deployment. If you specify FLEET_PERCENT, at the start of the deployment, AWS CodeDeploy converts the percentage to the equivalent number of instance and rounds up fractional instances. When the type is HOST_COUNT, the value represents the minimum number of healthy instances as an absolute value. (`default     = 2`).
- `enable_deployment_group_deployment` - Enable deployment group deployment usage (`default     = false`).
- `enable_deployment_group_notify_deployment` - Enable deployment group notify deployment usage (`default     = false`).
- `enable_deployment_group_ec2tag` - Enable deployment group ec2tag deployment usage (`default     = false`).
- `enable_deployment_group_ec2tag_notify` - Enable deployment group ec2tag and notify deployment usage (`default     = false`).
- `enable_deployment_group_blue_green` - Enable deployment group with Blue & Green deployment usage (`default     = false`).
- `codedeploy_deployment_group_app_name` - The name of the application. (`default     = ""`).
- `codedeploy_deployment_group_deployment_group_name` - The name of the deployment group. (`default     = ""`).
- `codedeploy_deployment_group_service_role_arn` - (Required) The service role ARN that allows deployments. (`default     = ""`).
- `codedeploy_deployment_group_deployment_config_name` - (Optional) The name of the group's deployment config. The default is 'CodeDeployDefault.OneAtATime'. (`default     = null`).
- `codedeploy_deployment_group_autoscaling_groups` - (Optional) Autoscaling groups associated with the deployment group. (`default     = null`).
- `alarm_configuration_alarms` - (Optional) A list of alarms configured for the deployment group. A maximum of 10 alarms can be added to a deployment group. (`default     = []`).
- `alarm_configuration_enabled` - (Optional) Indicates whether the alarm configuration is enabled. This option is useful when you want to temporarily deactivate alarm monitoring for a deployment group without having to add the same alarms again later. (`default     = null`).
- `alarm_configuration_ignore_poll_alarm_failure` - (Optional) Indicates whether a deployment should continue if information about the current state of alarms cannot be retrieved from CloudWatch. The default value is false. true: The deployment will proceed even if alarm status information can't be retrieved. false: The deployment will stop if alarm status information can't be retrieved. (`default     = false`).
- `auto_rollback_configuration_enabled` - (Optional) Indicates whether a defined automatic rollback configuration is currently enabled for this Deployment Group. If you enable automatic rollback, you must specify at least one event type. (`default     = null`).
- `auto_rollback_configuration_events` -  (Optional) The event type or types that trigger a rollback. Supported types are DEPLOYMENT_FAILURE and DEPLOYMENT_STOP_ON_ALARM. (`default     = null`).
- `blue_green_deployment_config_deployment_ready_option_action_on_timeout` - (Optional) When to reroute traffic from an original environment to a replacement environment in a blue/green deployment.CONTINUE_DEPLOYMENT: Register new instances with the load balancer immediately after the new application revision is installed on the instances in the replacement environment. STOP_DEPLOYMENT: Do not register new instances with load balancer unless traffic is rerouted manually. If traffic is not rerouted manually before the end of the specified wait period, the deployment status is changed to Stopped. (`default     = null`).
- `blue_green_deployment_config_deployment_ready_option_wait_time_in_minutes` - (Optional) The number of minutes to wait before the status of a blue/green deployment changed to Stopped if rerouting is not started manually. Applies only to the STOP_DEPLOYMENT option for action_on_timeout. (`default     = null`).
- `green_fleet_provisioning_option_action` - (Optional) The method used to add instances to a replacement environment. DISCOVER_EXISTING: Use instances that already exist or will be created manually. COPY_AUTO_SCALING_GROUP: Use settings from a specified Auto Scaling group to define and create instances in a new Auto Scaling group. Exactly one Auto Scaling group must be specified when selecting COPY_AUTO_SCALING_GROUP. Use autoscaling_groups to specify the Auto Scaling group. (`default     = null`).
- `terminate_blue_instances_on_deployment_success_action` -  (Optional) The action to take on instances in the original environment after a successful blue/green deployment. TERMINATE: Instances are terminated after a specified wait time. KEEP_ALIVE: Instances are left running after they are deregistered from the load balancer and removed from the deployment group. (`default     = null`).
- `terminate_blue_instances_on_deployment_success_termination_wait_time_in_minutes` - (Optional) The number of minutes to wait after a successful blue/green deployment before terminating instances from the original environment. (`default     = null`).
- `deployment_style_deployment_option` - (Optional) Indicates whether to route deployment traffic behind a load balancer. Valid Values are WITH_TRAFFIC_CONTROL or WITHOUT_TRAFFIC_CONTROL. Default is WITHOUT_TRAFFIC_CONTROL. (`default     = "WITH_TRAFFIC_CONTROL"`).
- `deployment_style_deployment_type` - (Optional) Indicates whether to run an in-place deployment or a blue/green deployment. Valid Values are IN_PLACE or BLUE_GREEN. Default is IN_PLACE. (`default     = "BLUE_GREEN"`).
- `trigger_configuration_trigger_events` - (Required) The event type or types for which notifications are triggered. Some values that are supported: DeploymentStart, DeploymentSuccess, DeploymentFailure, DeploymentStop, DeploymentRollback, InstanceStart, InstanceSuccess, InstanceFailure. See the CodeDeploy documentation for all possible values. (`default     = ""`).
- `trigger_configuration_trigger_name` - The name of the notification trigger. (`default     = ""`).
- `trigger_configuration_trigger_target_arn` - (Required) The ARN of the SNS topic through which notifications are sent. (`default     = ""`).
- `ec2_tag_filter_key` - (Optional) The key of the tag filter. (`default     = null`).
- `ec2_tag_filter_type` - (Optional) The type of the tag filter, either KEY_ONLY, VALUE_ONLY, or KEY_AND_VALUE. (`default     = null`).
- `ec2_tag_filter_value` - (Optional) The value of the tag filter. (`default     = null`).



Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
