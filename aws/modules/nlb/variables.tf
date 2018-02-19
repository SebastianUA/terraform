#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-NLB"
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

variable "subnets" {
    description = "A list of subnet IDs to attach to the NLB"
    type        = "list"
    default     = []
}

variable "lb_internal" {
    description = "If true, NLB will be an internal NLB"
    default     = false
}

variable "name_prefix" {
    description = "Creates a unique name beginning with the specified prefix. Conflicts with name"
    default     = "nlb"
}

variable "enable_deletion_protection" {
    description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
    default     = false
}

variable "load_balancer_type" {
    description = "The type of load balancer to create. Possible values are application or network. The default value is application."
    default     = "network"
}

variable "idle_timeout" {
    description = "The time in seconds that the connection is allowed to be idle. Default: 60."
    default     = "60"
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
}

variable "alb_protocols" {
    description = "A protocol the ALB accepts. (e.g.: TCP)"
    default     = "TCP"
}

variable "target_type" {
    description = "The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address). The default is instance. Note that you can't specify targets for a target group using both instance IDs and IP addresses. If the target type is ip, specify IP addresses from the subnets of the virtual private cloud (VPC) for the target group, the RFC 1918 range (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16), and the RFC 6598 range (100.64.0.0/10). You can't specify publicly routable IP addresses"
    default     = "instance"
}

variable "deregistration_delay" {
    description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
    default     = "300"
}

variable "backend_port" {
    description = "The port the service on the EC2 instances listen on."
    default     = 80
}

variable "backend_protocol" {
    description = "The protocol the backend service speaks. Options: HTTP, HTTPS, TCP, SSL (secure tcp)."
    default     = "HTTP"
}

variable "target_ids" {
    description = "The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container. If the target type is ip, specify an IP address."
    type        = "list"
    default     = []
}

variable "certificate_arn" {
    description = "The ARN of the SSL Certificate. e.g. 'arn:aws:iam::XXXXXXXXXXX:server-certificate/ProdServerCert'"
    default     = ""
}

variable "health_check_healthy_threshold" {
    description = "Number of consecutive positive health checks before a backend instance is considered healthy."
    default     = 3
}

variable "health_check_interval" {
    description = "Interval in seconds on which the health check against backend hosts is tried."
    default     = 10
}

variable "health_check_port" {
    description = "The port used by the health check if different from the traffic-port."
    default     = "traffic-port"
}

variable "health_check_unhealthy_threshold" {
    description = "Number of consecutive positive health checks before a backend instance is considered unhealthy."
    default     = 3
}

