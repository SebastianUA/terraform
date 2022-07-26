# Work with ALB via terraform

A terraform module for making ALB.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
  profile                 = "default"

}

module "alb" {
  source      = "../../modules/alb"
  name        = "App-Load-Balancer"
  environment = "staging"

  # Create a new ALB
  enable_alb                     = true
  alb_load_balancer_type         = "application"
  alb_name                       = "MyfirstLB"
  alb_security_groups            = ["sg-0cfb43249902af8f2"]
  alb_subnets                    = ["subnet-087ab3540e1a1ace4", "subnet-03212d250885f6986", "subnet-02b0ff71a1d00deb2"]
  alb_internal                   = false
  alb_enable_deletion_protection = false

  # Create ALB target group
  enable_alb_target_group   = true
  alb_target_group_name     = "myFirstLB"
  alb_target_group_protocol = "HTTP"
  alb_target_group_vpc_id   = "vpc-0ea8873ab2bf7900d"

  alb_target_group_health_check = [
    {
      enabled             = true
      port                = 80
      protocol            = "HTTP"
      interval            = 10
      path                = "/"
      healthy_threshold   = 3
      unhealthy_threshold = 3
      timeout             = 5
      matcher             = "200-299"
    }
  ]

  alb_target_group_stickiness = [
    {
      enabled         = true
      type            = "lb_cookie"
      cookie_duration = 300
    }
  ]

  # Create ALB target group attachment
  enable_alb_target_group_attachment     = false
  alb_target_group_attachment_port       = 80
  alb_target_group_attachment_target_ids = ["id-43243cxfd4", "id-32rxcer34"]

  # Create ALB listener
  enable_alb_listener              = true
  alb_listener_port                = 80
  alb_listener_protocol            = "HTTP"
  alb_listener_default_action_type = "fixed-response"
  alb_listener_default_action_fixed_response = [
    {
      content_type = "text/plain"
      message_body = null
      status_code  = "200"
    }
  ]

  # listener rule rule
  enable_alb_listener_rule      = true
  alb_listener_rule_action_type = "fixed-response"
  alb_listener_rule_action_fixed_response = [
    {
      content_type = "text/plain"
      message_body = null
      status_code  = "200"
    }
  ]
  alb_listener_rule_condition_http_header = [
    {
      http_header_name = "X-Forwarded-For"
      values           = ["0.0.0.0/0"]
    }
  ]

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}


module "alb_name_prefix" {
  source      = "../../modules/alb"
  name        = "App-Load-Balancer"
  environment = "staging"

  # Create a new ALB
  enable_alb                     = false
  alb_load_balancer_type         = "application"
  alb_name_prefix                = "alb-"
  alb_security_groups            = ["sg-0cfb43249902af8f2"]
  alb_subnets                    = ["subnet-087ab3540e1a1ace4", "subnet-03212d250885f6986", "subnet-02b0ff71a1d00deb2"]
  alb_internal                   = false
  alb_enable_deletion_protection = false


  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)
