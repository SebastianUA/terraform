#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#-----------------------------------------------------------
# NLB
#-----------------------------------------------------------
variable "enable_nlb" {
  description = "Enable NLB usage"
  default     = false
}

variable "nlb_name" {
  description = "description"
  default     = null
}

variable "nlb_name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with nlb_name"
  default     = null
}

variable "nlb_subnets" {
  description = "A list of subnet IDs to attach to the NLB"
  default     = []
}

variable "nlb_internal" {
  description = "If true, NLB will be an internal NLB"
  default     = false
}

variable "nlb_enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  default     = false
}

variable "nlb_enable_cross_zone_load_balancing" {
  description = "(Optional) If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false."
  default     = false
}

variable "nlb_load_balancer_type" {
  description = "The type of load balancer to create. Possible values are application or network. The default value is application."
  default     = "network"
}

variable "nlb_idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle. Default: 60."
  default     = 60
}

variable "nlb_ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack"
  default     = "ipv4"
}

variable "nlb_access_logs" {
  description = "(Optional) An Access Logs block."
  default     = []
}

variable "nlb_subnet_mapping" {
  description = "(Optional) A subnet mapping block"
  default     = []
}

variable "nlb_timeouts" {
  description = "Set timeouts for NLB"
  default     = {}
}

#-----------------------------------------------------------
# NLB target group
#-----------------------------------------------------------
variable "enable_nlb_target_group" {
  description = "Enable nlb target_group usage"
  default     = false
}

variable "nlb_target_group_name" {
  description = "(Optional) The name of the target group. If omitted, Terraform will assign a random, unique name."
  default     = ""
}

variable "nlb_target_group_name_prefix" {
  description = "(Optional) The name prefics of the target group."
  default     = ""
}

variable "nlb_target_group_deregistration_delay" {
  description = "(Optional) The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
  default     = 300
}

variable "nlb_target_group_vpc_id" {
  description = "Set VPC ID for ?LB"
  default     = ""
}

variable "nlb_target_group_protocol" {
  description = "A protocol the NLB accepts. (e.g.: TCP)"
  default     = "TCP"
}

variable "nlb_target_group_target_type" {
  description = "The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address). The default is instance. Note that you can't specify targets for a target group using both instance IDs and IP addresses. If the target type is ip, specify IP addresses from the subnets of the virtual private cloud (VPC) for the target group, the RFC 1918 range (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16), and the RFC 6598 range (100.64.0.0/10). You can't specify publicly routable IP addresses"
  default     = "instance"
}

variable "nlb_target_group_slow_start" {
  description = "(Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds."
  default     = 0
}

variable "nlb_target_group_lambda_multi_value_headers_enabled" {
  description = "(Optional) Boolean whether the request and response headers exchanged between the load balancer and the Lambda function include arrays of values or strings. Only applies when target_type is lambda."
  default     = null
}

variable "nlb_target_group_proxy_protocol_v2" {
  description = "(Optional) Boolean to enable / disable support for proxy protocol v2 on Network Load Balancers"
  default     = false
}

variable "nlb_target_group_port" {
  description = "The port the service on the EC2 instances listen on."
  default     = 80
}

variable "nlb_target_group_certificate_arn" {
  description = "The ARN of the SSL Certificate. e.g. 'arn:aws:iam::XXXXXXXXXXX:server-certificate/ProdServerCert'"
  default     = ""
}

variable "nlb_target_group_health_check" {
  description = "(Optional) A Health Check block."
  default     = []
}

#---------------------------------------------------
# NLB target group attachment
#---------------------------------------------------
variable "enable_nlb_target_group_attachment" {
  description = "Enable nlb target group attachment usage"
  default     = false
}

variable "nlb_target_group_attachment_target_ids" {
  description = "The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container. If the target type is ip, specify an IP address."
  default     = []
}

variable "nlb_target_group_attachment_availability_zone" {
  description = "(Optional) The Availability Zone where the IP address of the target is to be registered."
  default     = null
}

variable "nlb_target_group_attachment_port" {
  description = "Set port for NLB target group attachment."
  default     = null
}

variable "nlb_target_group_attachment_target_group_arn" {
  description = "The ARN of the target group with which to register targets"
  default     = ""
}

#-----------------------------------------------------------
# NLB listner
#-----------------------------------------------------------
variable "enable_nlb_listener" {
  description = "Enable nlb_listener usage"
  default     = false
}

variable "nlb_listener_load_balancer_arn" {
  description = "(Required, Forces New Resource) The ARN of the load balancer"
  default     = ""
}

variable "nlb_listener_port" {
  description = "(Optional) The port on which the load balancer is listening. Not valid for Gateway Load Balancers."
  default     = null
}

variable "nlb_listener_protocol" {
  description = "(Optional) The protocol for connections from clients to the load balancer. For Application Load Balancers, valid values are HTTP and HTTPS, with a default of HTTP. For Network Load Balancers, valid values are TCP, TLS, UDP, and TCP_UDP. Not valid to use UDP or TCP_UDP if dual-stack mode is enabled. Not valid for Gateway Load Balancers."
  default     = null
}

variable "nlb_listener_ssl_policy" {
  description = "(Optional) The name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS."
  default     = null
}

