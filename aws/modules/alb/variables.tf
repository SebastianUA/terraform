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

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}
variable "tags" {
  description   = "Add additional tags"
  default       = {}
}

#-----------------------------------------------------------
# AWS ALB
#-----------------------------------------------------------
variable "enable_alb" {
    description = "Enable ALB usage"
    default     = false
}

variable "enable_alb_logs" {
    description = "Enable ALB usage"
    default     = false
}

variable "enable_alb_prefix" {
    description = "Enable ALB with name_prefix usage"
    default     = false
}

variable "alb_name" {
    description = "Set ALB name"
    default     = ""
}

variable "security_groups" {
    description = "A list of security group IDs to assign to the ALB. Only valid if creating an ALB within a VPC"
    default     = []
}

variable "subnets" {
    description = "A list of subnet IDs to attach to the ALB"
    default     = []
}

variable "lb_internal" {
    description = "If true, ALB will be an internal ALB"
    default     = false
}


variable "name_prefix" {
    description = "Creates a unique name beginning with the specified prefix. Conflicts with name"
    default     = "alb"
}

variable "enable_cross_zone_load_balancing" {
    description = "(Optional) If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false."
    default     = false
}

variable "enable_deletion_protection" {
    description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
    default     = false
}

# Access logs
variable "access_logs_enabled" {
    description = "(Optional) Boolean to enable / disable access_logs. Defaults to false, even when bucket is specified."
    default     = false
}

variable "access_logs_bucket" {
    description = "(Required) The S3 bucket name to store the logs in."
    default     = ""
}

variable "access_logs_prefix" {
    description = "(Optional) The S3 bucket prefix. Logs are stored in the root if not configured."
    default     = ""
}

variable "load_balancer_type" {
    description = "The type of load balancer to create. Possible values are application or network. The default value is application."
    default     = "application"
}

variable "idle_timeout" {
    description = "The time in seconds that the connection is allowed to be idle. Default: 60."
    default     = 60
}

variable "ip_address_type" {
    description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack"
    default     = "ipv4"
}

variable "timeouts_create" { 
    description = "Used for Creating LB. Default = 10mins"
    default     = "10m"
}

variable "timeouts_update" {
    description = "Used for LB modifications. Default = 10mins"
    default     = "10m"
}

variable "timeouts_delete" {
    description = "Used for LB destroying LB. Default = 10mins"
    default     = "10m"
}

variable "vpc_id" {
    description = "Set VPC ID for ?LB"
    default     = ""
}

variable "alb_protocols" {
    description = "A comma delimited list of the protocols the ALB accepts. e.g.: HTTPS"
    default     = "HTTP,HTTPS"
}

variable "target_type" {
    description = "The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address) or lambda. The default is instance. Note that you can't specify targets for a target group using both instance IDs and IP addresses. If the target type is ip, specify IP addresses from the subnets of the virtual private cloud (VPC) for the target group, the RFC 1918 range (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16), and the RFC 6598 range (100.64.0.0/10). You can't specify publicly routable IP addresses"
    default     = "instance"
}

variable "deregistration_delay" {
    description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
    default     = 300
}

variable "enable_http2" {
  description   = "(Optional) Indicates whether HTTP/2 is enabled in application load balancers. Defaults to true."
  default       = true
}

#-----------------------------------------------------------
# ALB target group
#-----------------------------------------------------------
variable "tg_name_prefix" {
    description = "Enable ALB with name_prefix usage"
    default     = false
}

variable "enable_alb_target_group" {
    description = "Enable alb target group"
    default     = false
}

variable "enable_alb_target_group_prefix" {
    description = "Enable alb target group"
    default     = false
}

variable "alb_target_group_name" {
    description = "Names for alb target group"
    default     = ""
}

variable "backend_port" {
    description = "The port the service on the EC2 instances listen on."
    default     = 80
}

variable "backend_protocol" {
    description = "The protocol the backend service speaks. Options: HTTP HTTPS TCP TLS UDP TCP_UDP (secure tcp)."
    default     = "HTTP"
}

variable "slow_start" {
  description   = "(Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds."
  default       = 0
}

variable "certificate_arn" {
    description = "The ARN of the SSL Certificate. e.g. 'arn:aws:iam::XXXXXXXXXXX:server-certificate/ProdServerCert'"
    default     = ""
}

variable "ssl_policy" {
    description = "The ARN of the SSL Certificate. e.g. 'arn:aws:iam::XXXXXXXXXXX:server-certificate/ProdServerCert'"
    default     = "ELBSecurityPolicy-2016-08"
}

