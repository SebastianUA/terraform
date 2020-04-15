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
# AWS Appmesh mesh
#---------------------------------------------------
variable "enable_appmesh_mesh" {
  description   = "Enable appmesh mesh usage"
  default       = false
}

variable "appmesh_mesh_name" {
  description   = "The name to use for the service mesh."
  default       = ""
}

variable "appmesh_mesh_spec_egress_filter_type" {
  description   = "(Optional) The egress filter type. By default, the type is DROP_ALL. Valid values are ALLOW_ALL and DROP_ALL."
  default       = "DROP_ALL"
}

#---------------------------------------------------
# AWS Appmesh virtual node
#---------------------------------------------------
variable "enable_appmesh_virtual_node" {
  description   = "Enable appmesh virtual node usage"
  default       = false
}

variable "appmesh_virtual_node_name" {
  description   = "The name to use for the virtual node."
  default       = ""
}

variable "appmesh_virtual_node_mesh_name" {
  description   = "The name of the service mesh in which to create the virtual node."
  default       = ""
}

variable "appmesh_virtual_node_backend" {
  description = "(Optional) The backends to which the virtual node is expected to send outbound traffic."
  default     = []
}

variable "appmesh_virtual_node_listener" {
  description = "(Optional) The listeners from which the virtual node is expected to receive inbound traffic."
  default     = []
}

variable "appmesh_virtual_node_listener_hc" {
  description = "(Optional) The listeners from which the virtual node is expected to receive inbound traffic with health_check."
  default     = []
}

variable "appmesh_virtual_node_service_discovery_dns" {
  description = "(Optional) The service discovery information for the virtual node for DNS."
  default     = []
}

variable "appmesh_virtual_node_service_discovery_cloud_map" {
  description = "(Optional) The service discovery information for the virtual node for aws_cloud_map."
  default     = []
}

variable "appmesh_virtual_node_logging" {
  description = "(Optional) The inbound and outbound access logging information for the virtual node."
  default     = []
}

#---------------------------------------------------
# AWS Appmesh virtual service
#---------------------------------------------------
variable "enable_appmesh_virtual_service" {
  description = "Enable appmesh virtual service usage"
  default     = false
}

variable "appmesh_virtual_service_name" {
  description = "The name to use for the virtual service."
  default     = ""
}

variable "appmesh_virtual_service_mesh_name" {
  description = "The name of the service mesh in which to create the virtual service."
  default     = ""
}

variable "appmesh_virtual_service_spec_provider_virtual_node" {
  description = "(Optional) The virtual node associated with a virtual service."
  default     = []
}

variable "appmesh_virtual_service_spec_provider_virtual_router" {
  description = "(Optional) The virtual router associated with a virtual service."
  default     = []
}

#---------------------------------------------------
# AWS Appmesh virtual router
#---------------------------------------------------
variable "enable_appmesh_virtual_router" {
  description = "Enable appmesh virtual router usage"
  default     = false
}

variable "appmesh_virtual_router_name" {
  description = "The name to use for the virtual router."
  default     = ""
}

variable "appmesh_virtual_router_mesh_name" {
  description = "The name of the service mesh in which to create the virtual router."
  default     = ""
}

variable "appmesh_virtual_router_spec_listener_port_mapping_port" {
  description = "(Required) The port used for the port mapping."
  default     = 8080
}

variable "appmesh_virtual_router_spec_listener_port_mapping_protocol" {
  description = "(Required) The protocol used for the port mapping. Valid values are http and tcp."
  default     = "http"
}

#---------------------------------------------------
# AWS Appmesh route
#---------------------------------------------------
variable "enable_appmesh_route" {
  description = "Enable appmesh route usage"
  default     = false
}

variable "appmesh_route_name" {
  description = "The name to use for the route."
  default     = ""
}

variable "appmesh_route_mesh_name" {
  description = "The name of the service mesh in which to create the route."
  default     = ""
}

variable "appmesh_route_virtual_router_name" {
  description = "The name of the virtual router in which to create the route."
  default     = ""
}

variable "appmesh_route_spec_priority" {
  description = "(Optional) The priority for the route, between 0 and 1000. Routes are matched based on the specified value, where 0 is the highest priority."
  default     = null
}

variable "appmesh_route_http_route" {
  description = "(Optional) The HTTP routing information for the route."
  default     = []
}

variable "appmesh_route_http_route_header" {
  description = "(Optional) The HTTP routing information for the route with header supporting"
  default     = []
}

variable "appmesh_route_http_route_header_match" {
  description = "(Optional) The HTTP routing information for the route with header + match supporting"
  default     = []
}

variable "appmesh_route_http_route_header_match_range" {
  description = "(Optional) The HTTP routing information for the route with header + match + range supporting"
  default     = []
}

variable "appmesh_route_tcp_route" {
  description = "(Optional) The TCP routing information for the route."
  default     = []
}
