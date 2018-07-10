variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "region" {
    description = "Where the target pool resides. Defaults to project region."
    default     = ""
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "backup_pool" {
    description = "URL to the backup target pool. Must also set failover_ratio."
    default     = ""
}

variable "description" {
    description = "Textual description field."
    default     = ""
}

variable "failover_ratio" {
    description = "Ratio (0 to 1) of failed nodes before using the backup pool (which must also be set)."
    default     = 0
}

variable "health_checks" {
    description = "(Optional) List of zero or one health check name or self_link. Only legacy google_compute_http_health_check is supported."
    #type        = "list"
    default     = []
}

variable "instances" {                                                                                  
    description = "List of instances in the pool. They can be given as URLs, or in the form of 'zone/name'. Note that the instances need not exist at the time of target pool creation, so there is no need to use the Terraform interpolators to create a dependency on the instances from the target pool."
    #type        = "list"
    default     = []
}

variable "session_affinity" {                           
    description = "How to distribute load. Options are 'NONE' (no affinity). 'CLIENT_IP' (hash of the source/dest addresses / ports), and 'CLIENT_IP_PROTO' also includes the protocol (default 'NONE')."
    default     = "NONE"
}

variable "use_compute_target_pool_default" {
    description = "Enable compute target pool default for compute autoscaler or compute instance group manager. Default - fasle"
    default     = false
}
