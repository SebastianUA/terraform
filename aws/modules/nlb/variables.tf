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
    description = "A list of tag blocks. Each element should have keys named key, value, etc."
    type        = map(string)
    default     = {}
}

#-----------------------------------------------------------
# NLB
#-----------------------------------------------------------
variable "enable_nlb" {
  description   = "Enable NLB usage"
  default       = false
}

variable "nlb_name" {
  description   = "description"
  default       = ""
}

variable "name_prefix" {
    description = "Creates a unique name beginning with the specified prefix. Conflicts with nlb_name"
    default     = ""
}

variable "subnets" {
    description = "A list of subnet IDs to attach to the NLB"
    default     = []
}

variable "lb_internal" {
    description = "If true, NLB will be an internal NLB"
    default     = false
}

variable "enable_deletion_protection" {
    description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
    default     = false
}

variable "enable_cross_zone_load_balancing" {
  description   = "(Optional) If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false."
  default       = false
}

variable "load_balancer_type" {
    description = "The type of load balancer to create. Possible values are application or network. The default value is application."
    default     = "network"
}

variable "idle_timeout" {
    description = "The time in seconds that the connection is allowed to be idle. Default: 60."
    default     = 60
}

variable "ip_address_type" {
    description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack"
    default     = "ipv4"
}

variable "access_logs" {
  description   = "(Optional) An Access Logs block."
  default       = []
}

variable "subnet_mapping" {
  description   = "(Optional) A subnet mapping block"
  default       = []
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

#-----------------------------------------------------------
# NLB target group
#-----------------------------------------------------------
variable "enable_nlb_target_group" {
  description   = "Enable nlb target_group usage"
  default       = false
}

variable "nlb_target_group_name" {
  description   = "The name of the target group. If omitted, Terraform will assign a random, unique name."
  default       = ""
}

variable "deregistration_delay" {
  description   = " (Optional) The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
  default       = 300
}

variable "vpc_id" {
    description   = "Set VPC ID for ?LB"
    default       = ""
}

variable "alb_protocols" {
    description = "A protocol the ALB accepts. (e.g.: TCP)"
    default     = "TCP"
}

variable "target_type" {
    description = "The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address). The default is instance. Note that you can't specify targets for a target group using both instance IDs and IP addresses. If the target type is ip, specify IP addresses from the subnets of the virtual private cloud (VPC) for the target group, the RFC 1918 range (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16), and the RFC 6598 range (100.64.0.0/10). You can't specify publicly routable IP addresses"
    default     = "instance"
}

variable "slow_start" {
  description   = "(Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds."
  default       = 0
}

variable "lambda_multi_value_headers_enabled" {
  description   = "(Optional) Boolean whether the request and response headers exchanged between the load balancer and the Lambda function include arrays of values or strings. Only applies when target_type is lambda."
  default       = null
}

variable "proxy_protocol_v2" {
  description   = "(Optional) Boolean to enable / disable support for proxy protocol v2 on Network Load Balancers"
  default       = false
}

variable "backend_port" {
    description = "The port the service on the EC2 instances listen on."
    default     = 80
}

variable "backend_protocol" {
    description = "The protocol the backend service speaks. Options: HTTP, HTTPS, TCP, SSL (secure tcp)."
    default     = "HTTP"
}

variable "certificate_arn" {
    description = "The ARN of the SSL Certificate. e.g. 'arn:aws:iam::XXXXXXXXXXX:server-certificate/ProdServerCert'"
    default     = ""
}

variable "health_check" {
  description   = "(Optional) A Health Check block."
  default       = []
}

#---------------------------------------------------
# NLB target group attachment
#---------------------------------------------------
variable "enable_nlb_target_group_attachment" {
  description   = "Enable nlb target group attachment usage"
  default       = false
}

variable "target_ids" {
    description = "The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container. If the target type is ip, specify an IP address."
    default     = []
}

variable "availability_zone" {
  description   = "(Optional) The Availability Zone where the IP address of the target is to be registered."
  default       = null
}

variable "target_group_arn" {
  description   = "The ARN of the target group with which to register targets"
  default       = ""
}

#---------------------------------------------------
# NLB listeners
#---------------------------------------------------
variable "enable_nlb_listener1" {
  description   = "Enable NLB 1st listener"
  default       = false
}

variable "nlb_listener1_port" {
  description   = "(Required) The port on which the load balancer is listening."
  default       = 80
}

variable "nlb_listener1_protocol" {
  description   = "(Optional) The protocol for connections from clients to the load balancer. Valid values are TCP, TLS, UDP, TCP_UDP, HTTP and HTTPS. Defaults to HTTP."
  default       = "TCP"
}

#variable "nlb_listener1_default_action" {
#  description = "An Action block"
#  default     = []
#}

variable "nlb_listener1_default_action_target_group_arn" {
  description = "(Optional) The ARN of the Target Group to which to route traffic. Required if type is forward"
  default     = ""
}

variable "nlb_listener1_default_action_type" {
  description = "(Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc."
  default     = "forward"
}

variable "enable_nlb_listener2" {
  description   = "Enable NLB 2d listener"
  default       = false
}

variable "nlb_listener2_port" {
  description   = "(Required) The port on which the load balancer is listening."
  default       = 443
}

variable "nlb_listener2_protocol" {
  description   = "(Optional) The protocol for connections from clients to the load balancer. Valid values are TCP, TLS, UDP, TCP_UDP, HTTP and HTTPS. Defaults to HTTP."
  default       = "TCP"
}

#variable "nlb_listener2_default_action" {
#  description = "An Action block"
#  default     = []
#}

variable "nlb_listener2_default_action_target_group_arn" {
  description = "(Optional) The ARN of the Target Group to which to route traffic. Required if type is forward"
  default     = ""
}

variable "nlb_listener2_default_action_type" {
  description = "(Required) The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc."
  default     = "forward"
}

variable "load_balancer_arn" {
  description   = "The ARN of the load balancer."
  default       = ""
}
