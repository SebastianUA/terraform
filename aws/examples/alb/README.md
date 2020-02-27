# Work with AWS ALB via terraform

A terraform module for making ALB.

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
    shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
    profile                 = "default"
}

module "alb" {
    source                              = "../../modules/alb"
    name                                = "App-Load-Balancer"
    region                              = "us-east-1"
    environment                         = "staging"
    tags                                = "${map("Mytestkey", "test")}"

    enable_alb                          = true
    load_balancer_type                  = "application"
    alb_name                            = "MyfirstLB"
    security_groups                     = ["sg-aed75fe1"]
    subnets                             = ["subnet-ea58d88d", "subnet-cb5581f5"]
    enable_deletion_protection          = false

    enable_alb_target_group             = true
    alb_target_group_name               = "myFirstLB"
    backend_protocol                    = "HTTP"
    alb_protocols                       = "HTTP"
    vpc_id                              = "vpc-56af732c"

    frontend_http_port                  = 80
    frontend_http_protocol              = "HTTP"
    frontend_http_default_action_type   = "forward"
    frontend_https_port                 = 443
    frontend_https_protocol             = "HTTPS"
    frontend_https_default_action_type   = "forward"

    #alb_target_group_attachment         = true
    #target_ids                          = ["test", "test2"]

}
```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`     = "TEST"`).
- `region` - The region where to deploy this code (e.g. us-east-1). (`     = "us-east-1"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `tags` - Add additional tags (`       = {}`).
- `enable_alb` - Enable ALB usage (`default     = false`).
- `enable_alb_logs` - Enable ALB usage (`default     = false`).
- `enable_alb_prefix` - Enable ALB with name_prefix usage (`default     = false`).
- `alb_name` - Set ALB name (`default     = ""`).
- `security_groups` - A list of security group IDs to assign to the ALB. Only valid if creating an ALB within a VPC (`default     = []`).
- `subnets` - A list of subnet IDs to attach to the ALB (`default     = []`).
- `lb_internal` - If true, ALB will be an internal ALB (`default     = false`).
- `name_prefix` - Creates a unique name beginning with the specified prefix. Conflicts with name (`default     = "alb"`).
- `enable_cross_zone_load_balancing` - (Optional) If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false. (`default     = false`).
- `enable_deletion_protection` - If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false. (`default     = false`).
# Access logs
- `access_logs_enabled` - (Optional) Boolean to enable / disable access_logs. Defaults to false, even when bucket is specified. (`default     = false`).
- `access_logs_bucket` - (Required) The S3 bucket name to store the logs in. (`default     = ""`).
- `access_logs_prefix` - (Optional) The S3 bucket prefix. Logs are stored in the root if not configured. (`default     = ""`).
- `load_balancer_type` - The type of load balancer to create. Possible values are application or network. The default value is application. (`default     = "application"`).
- `idle_timeout` - The time in seconds that the connection is allowed to be idle. Default: 60. (`default     = 60`).
- `ip_address_type` - The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack (`default     = "ipv4"`).
- `timeouts_create" {
    description = "Used for Creating LB. Default = 10mins (`default     = "10m"`).
- `timeouts_update` - Used for LB modifications. Default = 10mins (`default     = "10m"`).
- `timeouts_delete` - Used for LB destroying LB. Default = 10mins (`default     = "10m"`).
- `vpc_id` - Set VPC ID for ?LB (`default     = ""`).
- `alb_protocols` - A comma delimited list of the protocols the ALB accepts. e.g.: HTTPS (`default     = "HTTP,HTTPS"`).
- `target_type` - The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address) or lambda. The default is instance. Note that you can't specify targets for a target group using both instance IDs and IP addresses. If the target type is ip, specify IP addresses from the subnets of the virtual private cloud (VPC) for the target group, the RFC 1918 range (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16), and the RFC 6598 range (100.64.0.0/10). You can't specify publicly routable IP addresses (`default     = "instance"`).
- `deregistration_delay` - The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds. (`default     = 300`).
- `enable_http2" {
  description   = "(Optional) Indicates whether HTTP/2 is enabled in application load balancers. Defaults to true. (`       = true`).
