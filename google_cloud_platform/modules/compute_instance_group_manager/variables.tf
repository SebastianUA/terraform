variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "project" {
    description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
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

variable "zone" {
    description = "The zone that instances in this group should be created in."
    default     = "us-east1-b"
}

variable "base_instance_name" {
    description = "The base instance name to use for instances in this group. The value must be a valid RFC1035 name. Supported characters are lowercase letters, numbers, and hyphens (-). Instances are named by appending a hyphen and a random four-character string to the base instance name."
    default     = "TEST"
}

variable "instance_template" {
    description = "The full URL to an instance template from which all new instances will be created. Conflicts with version"
    default     = ""
}

variable "target_pools" {
    description = "The full URL of all target pools to which new instances in the group are added. Updating the target pools attribute does not affect existing instances."
    default     = []
}

variable "description" {
    description = "An optional textual description of the instance group manager."
    default     = ""
}

variable "update_strategy" {            
    description = "(Optional, Default 'RESTART') If the instance_template resource is modified, a value of 'NONE' will prevent any of the managed instances from being restarted by Terraform. A value of 'RESTART' will restart all of the instances at once. 'ROLLING_UPDATE' is supported as [Beta feature]. A value of 'ROLLING_UPDATE' requires rolling_update_policy block to be set"
    default     = "RESTART"
}

variable "target_size" {
    description = "The target number of running instances for this managed instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set. Defaults to 0."
    default     = 0
}

variable "wait_for_instances" {
    description = "Whether to wait for all instances to be created/updated before returning. Note that if this is set to true and the operation does not succeed, Terraform will continue trying until it times out."
    default     = "true"
}

variable "rolling_update_policy_type" {
    description = "The type of update. Valid values are 'OPPORTUNISTIC', 'PROACTIVE'"
    default     = "PROACTIVE"
}

variable "rolling_update_policy_minimal_action" {
    description = "Minimal action to be taken on an instance. Valid values are 'RESTART', 'REPLACE'"
    default     = "REPLACE"
}

variable "rolling_update_policy_max_surge_fixed" {
    description = "The maximum number of instances that can be created above the specified targetSize during the update process. Conflicts with max_surge_percent. If neither is set, defaults to 1"
    default     = "1"
}

variable "rolling_update_policy_max_surge_percent" {
    description = "The maximum number of instances(calculated as percentage) that can be created above the specified targetSize during the update process. Conflicts with max_surge_fixed."
    default     = "20"
}

variable "rolling_update_policy_max_unavailable_fixed" {
    description = "The maximum number of instances that can be unavailable during the update process. Conflicts with max_unavailable_percent. If neither is set, defaults to 1"
    default     = "1"
}

variable "rolling_update_policy_max_unavailable_percent" {
    description = "The maximum number of instances(calculated as percentage) that can be unavailable during the update process. Conflicts with max_unavailable_fixed."
    default     = "20"
}

variable "rolling_update_policy_min_ready_sec" {
    description = "Minimum number of seconds to wait for after a newly created instance becomes available. This value must be from range [0, 3600]"
    default     = "50"
}

variable "named_port_name" {
    description = "The name of the port."
    default     = "custom-http"
}

variable "named_port_port" {
    description = "The port number."
    default     = "80"
}

variable "auto_healing_policies_health_check" {
    description = "The health check resource that signals autohealing."
    default     = ""
}

variable "auto_healing_policies_initial_delay_sec" {
    description = "The number of seconds that the managed instance group waits before it applies autohealing policies to new instances or recently recreated instances. Between 0 and 3600."
    default     = "300"
}

variable "enable_just_instance_template_usage" {
    description = "Enable instance template usage. Will be conflict with version. Default - true"
    default     = "true"
}

variable "use_compute_instance_group_manager_default" {
    description = "Enable instance group manager default"
    default     = false
}
