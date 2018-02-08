# Work with AWS ASG via terraform

A terraform module for making ASG.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-east-1"
    profile = "default"
    # Make it faster by skipping something
    #skip_get_ec2_platforms      = true
    #skip_metadata_api_check     = true
    #skip_region_validation      = true
    #skip_credentials_validation = true
    #skip_requesting_account_id  = true
}
module "iam" {
    source                          = "../../modules/iam"
    name                            = "TEST-AIM"
    region                          = "us-east-1"
    environment                     = "PROD"

    aws_iam_role-principals         = [
        "ec2.amazonaws.com",
    ]
    aws_iam_policy-actions           = [
        "cloudwatch:GetMetricStatistics",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents",
        "elasticache:Describe*",
        "rds:Describe*",
        "rds:ListTagsForResource",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs",
        "ec2:Owner",
    ]
}
module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "TEST-VPC"
    environment                         = "PROD"
    # VPC
    instance_tenancy                    = "default"
    enable_dns_support                  = "true"
    enable_dns_hostnames                = "true"
    assign_generated_ipv6_cidr_block    = "false"
    enable_classiclink                  = "false"
    vpc_cidr                            = "172.31.0.0/16"
    private_subnet_cidrs                = ["172.31.64.0/20"]
    public_subnet_cidrs                 = ["172.31.0.0/20"]
    availability_zones                  = ["us-east-1a", "us-east-1b"]
    enable_all_egress_ports             = "true"
    allowed_ports                       = ["9300", "3272", "8888", "8444"]

    map_public_ip_on_launch             = "true"

    #Internet-GateWay
    enable_internet_gateway             = "true"
    #NAT
    enable_nat_gateway                  = "false"
    single_nat_gateway                  = "true"
    #VPN
    enable_vpn_gateway                  = "false"
    #DHCP
    enable_dhcp_options                 = "false"
    # EIP
    enable_eip                          = "false"
}
module "elb" {
    source                              = "../../modules/elb"
    name                                = "TEST-ELB"
    region                              = "us-east-1"
    environment                         = "PROD"

    security_groups                     = ["${module.vpc.security_group_id}"]
    
    # Need to choose subnets or availability_zones. The subnets has been chosen.
    subnets                             = ["${element(module.vpc.vpc-publicsubnet-ids, 0)}"]
    
    #access_logs = [
    #    {
    #        bucket = "my-access-logs-bucket"
    #        bucket_prefix = "bar"
    #        interval = 60
    #    },
    #]
    listener = [
        {
            instance_port     = "80"
            instance_protocol = "HTTP"
            lb_port           = "80"
            lb_protocol       = "HTTP"
        },
    #    {
    #        instance_port      = 443
    #        instance_protocol  = "https"
    #        lb_port            = 443
    #        lb_protocol        = "https"
    #        ssl_certificate_id = "${var.elb_certificate}"
    #    },
    ]
    health_check = [
        {
            target              = "HTTP:80/"
            interval            = 30
            healthy_threshold   = 2
            unhealthy_threshold = 2
            timeout             = 5
        }
    ]
    # You could use ONE health_check!
    #health_check = [
    #    {
    #        target              = "HTTP:443/"
    #        interval            = 30
    #        healthy_threshold   = 2
    #        unhealthy_threshold = 2
    #        timeout             = 5
    #    }
    #]
    # Enable 
    enable_lb_cookie_stickiness_policy_http  = true
    # Enable 
    enable_app_cookie_stickiness_policy_http = "true"
}
module "asg" {
    source                              = "../../modules/asg"
    name                                = "TEST-ASG"
    region                              = "us-east-1"
    environment                         = "PROD"

    security_groups = ["${module.vpc.security_group_id}"]
    
    root_block_device  = [
        {
            volume_size = "8"
            volume_type = "gp2"
        },
    ]
    
    # Auto scaling group
    #asg_name                  = "example-asg"
    vpc_zone_identifier       = ["${module.vpc.vpc-publicsubnet-ids}"]
    health_check_type         = "EC2"
    asg_min_size              = 0
    asg_max_size              = 1
    desired_capacity          = 1
    wait_for_capacity_timeout = 0

    load_balancers            = ["${module.elb.elb_name}"]