- `tg_name_prefix` - Enable ALB with name_prefix usage (`default     = false`).
- `enable_alb_target_group` - Enable alb target group (`default     = false`).
- `enable_alb_target_group_prefix` - Enable alb target group (`default     = false`).
- `alb_target_group_name` - Names for alb target group (`default     = ""`).
- `backend_port` - The port the service on the EC2 instances listen on. (`default     = 80`).
- `backend_protocol` - The protocol the backend service speaks. Options: HTTP HTTPS TCP TLS UDP TCP_UDP (secure tcp). (`default     = "HTTP"`).
- `slow_start" {
  description   = "(Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds. (`       = 0`).
- `certificate_arn` - The ARN of the SSL Certificate. e.g. 'arn:aws:iam::XXXXXXXXXXX:server-certificate/ProdServerCert' (`default     = ""`).
- `ssl_policy` - The ARN of the SSL Certificate. e.g. 'arn:aws:iam::XXXXXXXXXXX:server-certificate/ProdServerCert' (`default     = "ELBSecurityPolicy-2016-08"`).
- `health_check_healthy_threshold` - Number of consecutive positive health checks before a backend instance is considered healthy. (`default     = 3`).
- `health_check_enabled` - (Optional) Indicates whether health checks are enabled. Defaults to true. (`default     = true`).
- `health_check_interval` - Interval in seconds on which the health check against backend hosts is tried. (`default     = 10`).
- `health_check_path` - The URL the ALB should use for health checks. e.g. /health (`default     = "/"`).
- `health_check_port` - The port used by the health check if different from the traffic-port. (`default     = "traffic-port"`).
- `health_check_timeout` - Seconds to leave a health check waiting before terminating it and calling the check unhealthy. (`default     = 5`).
- `health_check_unhealthy_threshold` - Number of consecutive positive health checks before a backend instance is considered unhealthy. (`default     = 3`).
- `health_check_matcher` - The HTTP codes that are a success when checking TG health. (`default     = "200-299"`).
- `stickiness_type` - (Required) The type of sticky sessions. The only current possible value is lb_cookie. (`default     = "lb_cookie"`).
- `stickiness_cookie_duration` - If load balancer connection stickiness is desired, set this to the duration in seconds that cookie should be valid (e.g. 300). Otherwise, if no stickiness is desired, leave the default. (`default     = 1`).
- `alb_target_group_attachment` - Enable to use alb_target_group_attachment (`default     = false`).
- `alb_target_group_attachment_prefix` - Enable to use alb_target_group_attachment (`default     = false`).
- `target_ids` - The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container. If the target type is ip, specify an IP address. (`default     = []`).
- `frontend_http_port` - The port the service on the EC2 instances listen on. (`default     = 80`).
- `frontend_http_protocol` - The protocol the backend service speaks. Options: HTTP HTTPS TCP TLS UDP TCP_UDP (secure tcp). (`default     = "HTTP"`).
- `frontend_http_default_action_type" {
  description   = "(Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc. (`       = "forward"`).
- `frontend_https_port` - The port the service on the EC2 instances listen on. (`default     = 443`).
- `frontend_https_protocol` - The protocol the backend service speaks. Options: HTTP HTTPS TCP TLS UDP TCP_UDP (secure tcp). (`default     = "HTTPS"`).
- `frontend_https_default_action_type" {
  description   = "(Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc. (`       = "forward"`).
- `enable_lb_listener_certificate` - Enable alb listener certificate (`default     = false`).
- `enable_lb_listener_certificate_prefix` - Enable alb listener certificate (`default     = false`).
- `listener_arn" {
  description   = "(Required, Forces New Resource) The ARN of the listener to which to attach the certificate. (`       = ""`).
- `enable_lb_listener_rule" {
  description   = "Enable alb listener rule (`       = false`).
- `enable_lb_listener_rule_prefix" {
  description   = "Enable alb listener rule (`       = false`).
- `lb_listener_rule_forward" {
  description   = "Enable alb listener rule for forwarding (`       = false`).
- `lb_listener_rule_redirect" {
  description   = "Enable alb listener rule for redirecting (`       = false`).
- `lb_listener_rule_fixed_response" {
  description   = "Enable alb listener rule for fixed response (`       = false`).
- `enable_lb_listener_rule_cognito" {
  description   = "Enable alb listener rule for cognito (`       = false`).
- `enable_lb_listener_rule_oidc" {
  description   = "Enable alb listener rule for oidc (`       = false`).
- `target_group_arn" {
  description   = "(Optional) The ARN of the Target Group to which to route traffic. Required if type is forward. (`       = ""`).