variable "nlb_listener_certificate_arn" {
  description = "(Optional) The ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS. For adding additional SSL certificates, see the aws_lb_listener_certificate resource."
  default     = null
}

variable "nlb_listener_default_action_fixed_response" {
  description = "Fixed-response Blocks"
  default     = []
}

variable "nlb_listener_default_action_redirect" {
  description = "(Optional) Information for creating a redirect action. Required if type is redirect."
  default     = []
}

variable "nlb_listener_default_action_forward" {
  description = "(Optional) Information for creating a forward action. Required if type is forward."
  default     = []
}

variable "nlb_listener_default_action_authenticate_cognito" {
  description = "Authenticate Cognito Blocks"
  default     = []
}

variable "nlb_listener_default_action_authenticate_oidc" {
  description = "Authenticate OIDC Blocks"
  default     = []
}

variable "nlb_listener_default_action_target_group_arn" {
  description = "(Optional) The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead."
  default     = null
}

variable "nlb_listener_default_action_type" {
  description = "(Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc"
  default     = null
}

#---------------------------------------------------
# AWS NLB listener rule
#---------------------------------------------------
variable "enable_nlb_listener_rule" {
  description = "Enable nlb listener rule"
  default     = false
}

variable "nlb_listener_rule_listener_arn" {
  description = "(Required, Forces New Resource) The ARN of the listener to which to attach the rule."
  default     = ""
}

variable "nlb_listener_rule_priority" {
  description = "(Optional) The priority for the rule between 1 and 50000. Leaving it unset will automatically set the rule with next available priority after currently existing highest rule. A listener can't have multiple rules with the same priority."
  default     = null
}

variable "nlb_listener_rule_action_type" {
  description = "(Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc"
  default     = null
}

variable "nlb_listener_rule_action_target_group_arn" {
  description = "(Optional) The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead."
  default     = null
}

variable "nlb_listener_rule_action_fixed_response" {
  description = "(Optional) Information for creating an action that returns a custom HTTP response. Required if type is fixed-response"
  default     = []
}

variable "nlb_listener_rule_action_forward" {
  description = "(Optional) Information for creating an action that distributes requests among one or more target groups. Specify only if type is forward. If you specify both forward block and target_group_arn attribute, you can specify only one target group using forward and it must be the same target group specified in target_group_arn."
  default     = []
}

variable "nlb_listener_rule_action_redirect" {
  description = "(Optional) Information for creating a redirect action. Required if type is redirect."
  default     = []
}

variable "nlb_listener_rule_action_authenticate_cognito" {
  description = "(Optional) Information for creating an authenticate action using Cognito. Required if type is authenticate-cognito"
  default     = []
}

variable "nlb_listener_rule_action_authenticate_oidc" {
  description = "(Optional) Information for creating an authenticate action using OIDC. Required if type is authenticate-oidc"
  default     = []
}

variable "nlb_listener_rule_condition_host_header" {
  description = "(Optional) Contains a single values item which is a list of host header patterns to match. The maximum size of each pattern is 128 characters. Comparison is case insensitive. Wildcard characters supported: * (matches 0 or more characters) and ? (matches exactly 1 character). Only one pattern needs to match for the condition to be satisfied."
  default     = []
}

variable "nlb_listener_rule_condition_http_request_method" {
  description = "(Optional) Contains a single values item which is a list of HTTP request methods or verbs to match. Maximum size is 40 characters. Only allowed characters are A-Z, hyphen (-) and underscore (_). Comparison is case sensitive. Wildcards are not supported. Only one needs to match for the condition to be satisfied. AWS recommends that GET and HEAD requests are routed in the same way because the response to a HEAD request may be cached."
  default     = []
}

variable "nlb_listener_rule_condition_path_pattern" {
  description = "(Optional) Contains a single values item which is a list of path patterns to match against the request URL. Maximum size of each pattern is 128 characters. Comparison is case sensitive. Wildcard characters supported: * (matches 0 or more characters) and ? (matches exactly 1 character). Only one pattern needs to match for the condition to be satisfied. Path pattern is compared only to the path of the URL, not to its query string. To compare against the query string, use a query_string condition."
  default     = []
}

variable "nlb_listener_rule_condition_source_ip" {
  description = "(Optional) Contains a single values item which is a list of source IP CIDR notations to match. You can use both IPv4 and IPv6 addresses. Wildcards are not supported. Condition is satisfied if the source IP address of the request matches one of the CIDR blocks. Condition is not satisfied by the addresses in the X-Forwarded-For header, use http_header condition instead."
  default     = []
}

variable "nlb_listener_rule_condition_http_header" {
  description = "(Optional) HTTP headers to match."
  default     = []
}

variable "nlb_listener_rule_condition_query_string" {
  description = "(Optional) Query strings to match."
  default     = []
}

#---------------------------------------------------
# AWS NLB listener certificate
#---------------------------------------------------
variable "enable_nlb_listener_certificate" {
  description = "Enable nlb listener certificate"
  default     = false
}

variable "nlb_listener_certificate_listener_arn" {
  description = "(Required, Forces New Resource) The ARN of the listener to which to attach the certificate."
  default     = ""
}

variable "nlb_listener_certificate_certificate_arn" {
  description = "(Required, Forces New Resource) The ARN of the certificate to attach to the listener."
  default     = null
}
