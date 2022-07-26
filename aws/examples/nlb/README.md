# Work with NLB via terraform

A terraform module for making NLB.


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
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

module "nlb" {
  source = "../../modules/nlb"

  # NLB
  enable_nlb                     = true
  nlb_name                       = "Network-Load-Balancer"
  nlb_subnets                    = ["subnet-8851dea6", "subnet-c3a5f589", "subnet-1d7df041"]
  nlb_enable_deletion_protection = false
  nlb_internal                   = false

  # NLB target group
  enable_nlb_target_group   = true
  nlb_target_group_name     = "Network-Load-Balancer"
  nlb_target_group_vpc_id   = "vpc-56af732c"
  nlb_target_group_protocol = "TCP"
  nlb_target_group_port     = 80
  nlb_target_group_health_check = [
    {
      enabled  = true
      interval = 10
      port     = 80
      protocol = "HTTP"
      timeout  = 60
    },
  ]

  # NLB target group attachment
  enable_nlb_target_group_attachment     = true
  nlb_target_group_attachment_target_ids = []

  # NLB listener
  enable_nlb_listener   = true
  nlb_listener_protocol = "TCP"
  nlb_listener_rule_action_redirect = [
    {
      protocol = "TCP"
      port     = 80
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_nlb` - Enable NLB usage (`default = False`)
- `nlb_name` - description (`default = null`)
- `nlb_name_prefix` - Creates a unique name beginning with the specified prefix. Conflicts with nlb_name (`default = null`)
- `nlb_subnets` - A list of subnet IDs to attach to the NLB (`default = []`)
- `nlb_internal` - If true, NLB will be an internal NLB (`default = False`)
- `nlb_enable_deletion_protection` - If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false. (`default = False`)
- `nlb_enable_cross_zone_load_balancing` - (Optional) If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false. (`default = False`)
- `nlb_load_balancer_type` - The type of load balancer to create. Possible values are application or network. The default value is application. (`default = network`)
- `nlb_idle_timeout` - The time in seconds that the connection is allowed to be idle. Default: 60. (`default = 60`)
- `nlb_ip_address_type` - The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack (`default = ipv4`)
- `nlb_access_logs` - (Optional) An Access Logs block. (`default = []`)
- `nlb_subnet_mapping` - (Optional) A subnet mapping block (`default = []`)
- `nlb_timeouts` - Set timeouts for NLB (`default = {}`)
- `enable_nlb_target_group` - Enable nlb target_group usage (`default = False`)
- `nlb_target_group_name` - (Optional) The name of the target group. If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `nlb_target_group_name_prefix` - (Optional) The name prefics of the target group. (`default = ""`)
- `nlb_target_group_deregistration_delay` - (Optional) The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds. (`default = 300`)
- `nlb_target_group_vpc_id` - Set VPC ID for ?LB (`default = ""`)
- `nlb_target_group_protocol` - A protocol the NLB accepts. (e.g.: TCP) (`default = TCP`)
- `nlb_target_group_target_type` - The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address). The default is instance. Note that you can't specify targets for a target group using both instance IDs and IP addresses. If the target type is ip, specify IP addresses from the subnets of the virtual private cloud (VPC) for the target group, the RFC 1918 range (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16), and the RFC 6598 range (100.64.0.0/10). You can't specify publicly routable IP addresses (`default = instance`)
- `nlb_target_group_slow_start` - (Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds. (`default = 0`)
- `nlb_target_group_lambda_multi_value_headers_enabled` - (Optional) Boolean whether the request and response headers exchanged between the load balancer and the Lambda function include arrays of values or strings. Only applies when target_type is lambda. (`default = null`)
- `nlb_target_group_proxy_protocol_v2` - (Optional) Boolean to enable / disable support for proxy protocol v2 on Network Load Balancers (`default = False`)
- `nlb_target_group_port` - The port the service on the EC2 instances listen on. (`default = 80`)
- `nlb_target_group_certificate_arn` - The ARN of the SSL Certificate. e.g. 'arn:aws:iam::XXXXXXXXXXX:server-certificate/ProdServerCert' (`default = ""`)
- `nlb_target_group_health_check` - (Optional) A Health Check block. (`default = []`)
- `enable_nlb_target_group_attachment` - Enable nlb target group attachment usage (`default = False`)
- `nlb_target_group_attachment_target_ids` - The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container. If the target type is ip, specify an IP address. (`default = []`)
- `nlb_target_group_attachment_availability_zone` - (Optional) The Availability Zone where the IP address of the target is to be registered. (`default = null`)
- `nlb_target_group_attachment_port` - Set port for NLB target group attachment. (`default = null`)
- `nlb_target_group_attachment_target_group_arn` - The ARN of the target group with which to register targets (`default = ""`)
- `enable_nlb_listener` - Enable nlb_listener usage (`default = False`)
- `nlb_listener_load_balancer_arn` - (Required, Forces New Resource) The ARN of the load balancer (`default = ""`)
- `nlb_listener_port` - (Optional) The port on which the load balancer is listening. Not valid for Gateway Load Balancers. (`default = null`)
- `nlb_listener_protocol` - (Optional) The protocol for connections from clients to the load balancer. For Application Load Balancers, valid values are HTTP and HTTPS, with a default of HTTP. For Network Load Balancers, valid values are TCP, TLS, UDP, and TCP_UDP. Not valid to use UDP or TCP_UDP if dual-stack mode is enabled. Not valid for Gateway Load Balancers. (`default = null`)
- `nlb_listener_ssl_policy` - (Optional) The name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS. (`default = null`)
- `nlb_listener_certificate_arn` - (Optional) The ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS. For adding additional SSL certificates, see the aws_lb_listener_certificate resource. (`default = null`)
- `nlb_listener_default_action_fixed_response` - Fixed-response Blocks (`default = []`)
- `nlb_listener_default_action_redirect` - (Optional) Information for creating a redirect action. Required if type is redirect. (`default = []`)
- `nlb_listener_default_action_forward` - (Optional) Information for creating a forward action. Required if type is forward. (`default = []`)
- `nlb_listener_default_action_authenticate_cognito` - Authenticate Cognito Blocks (`default = []`)
- `nlb_listener_default_action_authenticate_oidc` - Authenticate OIDC Blocks (`default = []`)
- `nlb_listener_default_action_target_group_arn` - (Optional) The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead. (`default = null`)
- `nlb_listener_default_action_type` - (Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc (`default = null`)
- `enable_nlb_listener_rule` - Enable nlb listener rule (`default = False`)
- `nlb_listener_rule_listener_arn` - (Required, Forces New Resource) The ARN of the listener to which to attach the rule. (`default = ""`)
- `nlb_listener_rule_priority` - (Optional) The priority for the rule between 1 and 50000. Leaving it unset will automatically set the rule with next available priority after currently existing highest rule. A listener can't have multiple rules with the same priority. (`default = null`)
- `nlb_listener_rule_action_type` - (Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc (`default = null`)
- `nlb_listener_rule_action_target_group_arn` - (Optional) The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead. (`default = null`)
- `nlb_listener_rule_action_fixed_response` - (Optional) Information for creating an action that returns a custom HTTP response. Required if type is fixed-response (`default = []`)
- `nlb_listener_rule_action_forward` - (Optional) Information for creating an action that distributes requests among one or more target groups. Specify only if type is forward. If you specify both forward block and target_group_arn attribute, you can specify only one target group using forward and it must be the same target group specified in target_group_arn. (`default = []`)
- `nlb_listener_rule_action_redirect` - (Optional) Information for creating a redirect action. Required if type is redirect. (`default = []`)
- `nlb_listener_rule_action_authenticate_cognito` - (Optional) Information for creating an authenticate action using Cognito. Required if type is authenticate-cognito (`default = []`)
- `nlb_listener_rule_action_authenticate_oidc` - (Optional) Information for creating an authenticate action using OIDC. Required if type is authenticate-oidc (`default = []`)
- `nlb_listener_rule_condition_host_header` - (Optional) Contains a single values item which is a list of host header patterns to match. The maximum size of each pattern is 128 characters. Comparison is case insensitive. Wildcard characters supported: * (matches 0 or more characters) and ? (matches exactly 1 character). Only one pattern needs to match for the condition to be satisfied. (`default = []`)
- `nlb_listener_rule_condition_http_request_method` - (Optional) Contains a single values item which is a list of HTTP request methods or verbs to match. Maximum size is 40 characters. Only allowed characters are A-Z, hyphen (-) and underscore (_). Comparison is case sensitive. Wildcards are not supported. Only one needs to match for the condition to be satisfied. AWS recommends that GET and HEAD requests are routed in the same way because the response to a HEAD request may be cached. (`default = []`)
- `nlb_listener_rule_condition_path_pattern` - (Optional) Contains a single values item which is a list of path patterns to match against the request URL. Maximum size of each pattern is 128 characters. Comparison is case sensitive. Wildcard characters supported: * (matches 0 or more characters) and ? (matches exactly 1 character). Only one pattern needs to match for the condition to be satisfied. Path pattern is compared only to the path of the URL, not to its query string. To compare against the query string, use a query_string condition. (`default = []`)
- `nlb_listener_rule_condition_source_ip` - (Optional) Contains a single values item which is a list of source IP CIDR notations to match. You can use both IPv4 and IPv6 addresses. Wildcards are not supported. Condition is satisfied if the source IP address of the request matches one of the CIDR blocks. Condition is not satisfied by the addresses in the X-Forwarded-For header, use http_header condition instead. (`default = []`)
- `nlb_listener_rule_condition_http_header` - (Optional) HTTP headers to match. (`default = []`)
- `nlb_listener_rule_condition_query_string` - (Optional) Query strings to match. (`default = []`)
- `enable_nlb_listener_certificate` - Enable nlb listener certificate (`default = False`)
- `nlb_listener_certificate_listener_arn` - (Required, Forces New Resource) The ARN of the listener to which to attach the certificate. (`default = ""`)
- `nlb_listener_certificate_certificate_arn` - (Required, Forces New Resource) The ARN of the certificate to attach to the listener. (`default = null`)

## Module Output Variables
----------------------
- `nlb_name` - Get NLB name
- `nlb_arn` - ARN of the lb itself. Useful for debug output, for example when attaching a WAF.
- `nlb_arn_suffix` - ARN suffix of our lb - can be used with CloudWatch
- `nlb_dns_name` - The DNS name of the lb presumably to be used with a friendlier CNAME.
- `nlb_id` - The ID of the lb we created.
- `nlb_zone_id` - The zone_id of the lb to assist with creating DNS records.
- `nlb_target_group_arn` - ARN of the target group. Useful for passing to your Auto Scaling group module.
- `nlb_target_group_id` - The ARN of the Target Group (matches arn)
- `nlb_target_group_arn_suffix` - The ARN suffix for use with CloudWatch Metrics.
- `nlb_target_group_name` - The name of the Target Group
- `nlb_listener_arn` - The ARN of the HTTPS lb Listener we created.
- `nlb_listener_id` - The ID of the lb Listener we created.
- `nlb_listener_rule_arn` - The ARN of the rule (matches id)
- `nlb_listener_rule_id` - The ARN of the rule (matches arn)
- `lb_listener_certificate_id` - The listener_arn and certificate_arn separated by a.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