- `priority" {
  description   = "(Optional) The priority for the rule between 1 and 50000. Leaving it unset will automatically set the rule with next available priority after currently existing highest rule. A listener can't have multiple rules with the same priority. (`       = 100`).
- `condition_values" {
  description   = "(Required) The path patterns to match. A maximum of 1 can be defined. (`       = []`).- `redirect_host" {
  description   = "(Optional) The hostname. This component is not percent-encoded. The hostname can contain #{host}. Defaults to #{host}. (`       = "#{host}"`).
- `redirect_port" {
  description   = "(Optional) The port. Specify a value from 1 to 65535 or #{port}. Defaults to #{port}. (`       = 443`).
- `redirect_protocol" {
  description   = "(Optional) The protocol. Valid values are HTTP, HTTPS, or #{protocol}. Defaults to #{protocol}. (`       = 443`).
- `redirect_status_code" {
  description   = "(Required) The HTTP redirect code. The redirect is either permanent (HTTP_301) or temporary (HTTP_302). (`       = "HTTP_301"`).
- `redirect_path" {
  description   = "(Optional) The absolute path, starting with the leading "/". This component is not percent-encoded. The path can contain #{host}, #{path}, and #{port}. Defaults to /#{path}. (`       = "/#{path}"`).
- `redirect_query" {
  description   = "(Optional) The query parameters, URL-encoded when necessary, but not percent-encoded. Do not include the leading "?". Defaults to #{query}. (`       = "#{query}"`).
- `fixed_response_content_type" {
  description   = "(Required) The content type. Valid values are text/plain, text/css, text/html, application/javascript and application/json (`       = "text/plain"`).
- `fixed_response_message_body" {
  description   = "(Optional) The message body. (`       = "HEALTHY"`).
- `fixed_response_status_code" {
  description   = "(Optional) The HTTP response code. Valid values are 2XX, 4XX, or 5XX. (`       = 200`).
- `authenticate_cognito_authentication_request_extra_params" {
  description   = "(Optional) The query parameters to include in the redirect request to the authorization endpoint. Max: 10. (`       = []`).
- `authenticate_cognito_on_unauthenticated_request" {
  description   = "(Optional) The behavior if the user is not authenticated. Valid values: deny, allow and authenticate (`       = "authenticate"`).
- `authenticate_cognito_scope" {
  description   = "(Optional) The set of user claims to be requested from the IdP. (`       = ""`).
- `authenticate_cognito_session_cookie_name" {
  description   = "(Optional) The name of the cookie used to maintain session information. (`       = ""`).
- `authenticate_cognito_session_timeout" {
  description   = "(Optional) The maximum duration of the authentication session, in seconds. (`       = 60`).
- `authenticate_cognito_user_pool_arn" {
  description   = "(Required) The ARN of the Cognito user pool. (`       = ""`).
- `authenticate_cognito_user_pool_client_id" {
  description   = "(Required) The ID of the Cognito user pool client. (`       = ""`).
- `authenticate_cognito_user_pool_domain" {
  description   = "description (`       = "(Required) The domain prefix or fully-qualified domain name of the Cognito user pool."`).
- `authenticate_oidc_authentication_request_extra_params" {
  description   = "(Optional) The query parameters to include in the redirect request to the authorization endpoint. Max: 10. (`       =  []`).
- `authenticate_oidc_authorization_endpoint" {
  description   = "(Required) The authorization endpoint of the IdP. (`       = ""`).
- `authenticate_oidc_client_id" {
  description   = "(Required) The OAuth 2.0 client identifier. (`       = ""`).
- `authenticate_oidc_client_secret" {
  description   = "(Required) The OAuth 2.0 client secret. (`       = ""`).
- `authenticate_oidc_issuer" {
  description   = "(Required) The OIDC issuer identifier of the IdP. (`       = ""`).
- `authenticate_oidc_token_endpoint" {
  description   = "(Required) The token endpoint of the IdP. (`       = ""`).
- `authenticate_oidc_user_info_endpoint" {
  description   = "(Required) The user info endpoint of the IdP. (`       = ""`).
- `authenticate_oidc_on_unauthenticated_request" {
  description   = "(Optional) The behavior if the user is not authenticated. Valid values: deny, allow and authenticate (`       = "authenticate"`).
- `authenticate_oidc_scope" {
  description   = "(Optional) The set of user claims to be requested from the IdP. (`       = ""`).
- `authenticate_oidc_session_cookie_name" {
  description   = "(Optional) The name of the cookie used to maintain session information. (`       = ""`).
- `authenticate_oidc_session_timeout" {
  description   = "(Optional) The maximum duration of the authentication session, in seconds. (`       = 60`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
