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

variable "enable_container_cluster" {
    description = "Enable container cluster usage"
    default     = "true"
}

variable "initial_node_count" {
    description = "(Optional) The number of nodes to create in this cluster (not including the Kubernetes master). Must be set if node_pool is not set."
    default     = "3"
}

variable "additional_zones" {
    description = "(Optional) The list of additional Google Compute Engine locations in which the cluster's nodes should be located. If additional zones are configured, the number of nodes specified in initial_node_count is created in all specified zones."
    default     = ["us-east1-c", "us-east1-d"]
}

variable "region" {
    description = "(Optional, Beta) The region to create the cluster in, for Regional Clusters."
    default     = ""
}

variable "timeouts_create" {
    description = "Time to create redis node. Default is 30 minutes. Valid units of time are s, m, h."
    default     = "30m"
}

variable "timeouts_update" {
    description = "Time to update redis node. Default is 10 minutes. Valid units of time are s, m, h."
    default     = "10m"
}

variable "timeouts_delete" {
    description = "Time to delete redis node. Default is 10 minutes. Valid units of time are s, m, h."
    default     = "10m"
}

variable "cluster_ipv4_cidr" {
    description = "(Optional) The IP address range of the kubernetes pods in this cluster. Default is an automatically assigned CIDR."
    default     = ""
}

variable "description" {
    description = "(Optional) Description of the cluster."
    default     = ""
}

variable "enable_kubernetes_alpha" {
    description = "(Optional) Whether to enable Kubernetes Alpha features for this cluster. Note that when this option is enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days."
    default     = "false"
}

variable "enable_legacy_abac" {
    description = "(Optional) Whether the ABAC authorizer is enabled for this cluster. When enabled, identities in the system, including service accounts, nodes, and controllers, will have statically granted permissions beyond those provided by the RBAC configuration or IAM. Defaults to false"
    default     = "false"
}

variable "logging_service" {
    description = "(Optional) The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none. Defaults to logging.googleapis.com"
    default     = "logging.googleapis.com"
}

variable "master_authorized_networks_config" {
    description = "(Optional) The desired configuration options for master authorized networks. Omit the nested cidr_blocks attribute to disallow external access (except the cluster node IPs, which GKE automatically whitelists)."
    default     = []
}

variable "master_ipv4_cidr_block" {
    description = "(Optional, Beta) Specifies a private RFC1918 block for the master's VPC. The master range must not overlap with any subnet in your cluster's VPC. The master and your cluster use VPC peering. Must be specified in CIDR notation and must be /28 subnet. Ex: 10.0.0.0/28"
    default     = "10.4.0.0/28" 
}

variable "min_master_version" {
    description = "(Optional) The minimum version of the master. GKE will auto-update the master to new versions, so this does not guarantee the current master version--use the read-only master_version field to obtain that. If unset, the cluster's version will be set by GKE to the version of the most recent official release (which is not necessarily the latest version)."
    default     = ""
}

variable "monitoring_service" {
    description = "(Optional) The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none. Defaults to monitoring.googleapis.com"
    default     = "monitoring.googleapis.com"
}

variable "network" {
    description = "(Optional) The name or self_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network."
    default     = ""
}

variable "node_version" {
    description = "(Optional) The Kubernetes version on the nodes. Must either be unset or set to the same value as min_master_version on create. Defaults to the default version set by GKE which is not necessarily the latest version."
    default     = ""
}

variable "private_cluster" {
    description = "(Optional, Beta) If true, a private cluster will be created, meaning nodes do not get public IP addresses. It is mandatory to specify master_ipv4_cidr_block and ip_allocation_policy with this option."
    default     = "false"
}

variable "project" {
    description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = "terraform-2018"
}

variable "remove_default_node_pool" {
    description = "(Optional) If true, deletes the default node pool upon cluster creation."
    default     = "false"
}

variable "subnetwork" {
    description = "(Optional) The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
    default     = ""
}

variable "master_auth_username" {
    description = "(Required) The username to use for HTTP basic authentication when accessing the Kubernetes master endpoint"
    default     = "captain"
}

variable "master_auth_password" {
    description = "(Required) The password to use for HTTP basic authentication when accessing the Kubernetes master endpoint"
    default     = "PassWord666@captainua"
}

variable "issue_client_certificate" {
    description = "(Optional) Whether client certificate authorization is enabled for this cluster."
    default     = "false"
}

variable "node_config_disk_size_gb" {
    description = "(Optional) Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. Defaults to 100GB."
    default     = "100"
}

variable "node_config_local_ssd_count" {
    description = "(Optional) The amount of local SSD disks that will be attached to each cluster node. Defaults to 0."
    default     = "0"
}

variable "node_config_machine_type" {
    description = "(Optional) The name of a Google Compute Engine machine type. Defaults to n1-standard-1. To create a custom machine type, value should be set as specified here."
    default     = "n1-standard-1"
}

variable "node_config_min_cpu_platform" {
    description = "Optional) Minimum CPU platform to be used by this instance. The instance may be scheduled on the specified or newer CPU platform. Applicable values are the friendly names of CPU platforms, such as Intel Haswell."
    default     = "Intel Haswell"
}

