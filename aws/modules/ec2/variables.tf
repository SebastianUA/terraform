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

variable "tags" {
    description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
    type        = map(string)
    default     = {}
}

#-----------------------------------------------------------
# AWS EC2
#-----------------------------------------------------------
variable "enable_instance" {
    description   = "Enable instance usage"
    default       = false
}

variable "instance_name" {
    description   = "Name for AWS EC2 node(s)"
    default       = ""
}

variable "ami" {
    description = "I added only 3 regions to show the map feature but you can add all"
    default     = {
        us-east-1 = "ami-46c1b650"
        us-west-2 = "ami-50d1d929"
        eu-west-1 = "ami-6e28b517"
    }
}

variable "availability_zone" {
    description   = "(Optional) The AZ to start the instance in."
    default       = ""
}

variable "instance_type" {
    description = "Type of instance t2.micro, m1.xlarge, c1.medium etc"
    default     = "t2.micro"
}

variable "disk_size" {
    description = "disk size for EC2 instance"
    default     = 8
}

variable "tenancy" {
    description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
    default     = "default"
}

variable "host_id" {
    description   = "(optional) The Id of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host."
    default       = ""
}

variable "cpu_core_count" {
    description   = "(Optional) Sets the number of CPU cores for an instance. This option is only supported on creation of instance type that support CPU Options CPU Cores and Threads Per CPU Core Per Instance Type - specifying this option for unsupported instance types will return an error from the EC2 API."
    default       = 0
}

variable "cpu_threads_per_core" {
    description   = "(Optional - has no effect unless cpu_core_count is also set) If set to to 1, hyperthreading is disabled on the launched instance. Defaults to 2 if not set. See Optimizing CPU Options for more information."
    default       = 2
}

variable "ebs_optimized" {
    description = "If true, the launched EC2 instance will be EBS-optimized"
    default     = false
}

variable "disable_api_termination" {
    description = "If true, enables EC2 Instance Termination Protection"
    default     = false
}

variable "instance_initiated_shutdown_behavior" {
    description = "Shutdown behavior for the instance"
    default     = ""
}

variable "key_name" {
    description = "(Optional) The name for the key pair."
    default     = ""
}

variable "get_password_data" {
    description = "(Optional) If true, wait for password data to become available and retrieve it. Useful for getting the administrator password for instances running Microsoft Windows. The password data is exported to the password_data attribute. See GetPasswordData for more information."
    default     = false
}

variable "security_groups" {
    description   = "(Optional, EC2-Classic and default VPC only) A list of security group names (EC2-Classic) or IDs (default VPC) to associate with."
    default       = []
}

variable "enable_associate_public_ip_address" {
    description = "Enabling associate public ip address (Associate a public ip address with an instance in a VPC)"
    default     = true
}

variable "source_dest_check" {
    description = " (Optional) Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true."
    default     = false
}

variable "subnet_id" {
    description = "Public subnet ID"
    default     = ""
}

variable "vpc_security_group_ids" {
    description = " SG for EC2"
    default     = []
}

variable "monitoring" {
    description = "If true, the launched EC2 instance will have detailed monitoring enabled"
    default     = false
}

variable "user_data" {
    description = "The user data to provide when launching the instance"
    default     = ""
}

#variable "user_data_base64" {
#  description   = "(Optional) Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
#  default       = ""
#}

variable "iam_instance_profile" {
    description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
    default     = ""
}

variable "placement_group" {
    description = "The Placement Group to start the instance in"
    default     = ""
}

variable "private_ip" {
    description = "Private IP address to associate with the instance in a VPC"
    default     = ""
}

variable "ipv6_address_count" {
    description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
    default     = 0
}

variable "ipv6_addresses" {
    description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
    default     = []
}

variable "volume_tags" {
    description = "A mapping of tags to assign to the devices created by the instance at launch time"
    type        = map(string)
    default     = {}
}

variable "root_block_device" {
    description = "Customize details about the root block device of the instance. See Block Devices below for details"
    default     = []
}

variable "ebs_block_device" {
    description = "Additional EBS block devices to attach to the instance"
    default     = []
}

variable "ephemeral_block_device" {
    description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
    default     = []
}

variable "network_interface" {
    description = "Customize network interfaces to be attached at instance boot time"
    default     = []
}

variable "timeouts_create" {
    description   = "(Defaults to 10 mins) Used when launching the instance (until it reaches the initial running state)"
    default       = "10m"
}

variable "timeouts_update" {
    description   = "(Defaults to 10 mins) Used when stopping and starting the instance when necessary during update - e.g. when changing instance type"
    default       = "10m"
}

variable "timeouts_delete" {
    description   = "(Defaults to 20 mins) Used when terminating the instance"
    default       = "20m"
}
