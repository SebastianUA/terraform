variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "zone" {
  description = "The zone that the machine should be created in"
  default     = "us-east1-b"    
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "description" {
    description = "An optional textual description of the instance group manager."
    default     = ""
}

variable "project" {
    description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "target" {
    description = "The full URL to the instance group manager whose size we control."
    default     = ""
}

variable "autoscaling_policy_max_replicas" {
    description = "(Required) The group will never be larger than this."
    default     = "1"
}

variable "autoscaling_policy_min_replicas" {
    description = "(Required) The group will never be smaller than this."
    default     = "1"
}

variable "autoscaling_policy_cooldown_period" {
    description = "(Optional) Period to wait between changes. This should be at least double the time your instances take to start up."
    default     = "60"
}

variable "cpu_utilization_target" {
    description = "The floating point threshold where CPU utilization should be. E.g. for 50% one would specify 0.5."
    default     = "0.5"
}

variable "metric_name" {
    description = "The name of the Google Cloud Monitoring metric to follow, e.g. compute.googleapis.com/instance/network/received_bytes_count"
    default     = ""
}

variable "metric_type" {
    description = "Either 'cumulative', 'delta', or 'gauge'."
    default     = "delta"
}

variable "metric_target" {
    description = "The desired metric value per instance. Must be a positive value."
    default     = "0"
}

variable "load_balancing_utilization_target" {
    description = "The floating point threshold where load balancing utilization should be. E.g. if the load balancer's maxRatePerInstance is 10 requests per second (RPS) then setting this to 0.5 would cause the group to be scaled such that each instance receives 5 RPS."
    default     = "0.5"
}