- `enable_alb` - Enable ALB usage (`default = False`)
- `alb_name` - Set ALB name (`default = ""`)
- `alb_name_prefix` - Creates a unique name beginning with the specified prefix. Conflicts with name (`default = ""`)
- `alb_security_groups` - A list of security group IDs to assign to the ALB. Only valid if creating an ALB within a VPC (`default = []`)
- `alb_subnets` - A list of subnet IDs to attach to the ALB (`default = []`)
- `alb_internal` - If true, ALB will be an internal ALB (`default = False`)
- `alb_enable_cross_zone_load_balancing` - (Optional) If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false. (`default = False`)
- `alb_enable_deletion_protection` - If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false. (`default = False`)
- `alb_load_balancer_type` - The type of load balancer to create. Possible values are application or network. The default value is application. (`default = application`)
- `alb_idle_timeout` - The time in seconds that the connection is allowed to be idle. Default: 60. (`default = 60`)
- `alb_enable_http2` - (Optional) Indicates whether HTTP/2 is enabled in application load balancers. Defaults to true. (`default = True`)
- `alb_ip_address_type` - The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack (`default = ipv4`)
- `alb_access_logs` - (Optional) An Access Logs block. (`default = []`)
- `alb_timeouts` - Set timeouts for ALB (`default = {}`)
- `alb_subnet_mapping` - (Optional) A subnet mapping block (`default = []`)
- `alb_drop_invalid_header_fields` - (Optional) Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). The default is false. Elastic Load Balancing requires that message header names contain only alphanumeric characters and hyphens. Only valid for Load Balancers of type application. (`default = null`)
- `alb_customer_owned_ipv4_pool` - (Optional) The ID of the customer owned ipv4 pool to use for this load balancer. (`default = null`)
- `enable_alb_target_group` - Enable alb target group (`default = False`)
- `alb_target_group_name` - Names for alb target group (`default = ""`)
- `alb_target_group_name_prefix` - Set name_prefix for ALB (`default = null`)
- `alb_target_group_port` - The port the service on the EC2 instances listen on. (`default = 80`)
- `alb_target_group_protocol` - The protocol the backend service speaks. Options: HTTP HTTPS TCP TLS UDP TCP_UDP (secure tcp). (`default = HTTP`)
- `alb_target_group_vpc_id` - Set VPC ID for ?LB (`default = ""`)
- `alb_target_group_target_type` - The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address) or lambda. The default is instance. Note that you can't specify targets for a target group using both instance IDs and IP addresses. If the target type is ip, specify IP addresses from the subnets of the virtual private cloud (VPC) for the target group, the RFC 1918 range (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16), and the RFC 6598 range (100.64.0.0/10). You can't specify publicly routable IP addresses (`default = instance`)
- `alb_target_group_deregistration_delay` - The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds. (`default = 300`)
- `alb_target_group_slow_start` - (Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds. (`default = 0`)
- `alb_target_group_stickiness` - (Optional, Maximum of 1) A Stickiness block. (`default = []`)
- `alb_target_group_health_check` - (Optional, Maximum of 1) A Health Check block. (`default = []`)
- `enable_alb_target_group_attachment` - Enable to use alb_target_group_attachment (`default = False`)
- `alb_target_group_attachment_target_group_arn` - The ARN of the target group with which to register targets (`default = ""`)
- `alb_target_group_attachment_target_ids` - The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container. If the target type is ip, specify an IP address. (`default = []`)
- `alb_target_group_attachment_port` - (Optional) The port on which targets receive traffic. (`default = null`)
- `alb_target_group_attachment_availability_zone` - (Optional) The Availability Zone where the IP address of the target is to be registered. If the private ip address is outside of the VPC scope, this value must be set to 'all'. (`default = null`)
- `enable_alb_listener` - Enable alb_listener usage (`default = False`)
- `alb_listener_load_balancer_arn` - (Required, Forces New Resource) The ARN of the load balancer (`default = ""`)
- `alb_listener_port` - (Optional) The port on which the load balancer is listening. Not valid for Gateway Load Balancers. (`default = null`)
- `alb_listener_protocol` - (Optional) The protocol for connections from clients to the load balancer. For Application Load Balancers, valid values are HTTP and HTTPS, with a default of HTTP. For Network Load Balancers, valid values are TCP, TLS, UDP, and TCP_UDP. Not valid to use UDP or TCP_UDP if dual-stack mode is enabled. Not valid for Gateway Load Balancers. (`default = null`)
- `alb_listener_ssl_policy` - (Optional) The name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS. (`default = null`)
- `alb_listener_certificate_arn` - (Optional) The ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS. For adding additional SSL certificates, see the aws_lb_listener_certificate resource. (`default = null`)
- `alb_listener_default_action_fixed_response` - Fixed-response Blocks (`default = []`)
- `alb_listener_default_action_redirect` - (Optional) Information for creating a redirect action. Required if type is redirect. (`default = []`)
- `alb_listener_default_action_forward` - (Optional) Information for creating a forward action. Required if type is forward. (`default = []`)
- `alb_listener_default_action_authenticate_cognito` - Authenticate Cognito Blocks (`default = []`)
- `alb_listener_default_action_authenticate_oidc` - Authenticate OIDC Blocks (`default = []`)
- `alb_listener_default_action_target_group_arn` - (Optional) The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead. (`default = null`)
- `alb_listener_default_action_type` - (Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc (`default = null`)
- `enable_alb_listener_rule` - Enable alb listener rule (`default = False`)
- `alb_listener_rule_listener_arn` - (Required, Forces New Resource) The ARN of the listener to which to attach the rule. (`default = ""`)
- `alb_listener_rule_priority` - (Optional) The priority for the rule between 1 and 50000. Leaving it unset will automatically set the rule with next available priority after currently existing highest rule. A listener can't have multiple rules with the same priority. (`default = null`)
- `alb_listener_rule_action_type` - (Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc (`default = null`)
- `alb_listener_rule_action_target_group_arn` - (Optional) The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead. (`default = null`)
- `alb_listener_rule_action_fixed_response` - (Optional) Information for creating an action that returns a custom HTTP response. Required if type is fixed-response (`default = []`)
- `alb_listener_rule_action_forward` - (Optional) Information for creating an action that distributes requests among one or more target groups. Specify only if type is forward. If you specify both forward block and target_group_arn attribute, you can specify only one target group using forward and it must be the same target group specified in target_group_arn. (`default = []`)
- `alb_listener_rule_action_redirect` - (Optional) Information for creating a redirect action. Required if type is redirect. (`default = []`)
- `alb_listener_rule_action_authenticate_cognito` - (Optional) Information for creating an authenticate action using Cognito. Required if type is authenticate-cognito (`default = []`)
- `alb_listener_rule_action_authenticate_oidc` - (Optional) Information for creating an authenticate action using OIDC. Required if type is authenticate-oidc (`default = []`)
- `alb_listener_rule_condition_host_header` - (Optional) Contains a single values item which is a list of host header patterns to match. The maximum size of each pattern is 128 characters. Comparison is case insensitive. Wildcard characters supported: * (matches 0 or more characters) and ? (matches exactly 1 character). Only one pattern needs to match for the condition to be satisfied. (`default = []`)
- `alb_listener_rule_condition_http_request_method` - (Optional) Contains a single values item which is a list of HTTP request methods or verbs to match. Maximum size is 40 characters. Only allowed characters are A-Z, hyphen (-) and underscore (_). Comparison is case sensitive. Wildcards are not supported. Only one needs to match for the condition to be satisfied. AWS recommends that GET and HEAD requests are routed in the same way because the response to a HEAD request may be cached. (`default = []`)
- `alb_listener_rule_condition_path_pattern` - (Optional) Contains a single values item which is a list of path patterns to match against the request URL. Maximum size of each pattern is 128 characters. Comparison is case sensitive. Wildcard characters supported: * (matches 0 or more characters) and ? (matches exactly 1 character). Only one pattern needs to match for the condition to be satisfied. Path pattern is compared only to the path of the URL, not to its query string. To compare against the query string, use a query_string condition. (`default = []`)
- `alb_listener_rule_condition_source_ip` - (Optional) Contains a single values item which is a list of source IP CIDR notations to match. You can use both IPv4 and IPv6 addresses. Wildcards are not supported. Condition is satisfied if the source IP address of the request matches one of the CIDR blocks. Condition is not satisfied by the addresses in the X-Forwarded-For header, use http_header condition instead. (`default = []`)
- `alb_listener_rule_condition_http_header` - (Optional) HTTP headers to match. (`default = []`)
- `alb_listener_rule_condition_query_string` - (Optional) Query strings to match. (`default = []`)
- `enable_alb_listener_certificate` - Enable alb listener certificate (`default = False`)
- `alb_listener_certificate_listener_arn` - (Required, Forces New Resource) The ARN of the listener to which to attach the certificate. (`default = ""`)
- `alb_listener_certificate_certificate_arn` - (Required, Forces New Resource) The ARN of the certificate to attach to the listener. (`default = null`)

## Module Output Variables
----------------------
- `lb_name` - LB name
- `lb_arn` - ARN of the lb itself. Useful for debug output, for example when attaching a WAF.
- `lb_arn_suffix` - ARN suffix of our lb - can be used with CloudWatch
- `lb_dns_name` - The DNS name of the lb presumably to be used with a friendlier CNAME.
- `lb_id` - The ID of the lb we created.
- `lb_zone_id` - The zone_id of the lb to assist with creating DNS records.
- `lb_tg_id` - The ARN of the Target Group (matches arn)
- `lb_tg_arn` - The ARN of the Target Group (matches id)
- `lb_tg_arn_suffix` - The ARN suffix for use with CloudWatch Metrics.
- `lb_tg_name` - The name of the Target Group
- `lb_tg_attachment_id` - A unique identifier for the attachment
- `alb_listener_arn` - The ARN of the HTTPS lb Listener we created.
- `alb_listener_id` - The ID of the lb Listener we created.
- `alb_listener_rule_arn` - The ARN of the rule (matches id)
- `alb_listener_rule_id` - The ARN of the rule (matches arn)


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
