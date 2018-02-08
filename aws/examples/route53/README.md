# Work with AWS Route53 via terraform

A terraform module for making Route53.

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
    #        instance_port      = 80
    #        instance_protocol  = "http"
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
        },
    ]
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
module "route53" {
    source                              = "../../modules/route53"
    name                                = "TEST-Route53"
    region                              = "us-east-1"
    environment                         = "PROD"
 
    create_primary_public_route53_zone          = "true"
    domain_name_for_primary_public_route53_zone = "example.local"

    route53_record_names     = ["Test-domain.local", "domain2.local"]
    #route53_record_type     = "A"
    #route53_record_ttl      = "60"
    #route53_record_records  = ["192.168.0.114"]
    
    #parent_zone_id          = "Z254KLT7VYA1UX"
    
    target_dns_name         = "${module.elb.elb_dns_name}"
    target_zone_id          = "${module.elb.elb_zone_id}"
    
    evaluate_target_health  = "true"

    #Health_checks
    #create_http_route53_health_check    = "true"
    fqdn_for_http_route53_health_check       = "linux-notes.org"
    
    #create_https_route53_health_check   = "true"
    fqdn_for_https_route53_health_check = "linux-notes.org"
}
```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = "TEST-ASG"`).
- `region` - The region where to deploy this code (e.g. us-east-1) (`default = "us-east-1"`).
- `environment` - Environment for service (`default = "STAGE"`).
- `orchestration` - Type of orchestration (`default = "Terraform"`).
- `createdby` - Created by (`default = "Vitaliy Natarov"`).
- `create_primary_public_route53_zone` - If true, then create primary public route53 zone (`default  = "false"`).
- `domain_name_for_primary_public_route53_zone` - Domain name for primary_public route53_zone (`default  = "domain.localdomain"`).
- `route53_record_name` - Route53 record name, can use ELB DNS name (`default = ""`).
- `route53_record_type` - The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT (`default = "A"`).
- `parent_zone_id` - Perent Zone ID (`default = ""`).
- `target_dns_name` - Target DNS name which needs to add to route53 (`default = ""`).
- `target_zone_id` - Target Zone ID which needs to add to route53 (`default = ""`).
- `evaluate_target_health` - Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set (`default = "false"`).
- `create_http_route53_health_check` - Create http route53 health check (`default = "false"`).
- `create_https_route53_health_check` - Create https route53 health check (`default = "false"`).
- `fqdn_for_http_route53_health_check` - FQDN for http route53 health check (`default = ""`).
- `fqdn_for_https_route53_health_check` - FQDN for https route53 health check (`default = ""`).
- `port_for_http_route53_health_check` - Port for http route53 health check (`default = "80"`).
- `port_for_https_route53_health_check` - Port for https route53 health check (`default = "443"`).
- `type_for_http_route53_health_check` - Type for http route53 health check (`default = "HTTP"`).
- `type_for_https_route53_health_check` - Type for https route53 health check (`default = "HTTPS"`).
- `resource_path_for_http_route53_health_check` - Resource path for http route53 health check (`default = "/"`).
- `resource_path_for_https_route53_health_check` - Resource path for https route53 health check (`default = "/"`).
- `failure_threshold_for_http_route53_health_check` - Failure threshold for http route53 health check (`default = "5"`).
- `failure_threshold_for_https_route53_health_check` - Failure threshold for https route53 health check (`default = "5"`).
- `request_interval_for_http_route53_health_check` - Request interval for http route53 health check (`default = "30"`).
- `request_interval_for_https_route53_health_check` - Request interval for https route53 health check (`default = "30"`).
- `measure_latency_for_http_route53_health_check` - The measure latency for http route53 health check (`default = "1"`).
- `measure_latency_for_https_route53_health_check` - The measure latency for https route53 health check (`default = "1"`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
