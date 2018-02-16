#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-EC2"
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

variable "ami" {
    description = "I added only 3 regions to show the map feature but you can add all"    
    type        = "map"
    default     = {
        us-east-1 = "ami-46c1b650"
        us-west-2 = "ami-46c1b650"
        eu-west-1 = "ami-6e28b517"
    }
}

variable "number_of_instances" {
    description = "Number of instances to make"
    default     = "1"
}

variable "ec2_instance_type" {
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

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  default     = ""
}

variable "public_key" {
    description = "Key path to your RSA|DSA key"
    default     = "/Users/captain/.ssh/id_rsa.pub"
}

variable "private_key" {
    description = "Private key"
    default     = "/Users/captain/.ssh/id_rsa"
}

variable "enable_associate_public_ip_address" {
    description = "Enabling associate public ip address (Associate a public ip address with an instance in a VPC)"
    default     = "true"
}

variable "source_dest_check" {
    description = " (Optional) Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true."
    default     = "false"
}

variable "subnet_id" {
    description = "Public subnet ID"
    #type        = "list"
}

variable "vpc_security_group_ids" {
    description = " SG for EC2"
    type        = "list"
}

variable "monitoring" {
    description = "If true, the launched EC2 instance will have detailed monitoring enabled"
    default     = false
}

variable "user_data" {
    description = "The user data to provide when launching the instance"
    default     = ""
}

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