variable "health_check_healthy_threshold" {
    description = "Number of consecutive positive health checks before a backend instance is considered healthy."
    default     = 3
}

variable "health_check_enabled" {
    description = "(Optional) Indicates whether health checks are enabled. Defaults to true."
    default     = true
}

variable "health_check_interval" {
    description = "Interval in seconds on which the health check against backend hosts is tried."
    default     = 10
}

variable "health_check_path" {
    description = "The URL the ALB should use for health checks. e.g. /health"
    default     = "/"
}

variable "health_check_port" {
    description = "The port used by the health check if different from the traffic-port."
    default     = "traffic-port"
}

variable "health_check_timeout" {
    description = "Seconds to leave a health check waiting before terminating it and calling the check unhealthy."
    default     = 5
}

variable "health_check_unhealthy_threshold" {
    description = "Number of consecutive positive health checks before a backend instance is considered unhealthy."
    default     = 3
}

variable "health_check_matcher" {
    description = "The HTTP codes that are a success when checking TG health."
    default     = "200-299"
}

variable "stickiness_type" {
    description = "(Required) The type of sticky sessions. The only current possible value is lb_cookie."
    default     = "lb_cookie"
}

variable "stickiness_cookie_duration" {
    description = "If load balancer connection stickiness is desired, set this to the duration in seconds that cookie should be valid (e.g. 300). Otherwise, if no stickiness is desired, leave the default."
    default     = 1
}

#-----------------------------------------------------------
# ALB target group attachment
#-----------------------------------------------------------
variable "alb_target_group_attachment" {
    description = "Enable to use alb_target_group_attachment"
    default     = false
}

variable "alb_target_group_attachment_prefix" {
    description = "Enable to use alb_target_group_attachment"
    default     = false
}

variable "target_ids" {
    description = "The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container. If the target type is ip, specify an IP address."
    default     = []
}

#-----------------------------------------------------------
# ALB listner
#-----------------------------------------------------------
variable "frontend_http_port" {
    description = "The port the service on the EC2 instances listen on."
    default     = 80
}

variable "frontend_http_protocol" {
    description = "The protocol the backend service speaks. Options: HTTP HTTPS TCP TLS UDP TCP_UDP (secure tcp)."
    default     = "HTTP"
}

variable "frontend_http_default_action_type" {
  description   = "(Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc."
  default       = "forward"
}

variable "frontend_https_port" {
    description = "The port the service on the EC2 instances listen on."
    default     = 443
}

variable "frontend_https_protocol" {
    description = "The protocol the backend service speaks. Options: HTTP HTTPS TCP TLS UDP TCP_UDP (secure tcp)."
    default     = "HTTPS"
}

variable "frontend_https_default_action_type" {
  description   = "(Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc."
  default       = "forward"
}

#---------------------------------------------------
# Create AWS LB listener certificate
#---------------------------------------------------
variable "enable_lb_listener_certificate" {
    description = "Enable alb listener certificate"
    default     = false
}

variable "enable_lb_listener_certificate_prefix" {
    description = "Enable alb listener certificate"
    default     = false
}

variable "listener_arn" {
  description   = "(Required, Forces New Resource) The ARN of the listener to which to attach the certificate."
  default       = ""
}

#---------------------------------------------------
# Create AWS LB listener rule
#---------------------------------------------------
variable "enable_lb_listener_rule" {
  description   = "Enable alb listener rule"
  default       = false
}

variable "enable_lb_listener_rule_prefix" {
  description   = "Enable alb listener rule"
  default       = false
}

variable "lb_listener_rule_forward" {
  description   = "Enable alb listener rule for forwarding"
  default       = false
}

variable "lb_listener_rule_redirect" {
  description   = "Enable alb listener rule for redirecting"
  default       = false
}

variable "lb_listener_rule_fixed_response" {
  description   = "Enable alb listener rule for fixed response"
  default       = false
}

variable "enable_lb_listener_rule_cognito" {
  description   = "Enable alb listener rule for cognito"
  default       = false
}

variable "enable_lb_listener_rule_oidc" {
  description   = "Enable alb listener rule for oidc"
  default       = false
}

variable "target_group_arn" {
  description   = "(Optional) The ARN of the Target Group to which to route traffic. Required if type is forward."
  default       = ""
}

variable "priority" {
  description   = "(Optional) The priority for the rule between 1 and 50000. Leaving it unset will automatically set the rule with next available priority after currently existing highest rule. A listener can't have multiple rules with the same priority."
  default       = 100
}

