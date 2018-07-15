variable "name" {
    description = "(Required) The ID of the instance or a fully qualified identifier for the instance."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "memory_size_gb" {
    description = "(Required) Redis memory size in GiB."
    default     = "1"
}

variable "tier" {
    description = "(Optional) The service tier of the instance. Must be one of these values. BASIC: standalone instance. STANDARD_HA: highly available primary/replica instances"
    default     = "STANDARD_HA"
}

variable "region" {
    description = "(Optional) The name of the Redis region of the instance."
    default     = "us-east1"
}

variable "location_id" {
    description = "(Optional) The zone where the instance will be provisioned. If not provided, the service will choose a zone for the instance. For STANDARD_HA tier, instances will be created across two zones for protection against zonal failures. If [alternativeLocationId] is also provided, it must be different from [locationId]."
    default     = "us-east1-b"
}

variable "project" {
    description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "alternative_location_id" {
    description = "(Optional) Only applicable to STANDARD_HA tier which protects the instance against zonal failures by provisioning it across two zones. If provided, it must be a different zone from the one provided in [locationId]."
    default     = "us-east1-d"
}

variable "authorized_network" {
    description = "(Optional) The full name of the Google Compute Engine network to which the instance is connected. If left unspecified, the default network will be used."
    default     = ""
}

variable "redis_version" {
    description = "(Optional) The version of Redis software. If not provided, latest supported version will be used. Updating the version will perform an upgrade/downgrade to the new version. Currently, the supported values are REDIS_3_2 for Redis 3.2."
    default     = "REDIS_3_2"
}

variable "display_name" {
    description = "(Optional) An arbitrary and optional user-provided name for the instance."
    default     = ""
}

variable "count_redis_instance" {
    description = "How many machines will be created"
    default     = "1"
}

variable "reserved_ip_range" {
    description = "(Optional) The CIDR range of internal addresses that are reserved for this instance. If not provided, the service will choose an unused /29 block, for example, 10.0.0.0/29 or 192.168.0.0/29. Ranges must be unique and non-overlapping with existing subnets in an authorized network."
    default     = ""
}

variable "timeouts_create" {
    description = "Time to create redis node. Default is 6 minutes. Valid units of time are s, m, h."
    default     = "6m"
}

variable "timeouts_update" {
    description = "Time to update redis node. Default is 4 minutes. Valid units of time are s, m, h."
    default     = "4m"
}

variable "timeouts_delete" {
    description = "Time to delete redis node. Default is 4 minutes. Valid units of time are s, m, h."
    default     = "4m"
}
