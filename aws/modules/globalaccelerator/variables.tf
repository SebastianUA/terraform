#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "tags" {
    description = "A list of tag blocks. Each element should have keys named key, value, etc."
    type        = map(string)
    default     = {}
}

#---------------------------------------------------
# AWS globalaccelerator accelerator
#---------------------------------------------------
variable "enable_globalaccelerator_accelerator" {
  description   = "Enable globalaccelerator accelerator usage"
  default       = false
}

variable "globalaccelerator_accelerator_name" {
  description   = "The name of the accelerator."
  default       = ""
}

variable "globalaccelerator_accelerator_ip_address_type" {
  description   = "(Optional) The value for the address type must be IPV4."
  default       = "IPV4"
}

variable "globalaccelerator_accelerator_enabled" {
  description   = "(Optional) Indicates whether the accelerator is enabled. The value is true or false. The default value is true."
  default       = true
}

variable "globalaccelerator_accelerator_attributes" {
  description   = "(Optional) The attributes of the accelerator."
  default       = []
}

#---------------------------------------------------
# AWS globalaccelerator listener
#---------------------------------------------------
variable "enable_globalaccelerator_listener" {
  description   = "Enable globalaccelerator listener usage"
  default       = false
}

variable "globalaccelerator_listener_accelerator_arn" {
  description   = "The Amazon Resource Name (ARN) of your accelerator."
  default       = ""
}

variable "globalaccelerator_listener_client_affinity" {
  description   = "(Optional) Direct all requests from a user to the same endpoint. Valid values are NONE, SOURCE_IP. Default: NONE. If NONE, Global Accelerator uses the 'five-tuple' properties of source IP address, source port, destination IP address, destination port, and protocol to select the hash value. If SOURCE_IP, Global Accelerator uses the 'two-tuple' properties of source (client) IP address and destination IP address to select the hash value."
  default       = "NONE"
}

variable "globalaccelerator_listener_protocol" {
  description   = "(Optional) The protocol for the connections from clients to the accelerator. Valid values are TCP, UDP."
  default       = "TCP"
}

variable "globalaccelerator_listener_port_range" {
  description   = "(Optional) The list of port ranges for the connections from clients to the accelerator. "
  default       = []
}

#---------------------------------------------------
# AWS globalaccelerator endpoint group
#---------------------------------------------------
variable "enable_globalaccelerator_endpoint_group" {
  description   = "Enable globalaccelerator endpoint group usage"
  default       = false
}

variable "globalaccelerator_endpoint_group_listener_arn" {
  description   = "The Amazon Resource Name (ARN) of the listener."
  default       = ""
}

variable "globalaccelerator_endpoint_group_endpoint_group_region" {
  description   = "(Optional) - The name of the AWS Region where the endpoint group is located."
  default       = null
}

variable "globalaccelerator_endpoint_group_health_check_interval_seconds" {
  description   = "(Optional) The time—10 seconds or 30 seconds—between each health check for an endpoint. The default value is 30."
  default       = 30
}

variable "globalaccelerator_endpoint_group_health_check_path" {
  description   = "(Optional) If the protocol is HTTP/S, then this specifies the path that is the destination for health check targets. The default value is slash (/)."
  default       = "/"
}

variable "globalaccelerator_endpoint_group_health_check_port" {
  description   = "(Optional) The port that AWS Global Accelerator uses to check the health of endpoints that are part of this endpoint group. The default port is the listener port that this endpoint group is associated with. If listener port is a list of ports, Global Accelerator uses the first port in the list."
  default       = null
}

variable "globalaccelerator_endpoint_group_health_check_protocol" {
  description   = "(Optional) The protocol that AWS Global Accelerator uses to check the health of endpoints that are part of this endpoint group. The default value is TCP."
  default       = "TCP"
}

variable "globalaccelerator_endpoint_group_threshold_count" {
  description   = "(Optional) The number of consecutive health checks required to set the state of a healthy endpoint to unhealthy, or to set an unhealthy endpoint to healthy. The default value is 3."
  default       = 3
}

variable "globalaccelerator_endpoint_group_traffic_dial_percentage" {
  description   = "(Optional) The percentage of traffic to send to an AWS Region. Additional traffic is distributed to other endpoint groups for this listener. The default value is 100."
  default       = 100
}

variable "globalaccelerator_endpoint_group_endpoint_configuration" {
  description   = "(Optional) The list of endpoint objects."
  default       = []
}