variable "node_config_oauth_scopes" {
    description = "(Optional) The set of Google API scopes to be made available on all of the node VMs under the 'default' service account. These can be either FQDNs, or scope aliases."
    default     = ["https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]
}

variable "ssh_user" {
    description = "User for connection to google machine"
    default     = "captain"
}

variable "public_key_path" {
    description = "Path to file containing public key"
    default     = "~/.ssh/gcloud_id_rsa.pub"
}

variable "node_config_guest_accelerator_count" {
    description = "(Required) - The number of the guest accelerator cards exposed to this instance."
    default     = "0"
}

variable "node_config_guest_accelerator_type" {
    description = "(Required) - The accelerator type resource to expose to this instance. E.g. nvidia-tesla-k80."
    default     = "nvidia-tesla-k80"
}

variable "node_config_preemptible" {
    description = "(Optional) A boolean that represents whether or not the underlying node VMs are preemptible. See the official documentation for more information. Defaults to false."
    default     = "false"
}

variable "node_config_service_account" {
    description = "(Optional) The service account to be used by the Node VMs. If not specified, the 'default' service account is used."
    default     = "default"
}

variable "node_config_taint" {
    description = "(Optional, Beta) List of kubernetes taints to apply to each node."
    default     = []
}

variable "node_pool" {
    description = "(Optional) List of node pools associated with this cluster."
    default     = []
}

variable "node_config_workload_metadata_config_node_metadata" {
    description = "(Required) How to expose the node metadata to the workload running on the node. Accepted values are: UNSPECIFIED: Not Set; SECURE: Prevent workloads not in hostNetwork from accessing certain VM metadata, specifically kube-env, which contains Kubelet credentials, and the instance identity token. See Metadata Concealment documentation; EXPOSE: Expose all VM metadata to pods."
    default     = "SECURE"
}

variable "node_config_image_type" {
    description = "(Optional) The image type to use for this node. Ex: ubuntu or cos."
    default     = "cos"
}

variable "horizontal_pod_autoscaling_disabled" {
    description = "Optional) The status of the Horizontal Pod Autoscaling addon, which increases or decreases the number of replica pods a replication controller has based on the resource usage of the existing pods. It ensures that a Heapster pod is running in the cluster, which is also used by the Cloud Monitoring service. It is enabled by default; set disabled = true to disable."
    default     = "true"
}

variable "http_load_balancing_disabled" {
    description = "(Optional) The status of the HTTP (L7) load balancing controller addon, which makes it easy to set up HTTP load balancers for services in a cluster. It is enabled by default; set disabled = true to disable."
    default     = "false"
}

variable "kubernetes_dashboard_disabled" {
    description = "(Optional) The status of the Kubernetes Dashboard add-on, which controls whether the Kubernetes Dashboard is enabled for this cluster. It is enabled by default; set disabled = true to disable."
    default     = "true"
}

variable "network_policy_config_disabled" {
    description = "(Optional) Whether we should enable the network policy addon for the master. This must be enabled in order to enable network policy for the nodes. It can only be disabled if the nodes already do not have network policies enabled. Set disabled = true to disable."
    default     = "false"
}

variable "ip_allocation_policy_cluster_secondary_range_name" {
    description = "(Optional) The name of the secondary range to be used as for the cluster CIDR block. The secondary range will be used for pod IP addresses. This must be an existing secondary range associated with the cluster subnetwork. Ex: bolcom-sbf3pp-pods"
    default     = ""
}

variable "ip_allocation_policy_services_secondary_range_name" {
    description = "(Optional) The name of the secondary range to be used as for the services CIDR block. The secondary range will be used for service ClusterIPs. This must be an existing secondary range associated with the cluster subnetwork. Ex: bolcom-sbf3pp-services"
    default     = ""
}

variable "network_policy_provider" {
    description = "(Optional) The selected network policy provider. Defaults to PROVIDER_UNSPECIFIED."
    default     = "PROVIDER_UNSPECIFIED"
}

variable "network_policy_enabled" {
    description = "(Optional) Whether network policy is enabled on the cluster. Defaults to false."
    default     = "false"
}

variable "pod_security_policy_config_enabled" {
    description = "(Required) - Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created."
    default     = "false"
}

variable "daily_maintenance_window_start_time" {
    description = "(Required) Time window specified for daily maintenance operations. Specify start_time in RFC3339 format 'HH:MM', where HH : [00-23] and MM : [00-59] GMT."
    default     = "03:00"
}

variable "enable_container_node_pool" {
    description = "Enable container node pool usage"
    default     = "false"
}

variable "container_cluster_name" {
    description = "(Required) The cluster to create the node pool for. Cluster must be present in zone provided for zonal clusters."
    default     = ""
}

variable "autoscaling_min_node_count" {
    description = "(Required) Minimum number of nodes in the NodePool. Must be >=1 and <= max_node_count."
    default     = "1"
}

variable "autoscaling_max_node_count" {
    description = "(Required) Maximum number of nodes in the NodePool. Must be >= min_node_count."
    default     = "1"
}

variable "management_auto_repair" {
    description = "(Optional) Whether the nodes will be automatically repaired."
    default     = "true"
}

variable "management_auto_upgrade" {
    description = "(Optional) Whether the nodes will be automatically upgraded."
    default     = "true"
}

variable "node_count" {
    description = "(Optional) The number of nodes per instance group. This field can be used to update the number of nodes per instance group but should not be used alongside autoscaling."
    default     = "3"
}
