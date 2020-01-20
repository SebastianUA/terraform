# Work with AWS NLB via terraform

A terraform module for making NLB.

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

module "nlb" {
    source                              = "../../modules/nlb"
    region                              = "us-east-1"
   
    # NLB
    enable_nlb                          = true
    nlb_name                            = "Network-Load-Balancer"
    subnets                             = ["subnet-8851dea6", "subnet-c3a5f589", "subnet-1d7df041"]
    enable_deletion_protection          = false
    lb_internal                         = false

    # NLB target group
    enable_nlb_target_group             = true
    nlb_target_group_name               = "Network-Load-Balancer"
    vpc_id                              = "vpc-56af732c"
    backend_protocol                    = "TCP"
    backend_port                        = 80
    health_check                        = [
        {
            enabled     = true
            interval    = 10
            port        = 80
            protocol    = "HTTP"
            timeout     = 60
        },
    ]

    # NLB target group attachment
    enable_nlb_target_group_attachment  = true
    target_ids                          = []

    # NLB listeners
    enable_nlb_listener1                = true
    alb_protocols                       = "TCP"
    nlb_listener1_port                  = 80
    nlb_listener1_protocol              = "TCP"

    enable_nlb_listener2                = false
    nlb_listener2_port                  = 443
    nlb_listener2_protocol              = "TCP"
        
}
```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `region` - The region where to deploy this code (e.g. us-east-1). (`default     = "us-east-1"`). 
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default     = {}`).
- `enable_nlb` - Enable NLB usage (`default       = false`).
- `nlb_name` - description (`default       = ""`).
- `name_prefix` - Creates a unique name beginning with the specified prefix. Conflicts with nlb_name (`default     = ""`).
- `subnets` - A list of subnet IDs to attach to the NLB (`default     = []`).
- `lb_internal` - If true, NLB will be an internal NLB (`default     = false`).
- `enable_deletion_protection` - If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false. (`default     = false`).
- `enable_cross_zone_load_balancing` - (Optional) If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false. (`default       = false`).
- `load_balancer_type` - The type of load balancer to create. Possible values are application or network. The default value is application. (`default     = "network"`).
- `idle_timeout` - The time in seconds that the connection is allowed to be idle. Default: 60. (`default     = 60`).
- `ip_address_type` - The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack (`default     = "ipv4"`).
- `access_logs` - (Optional) An Access Logs block. (`default       = []`).
- `subnet_mapping` - (Optional) A subnet mapping block (`default       = []`).
- `timeouts_create` - Used for Creating LB. Default = 10mins (`default     = "10m"`).
- `timeouts_update` - Used for LB modifications. Default = 10mins (`default     = "10m"`).
- `timeouts_delete` - Used for LB destroying LB. Default = 10mins (`  default     = "10m"`).
- `enable_nlb_target_group` - Enable nlb target_group usage (`default       = false`).
- `nlb_target_group_name` - The name of the target group. If omitted, Terraform will assign a random, unique name. (`default       = ""`).
- `deregistration_delay` -  (Optional) The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds. (`default       = 300`).
- `vpc_id` - Set VPC ID for ?LB (`default       = ""`).
- `alb_protocols` - A protocol the ALB accepts. (e.g.: TCP) (`default     = "TCP"`).
- `target_type` - The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address). The default is instance. Note that you can't specify targets for a target group using both instance IDs and IP addresses. If the target type is ip, specify IP addresses from the subnets of the virtual private cloud (VPC) for the target group, the RFC 1918 range (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16), and the RFC 6598 range (100.64.0.0/10). You can't specify publicly routable IP addresses (`default     = "instance"`).
- `slow_start` - (Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds. (`default       = 0`).
- `lambda_multi_value_headers_enabled` - (Optional) Boolean whether the request and response headers exchanged between the load balancer and the Lambda function include arrays of values or strings. Only applies when target_type is lambda. (`default       = null`).
- `proxy_protocol_v2` - (Optional) Boolean to enable / disable support for proxy protocol v2 on Network Load Balancers (`default       = false`).
- `backend_port` - The port the service on the EC2 instances listen on. (`default     = 80`).
- `backend_protocol` - The protocol the backend service speaks. Options: HTTP, HTTPS, TCP, SSL (secure tcp). (`default     = "HTTP"`).
- `certificate_arn` - The ARN of the SSL Certificate. e.g. 'arn:aws:iam::XXXXXXXXXXX:server-certificate/ProdServerCert' (`default     = ""`).
- `health_check` - (Optional) A Health Check block. (`default       = []`).
- `enable_nlb_target_group_attachment` - Enable nlb target group attachment usage (`default       = false`).
- `target_ids` - The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container. If the target type is ip, specify an IP address. (`  default     = []`).
- `availability_zone` - (Optional) The Availability Zone where the IP address of the target is to be registered. (`default       = null`).
- `target_group_arn` - The ARN of the target group with which to register targets (`default       = ""`).
- `enable_nlb_listener1` - Enable NLB 1st listener (`default       = false`).
- `nlb_listener1_port` - (Required) The port on which the load balancer is listening. (`default       = 80`).
- `nlb_listener1_protocol` - (Optional) The protocol for connections from clients to the load balancer. Valid values are TCP, TLS, UDP, TCP_UDP, HTTP and HTTPS. Defaults to HTTP. (`default       = "TCP"`).
- `nlb_listener1_default_action_target_group_arn` - (Optional) The ARN of the Target Group to which to route traffic. Required if type is forward (`default     = ""`).
- `nlb_listener1_default_action_type` - (Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc. (`default     = "forward"`).
- `enable_nlb_listener2` - Enable NLB 2d listener (`default       = false`).
- `nlb_listener2_port` - (Required) The port on which the load balancer is listening. (`default       = 443`).
- `nlb_listener2_protocol` - (Optional) The protocol for connections from clients to the load balancer. Valid values are TCP, TLS, UDP, TCP_UDP, HTTP and HTTPS. Defaults to HTTP. (`default       = "TCP"`).
- `nlb_listener2_default_action_target_group_arn` - (Optional) The ARN of the Target Group to which to route traffic. Required if type is forward (`default     = ""`).
- `nlb_listener2_default_action_type` - (Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc. (`default     = "forward"`).
- `load_balancer_arn` - The ARN of the load balancer. (`default       = ""`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
