#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-ELB"
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

# Create ELB
variable "availability_zones" {
    description = "Availability zones for AWS ASG"
    type        = "map"
    default     = {
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
    }
}

variable "security_groups" {
    description = "A list of security group IDs to assign to the ELB. Only valid if creating an ELB within a VPC"
    type        = "list"
    #default     = []
}

variable "subnets" {
    description = "A list of subnet IDs to attach to the ELB"
    type        = "list"
    default     = []
}

variable "instances" {
    description = " Instances ID to add them to ELB"
    type        = "list"
    default     = []
}

variable "elb_internal" {
    description = "If true, ELB will be an internal ELB"
    default     = false
}

variable "cross_zone_load_balancing" {
    description = "Enable cross-zone load balancing. Default: true"
    default     = true
}

variable "idle_timeout" {
    description = "The time in seconds that the connection is allowed to be idle. Default: 60"
    default     = "60"
}

variable "connection_draining" {
    description = "Boolean to enable connection draining. Default: false"
    default     = false
}

variable "connection_draining_timeout" {
    description = "The time in seconds to allow for connections to drain. Default: 300"
    default     = 300
}

# Access logs
variable "access_logs" {
    description = "An access logs block. Uploads access logs to S3 bucket"
    type        = "list"
    default     = []
}

# Listener
variable "listener" {
    description = "A list of Listener block"
    type        = "list"
}

# Health Check
variable "health_check" {
    description = " Health check"
    type        = "list"
}

variable "enable_lb_cookie_stickiness_policy_http" {
    description = "Enable lb cookie stickiness policy http. If set true, will add it, else will use https"
    default     = "true"
}

variable "enable_app_cookie_stickiness_policy_http" {
    description = "Enable app cookie stickiness policy http. If set true, will add it, else will use https"
    default     = "true"
}

variable "http_lb_port" {
    description = "Set http lb port for lb_cookie_stickiness_policy_http|app_cookie_stickiness_policy_http policies"
    default     = "80"
}

variable "https_lb_port" {
    description = "Set https lb port for lb_cookie_stickiness_policy_http|app_cookie_stickiness_policy_http policies"
    default     = "443"
}

variable "cookie_expiration_period" {
    description = "Set cookie expiration period"
    default     = 600
}

variable "cookie_name" {
    description = "Set cookie name"
    default     = "SessionID"
}
