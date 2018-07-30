variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "auto_create_subnetworks" {
    description = "(Optional) If set to true, this network will be created in auto subnet mode, and Google will create a subnet for each region automatically. If set to false, a custom subnetted network will be created that can support google_compute_subnetwork resources. Defaults to true."
    default     = "true"
}

variable "routing_mode" {
    description = "(Optional) Sets the network-wide routing mode for Cloud Routers to use. Accepted values are 'GLOBAL' or 'REGIONAL'. Defaults to 'REGIONAL'. Refer to the Cloud Router documentation for more details."
    default     = "REGIONAL"
}

variable "description" {
    description = "(Optional) A brief description of this resource."
    default     = ""
}

variable "enable_compute_network" {
    description = "Enable compute network usage"
    default     = "true"
}

variable "enable_compute_network_peering" {
    description = "Enable compute network peering" 
    default     = "false"
}

variable "network" {
    description = "(Required) Resource link of the network to add a peering to."
    default     = ""
}

variable "peer_network" {
    description = "(Required) Resource link of the peer network."
    default     = ""
}

variable "auto_create_routes" {
    description = "(Optional) If set to true, the routes between the two networks will be created and managed automatically. Defaults to true."
    default     = "true"
}

variable "enable_compute_subnetwork" {
    description = "Enable compute subnetwork usage"
    default     = "false"
}

variable "ip_cidr_range" {
    description = "(Required) The range of internal addresses that are owned by this subnetwork. Provide this property when you create the subnetwork. For example, 10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and non-overlapping within a network. Only IPv4 is supported."
    default     = "10.2.0.0/16"
}

variable "region" {
    description = "(Optional) URL of the GCP region for this subnetwork."
    default     = "us-east1"
}

variable "enable_flow_logs" {
    description = "(Optional) Whether to enable flow logging for this subnetwork."
    default     = "false"
}

variable "private_ip_google_access" {
    description = "(Optional) Whether the VMs in this subnet can access Google services without assigned external IP addresses."
    default     = "false"
}

variable "secondary_ip_range_name" {
    description = "(Required) The name associated with this subnetwork secondary range, used when adding an alias IP range to a VM instance. The name must be 1-63 characters long, and comply with RFC1035. The name must be unique within the subnetwork."
    default     = "tf-test-secondary-range"
}

variable "secondary_ip_range_cidr" {
    description = "(Required) The range of IP addresses belonging to this subnetwork secondary range. Provide this property when you create the subnetwork. Ranges must be unique and non-overlapping with all primary and secondary IP ranges within a network. Only IPv4 is supported."
    default     = "192.168.10.0/24"
}

variable "timeouts_create" {
    description = "Time to create redis node. Default is 6 minutes. Valid units of time are s, m, h."
    default     = "6m"
}

variable "timeouts_update" {
    description = "Time to update redis node. Default is 6 minutes. Valid units of time are s, m, h."
    default     = "6m"
}

variable "timeouts_delete" {
    description = "Time to delete redis node. Default is 6 minutes. Valid units of time are s, m, h."
    default     = "6m"
}

variable "enable_compute_subnetwork_iam_policy" {
    description = "Enable compute subnetwork iam policy"
    default     = "false"
}

variable "role" {
    description = "The role that should be applied. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}."
    default     = "roles/editor"
}

variable "members" {
    description = "(Required) Identities that will be granted the privilege in role."
    default     = []
}

variable "subnetwork" {
    description = "(Required) The name of the subnetwork."
    default     = ""
}

variable "enable_compute_subnetwork_iam_binding" {
    description = "Enable compute subnetwork iam binding"
    default     = "false"
}

variable "enable_compute_subnetwork_iam_member" {
    description = "Enable compute subnetwork iam member"
    default     = "false"
}

variable "enable_secondary_ip_range" {
    description = "Enable secondary ip range"
    default     = "false"
}