variable "condition_values" {
  description   = "(Required) The path patterns to match. A maximum of 1 can be defined."
  default       = []
}
variable "redirect_host" {
  description   = "(Optional) The hostname. This component is not percent-encoded. The hostname can contain #{host}. Defaults to #{host}."
  default       = "#{host}"
}

variable "redirect_port" {
  description   = "(Optional) The port. Specify a value from 1 to 65535 or #{port}. Defaults to #{port}."
  default       = 443
}

variable "redirect_protocol" {
  description   = "(Optional) The protocol. Valid values are HTTP, HTTPS, or #{protocol}. Defaults to #{protocol}."
  default       = 443
}

variable "redirect_status_code" {
  description   = "(Required) The HTTP redirect code. The redirect is either permanent (HTTP_301) or temporary (HTTP_302)."
  default       = "HTTP_301"
}

variable "redirect_path" {
  description   = "(Optional) The absolute path, starting with the leading "/". This component is not percent-encoded. The path can contain #{host}, #{path}, and #{port}. Defaults to /#{path}."
  default       = "/#{path}"
}

variable "redirect_query" {
  description   = "(Optional) The query parameters, URL-encoded when necessary, but not percent-encoded. Do not include the leading "?". Defaults to #{query}."
  default       = "#{query}"
}

variable "fixed_response_content_type" {
  description   = "(Required) The content type. Valid values are text/plain, text/css, text/html, application/javascript and application/json"
  default       = "text/plain"
}

variable "fixed_response_message_body" {
  description   = "(Optional) The message body."
  default       = "HEALTHY"
}

variable "fixed_response_status_code" {
  description   = "(Optional) The HTTP response code. Valid values are 2XX, 4XX, or 5XX."
  default       = 200
}

variable "authenticate_cognito_authentication_request_extra_params" {
  description   = "(Optional) The query parameters to include in the redirect request to the authorization endpoint. Max: 10."
  default       = []
}

variable "authenticate_cognito_on_unauthenticated_request" {
  description   = "(Optional) The behavior if the user is not authenticated. Valid values: deny, allow and authenticate"
  default       = "authenticate"
}

variable "authenticate_cognito_scope" {
  description   = "(Optional) The set of user claims to be requested from the IdP."
  default       = ""
}

variable "authenticate_cognito_session_cookie_name" {
  description   = "(Optional) The name of the cookie used to maintain session information."
  default       = ""
}

variable "authenticate_cognito_session_timeout" {
  description   = "(Optional) The maximum duration of the authentication session, in seconds."
  default       = 60
}

variable "authenticate_cognito_user_pool_arn" {
  description   = "(Required) The ARN of the Cognito user pool."
  default       = ""
}

variable "authenticate_cognito_user_pool_client_id" {
  description   = "(Required) The ID of the Cognito user pool client."
  default       = ""
}

variable "authenticate_cognito_user_pool_domain" {
  description   = "description"
  default       = "(Required) The domain prefix or fully-qualified domain name of the Cognito user pool."
} 

variable "authenticate_oidc_authentication_request_extra_params" {
  description   = "(Optional) The query parameters to include in the redirect request to the authorization endpoint. Max: 10."
  default       =  []
}

variable "authenticate_oidc_authorization_endpoint" {
  description   = "(Required) The authorization endpoint of the IdP."
  default       = ""
}

variable "authenticate_oidc_client_id" {
  description   = "(Required) The OAuth 2.0 client identifier."
  default       = ""
}

variable "authenticate_oidc_client_secret" {
  description   = "(Required) The OAuth 2.0 client secret."
  default       = ""
}

variable "authenticate_oidc_issuer" {
  description   = "(Required) The OIDC issuer identifier of the IdP."
  default       = ""
}

variable "authenticate_oidc_token_endpoint" {
  description   = "(Required) The token endpoint of the IdP."
  default       = ""
}

variable "authenticate_oidc_user_info_endpoint" {
  description   = "(Required) The user info endpoint of the IdP."
  default       = ""
}

variable "authenticate_oidc_on_unauthenticated_request" {
  description   = "(Optional) The behavior if the user is not authenticated. Valid values: deny, allow and authenticate"
  default       = "authenticate"
}

variable "authenticate_oidc_scope" {
  description   = "(Optional) The set of user claims to be requested from the IdP."
  default       = ""
}

variable "authenticate_oidc_session_cookie_name" {
  description   = "(Optional) The name of the cookie used to maintain session information."
  default       = ""
}

variable "authenticate_oidc_session_timeout" {
  description   = "(Optional) The maximum duration of the authentication session, in seconds."
  default       = 60
}
