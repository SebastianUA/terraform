# Work with AWS ELB via terraform

A terraform module for making ELB.

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
    single_nat_gateway                  = "false"
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
    # Enable lb cookie stickiness policy 
    enable_lb_cookie_stickiness_policy_http  = true
    # Enable app cookie stickiness policy 
    enable_app_cookie_stickiness_policy_http = "true"
}
```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = "TEST-ELB"`).
- `region` - The region where to deploy this code (e.g. us-east-1) (`default = "us-east-1"`).
- `environment` - Environment for service (`default = "STAGE"`).
- `orchestration` - Type of orchestration (`default = "Terraform"`).
- `createdby` - Created by (`default = "Vitaliy Natarov"`).
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
    }`). NOT USED IN MODULE.
- `security_groups` - A list of security group IDs to assign to the ELB. Only valid if creating an ELB within a VPC.
- `subnets` - A list of subnet IDs to attach to the ELB (`default = []`).
- `instances` - Instances ID to add them to ELB (`default = []`).
- `elb_internal` - If true, ELB will be an internal ELB (`default = false`).
- `cross_zone_load_balancing` - Enable cross-zone load balancing. Default: true (`default = true`).
- `idle_timeout` - The time in seconds that the connection is allowed to be idle. Default: 60 (`default = "60"`).
- `connection_draining` - Boolean to enable connection draining. Default: false (`default = false`).
- `connection_draining_timeout` - The time in seconds to allow for connections to drain. Default: 300 (`default = 300`).
- `access_logs` - An access logs block. Uploads access logs to S3 bucket (`default = []`).
- `listener` - A list of Listener block.
- `health_check` - Health check block.
- `enable_lb_cookie_stickiness_policy_http` - Enable lb cookie stickiness policy http. If set true, will add it, else will use https (`default = "true"`).
- `enable_app_cookie_stickiness_policy_http` - Enable app cookie stickiness policy http. If set true, will add it, else will use https (`default = "true"`).
- `http_lb_port` - Set http lb port for lb_cookie_stickiness_policy_http|app_cookie_stickiness_policy_http policies (`default = "80"`).
- `https_lb_port` - Set https lb port for lb_cookie_stickiness_policy_http|app_cookie_stickiness_policy_http policies (`default = "443"`).
- `cookie_expiration_period` - Set cookie expiration period (`default = 600`).
- `cookie_name` - Set cookie name (`default = "SessionID"`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
