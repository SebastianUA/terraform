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

variable "ami" {
  description = "Default AMIs by region"
  default = {
    us-east-1 = "ami-46c1b650"
    us-west-2 = "ami-50d1d929"
    eu-west-1 = "ami-6e28b517"
  }
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
  type        = map(string)
  default     = {}
}

#-----------------------------------------------------------
# AWS EC2
#-----------------------------------------------------------
variable "enable_instance" {
  description = "Enable instance usage"
  default     = false
}

variable "instance_name" {
  description = "Name for AWS EC2 node(s)"
  default     = ""
}

variable "instance_ami" {
  description = "Set AMI ID for AWS EC2 instance"
  default     = ""
}

variable "instance_availability_zone" {
  description = "(Optional) The AZ to start the instance in."
  default     = null
}

variable "instance_type" {
  description = "Type of instance t2.micro, m1.xlarge, c1.medium etc"
  default     = "t2.micro"
}

variable "instance_disk_size" {
  description = "disk size for EC2 instance"
  default     = 8
}

variable "instance_tenancy" {
  description = "(Optional) The tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of dedicated runs on single-tenant hardware. The host tenancy is not supported for the import-instance command. Available values: default, dedicated, host."
  default     = "default"
}

variable "instance_host_id" {
  description = "(Optional) The Id of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host."
  default     = null
}

variable "instance_cpu_core_count" {
  description = "(Optional) Sets the number of CPU cores for an instance. This option is only supported on creation of instance type that support CPU Options CPU Cores and Threads Per CPU Core Per Instance Type - specifying this option for unsupported instance types will return an error from the EC2 API."
  default     = null
}

variable "instance_cpu_threads_per_core" {
  description = "(Optional - has no effect unless cpu_core_count is also set) If set to to 1, hyperthreading is disabled on the launched instance. Defaults to 2 if not set. See Optimizing CPU Options for more information."
  default     = 2
}

variable "instance_ebs_optimized" {
  description = "(Optional) If true, the launched EC2 instance will be EBS-optimized. Note that if this is not set on an instance type that is optimized by default then this will show as disabled but if the instance type is optimized by default then there is no need to set this and there is no effect to disabling it. See the EBS Optimized section of the AWS User Guide for more information. If true, the launched EC2 instance will be EBS-optimized"
  default     = null
}

variable "instance_disable_api_termination" {
  description = " (Optional) If true, enables EC2 Instance Termination Protection"
  default     = null
}

variable "instance_initiated_shutdown_behavior" {
  description = "(Optional) Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instances. See Shutdown Behavior for more information."
  default     = null
}

variable "instance_key_name" {
  description = "(Optional) The key name of the instance"
  default     = null
}

variable "instance_get_password_data" {
  description = "(Optional) If true, wait for password data to become available and retrieve it. Useful for getting the administrator password for instances running Microsoft Windows. The password data is exported to the password_data attribute. See GetPasswordData for more information."
  default     = null
}

variable "instance_security_groups" {
  description = "(Optional, EC2-Classic and default VPC only) A list of security group names (EC2-Classic) or IDs (default VPC) to associate with."
  default     = []
}

variable "instance_associate_public_ip_address" {
  description = "(Optional) Associate a public ip address with an instance in a VPC."
  default     = null
}

variable "instance_source_dest_check" {
  description = "(Optional) Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true."
  default     = true
}

variable "instance_subnet_id" {
  description = "(Optional) The VPC Subnet ID to launch in."
  default     = null
}

variable "instance_vpc_security_group_ids" {
  description = "The associated security groups in non-default VPC"
  default     = []
}

variable "instance_monitoring" {
  description = "(Optional) If true, the launched EC2 instance will have detailed monitoring enabled. If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = null
}

variable "instance_user_data" {
  description = "(Optional) The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  default     = null
}

variable "instance_user_data_base64" {
  description = "(Optional) Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
  default     = null
}

variable "instance_iam_instance_profile" {
  description = "(Optional) The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. Ensure your credentials have the correct permission to assign the instance profile according to the EC2 documentation, notably iam:PassRole."
  default     = null
}

variable "instance_placement_group" {
  description = "(Optional) The Placement Group to start the instance in."
  default     = null
}

variable "instance_placement_partition_number" {
  description = "(Optional) The number of the partition the instance is in. Valid only if the aws_placement_group resource's strategy argument is set to 'partition'."
  default     = null
}

variable "instance_private_ip" {
  description = "(Optional) Private IP address to associate with the instance in a VPC."
  default     = null
}

variable "instance_ipv6_address_count" {
  description = "(Optional) A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
  default     = null
}

variable "instance_ipv6_addresses" {
  description = "(Optional) Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  default     = null
}

variable "instance_volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

variable "instance_root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default     = []
}

variable "instance_ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  default     = []
}

variable "instance_ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  default     = []
}

variable "instance_network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  default     = []
}

variable "instance_timeouts" {
  description = "Set timeout for EC2 instance"
  default     = {}
}

variable "instance_capacity_reservation_specification" {
  description = "(Optional) Describes an instance's Capacity Reservation targeting option."
  default     = []
}

variable "instance_credit_specification" {
  description = "(Optional) Configuration block for customizing the credit specification of the instance. See Credit Specification below for more details. Terraform will only perform drift detection of its value when present in a configuration. Removing this configuration on existing instances will only stop managing it. It will not change the configuration back to the default for the instance type."
  default     = []
}

variable "instance_enclave_options" {
  description = "(Optional) Enable Nitro Enclaves on launched instances."
  default     = {}
}

variable "instance_hibernation" {
  description = "(Optional) If true, the launched EC2 instance will support hibernation."
  default     = null
}

variable "instance_secondary_private_ips" {
  description = "(Optional) A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e., referenced in a network_interface block. Refer to the Elastic network interfaces documentation to see the maximum number of private IP addresses allowed per instance type."
  default     = null
}