    #
    enable_autoscaling_schedule = true
}
```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = "TEST-ASG"`).
- `region` - The region where to deploy this code (e.g. us-east-1) (`default = "us-east-1"`).
- `environment` - Environment for service (`default = "STAGE"`).
- `orchestration` - Type of orchestration (`default = "Terraform"`).
- `createdby` - Created by (`default = "Vitaliy Natarov"`).
- `create_lc` - Whether to create launch configuration (`default = true`).
- `create_asg` - Whether to create autoscaling group (`default = true`).
//Launch configuration
- `launch_configuration` - The name of the launch configuration to use (if it is created outside of this module) (`default = ""`).
- `ec2_instance_type` - Type of instance t2.micro, m1.xlarge, c1.medium etc (`default = "t2.micro"`).
- `iam_instance_profile` - The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile (`default = ""`).
- `key_path` - The key name path to use for the instance (default = "/Users/captain/.ssh/id_rsa.pub").
- `security_groups` - A list of security group IDs to assign to the launch configuration.
- `enable_associate_public_ip_address` - Enabling associate public ip address (Associate a public ip address with an instance in a VPC) (`default = false`).
- `user_data` - The user data to provide when launching the instance (`default = ""`).
- `monitoring` - If true, the launched EC2 instance will have detailed monitoring enabled (`default = false`).
- `ebs_optimized` - If true, the launched EC2 instance will be EBS-optimized (`default = false`).
- `root_block_device` - Customize details about the root block device of the instance. See Block Devices below for details (`default = []`).
- `ebs_block_device` - Additional EBS block devices to attach to the instance (`default = []`).
- `ephemeral_block_device` - Customize Ephemeral (also known as Instance Store) volumes on the instanc (`default = []`).
- `spot_price` - The price to use for reserving spot instances (`default = 0`).
- `placement_tenancy` - The tenancy of the instance. Valid values are 'default' or 'dedicated' (`default = "default"`).
- `availability_zones` - Availability zones for AWS ASG (`default     = {
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
    }`). NOT USED IN MODULE.... Have got issue with terraform :( 
- `ami` - I added only 3 regions to show the map feature but you can add all (`default     = {
        us-east-1 = "ami-46c1b650"
        us-west-2 = "ami-46c1b632"
        eu-west-1 = "ami-6e28b517"
    }`).
- `enable_create_before_destroy` - Create before destroy (`default = "true"`). NOT USING YET..... Have some problems with terraform.
//Autoscaling group
- `asg_max_size` - Max size of instances to making autoscalin (`default = "1`).
- `asg_size_scale` - Size of instances to making autoscaling(up/down) (`default = "1`).
- `asg_min_size` - Min size of instances to making autoscalin (`default = "1`).
- `adjustment_type` - Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity (`default  = "ChangeInCapacity"`).
- `asg_recurrence_scale_up` - Cronjob time for scale-up (`default = "0 9 * * *"`).
- `asg_recurrence_scale_down` - Cronjob time for scale-down (`default = "0 17 * * *"`).
- `enable_autoscaling_schedule` - Enabling autoscaling schedule (`default = false`).
- `desired_capacity` - Desired numbers of servers in ASG (`default = 1`).
- `vpc_zone_identifier` - A list of subnet IDs to launch resources in.
- `default_cooldown` - The amount of time, in seconds, after a scaling activity completes before another scaling activity can star (`default = 300`).
- `health_check_grace_period` - Time (in seconds) after instance comes into service before checking health (`default = 300`).
- `health_check_type` - Controls how health checking is done. Need to choose 'EC2' or 'ELB' (`default = "EC2"`).
- `force_delete` - Allows deleting the autoscaling group without waiting for all instances in the pool to terminate (`default = "true"`).
- `load_balancers` - A list of elastic load balancer names to add to the autoscaling group names (`default = []`).
- `target_group_arns` - A list of aws_alb_target_group ARNs, for use with Application Load Balancing (`default  = []`).
- `termination_policies` - A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default" (`default = ["Default"]`).
- `suspended_processes` - A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly (`default = []`).
- `placement_group` - The name of the placement group into which you'll launch your instances, if any (`default = ""`).
- `metrics_granularity` - The granularity to associate with the metrics to collect. The only valid value is 1Minute (`default  = "1Minute"`).
- `enabled_metrics` - A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances (`default = [
        "GroupMinSize",
        "GroupMaxSize",
        "GroupDesiredCapacity",
        "GroupInServiceInstances",
        "GroupPendingInstances",
        "GroupStandbyInstances",
        "GroupTerminatingInstances",
        "GroupTotalInstances",
    ]`).
- `wait_for_capacity_timeout` - A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior (`default = "10m"`).
- `min_elb_capacity` - Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes (`default = 0`).
- `wait_for_elb_capacity` - Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior (`default = false`).
- `protect_from_scale_in` - Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events (`default = false`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
