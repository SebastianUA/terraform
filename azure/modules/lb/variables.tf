#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "this"
}

variable "environment" {
  description = "Environment for service"
  default     = "test"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# Azure lb
#-----------------------------------------------------------
variable "enable_lb" {
  description = "Enable lb usage"
  default     = false
}

variable "lb_name" {
  description = "Specifies the name of the Load Balancer."
  default     = ""
}

variable "lb_resource_group_name" {
  description = "(Required) The name of the Resource Group in which to create the Load Balancer."
  default     = null
}

variable "lb_location" {
  description = "(Required) Specifies the supported Azure Region where the Load Balancer should be created."
  default     = null
}

variable "lb_edge_zone" {
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Load Balancer should exist. Changing this forces a new Load Balancer to be created."
  default     = null
}

variable "lb_sku" {
  description = "(Optional) The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway. Defaults to Basic."
  default     = null
}

variable "lb_sku_tier" {
  description = "(Optional) sku_tier - (Optional) The SKU tier of this Load Balancer. Possible values are Global and Regional. Defaults to Regional. Changing this forces a new resource to be created."
  default     = null
}

variable "lb_frontend_ip_configuration" {
  description = "(Optional) One or multiple frontend_ip_configuration blocks"
  default     = []
}

variable "lb_timeouts" {
  description = "Set timeouts for LB"
  default     = {}
}

#-----------------------------------------------------------
# Azure lb rule
#-----------------------------------------------------------
variable "enabne_lb_rule" {
  description = "Enabne lb rule usage"
  default     = false
}

variable "lb_rule_name" {
  description = "Specifies the name of the LB Rule."
  default     = ""
}

variable "lb_rule_loadbalancer_id" {
  description = "The ID of the Load Balancer in which to create the Rule."
  default     = ""
}

variable "lb_rule_frontend_ip_configuration_name" {
  description = "(Required) The name of the frontend IP configuration to which the rule is associated."
  default     = null
}

variable "lb_rule_protocol" {
  description = "(Required) The transport protocol for the external endpoint. Possible values are Tcp, Udp or All"
  default     = null
}

variable "lb_rule_frontend_port" {
  description = "(Required) The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive."
  default     = null
}

variable "lb_rule_backend_port" {
  description = "(Required) The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive."
  default     = null
}

variable "lb_rule_backend_address_pool_ids" {
  description = "(Optional) A list of reference to a Backend Address Pool over which this Load Balancing Rule operates."
  default     = null
}

variable "lb_rule_probe_id" {
  description = "(Optional) A reference to a Probe used by this Load Balancing Rule."
  default     = null
}

variable "lb_rule_enable_floating_ip" {
  description = "(Optional) Are the Floating IPs enabled for this Load Balncer Rule? A 'floating' IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false"
  default     = null
}

variable "lb_rule_idle_timeout_in_minutes" {
  description = "(Optional) Specifies the idle timeout in minutes for TCP connections. Valid values are between 4 and 30 minutes. Defaults to 4 minutes"
  default     = null
}

variable "lb_rule_load_distribution" {
  description = "(Optional) Specifies the load balancing distribution type to be used by the Load Balancer. Possible values are: Default – The load balancer is configured to use a 5 tuple hash to map traffic to available servers. SourceIP – The load balancer is configured to use a 2 tuple hash to map traffic to available servers. SourceIPProtocol – The load balancer is configured to use a 3 tuple hash to map traffic to available servers. Also known as Session Persistence, where the options are called None, Client IP and Client IP and Protocol respectively."
  default     = null
}

variable "lb_rule_disable_outbound_snat" {
  description = "(Optional) Is snat enabled for this Load Balancer Rule? Default false."
  default     = null
}

variable "lb_rule_enable_tcp_reset" {
  description = "(Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false."
  default     = null
}

variable "lb_rule_timeouts" {
  description = "Set timeouts for lb rule"
  default     = {}
}

#-----------------------------------------------------------
# Azure lb probe
#-----------------------------------------------------------
variable "enable_lb_probe" {
  description = "Enable lb probe usage"
  default     = false
}

variable "lb_probe_name" {
  description = "Specifies the name of the Probe."
  default     = ""
}

variable "lb_probe_loadbalancer_id" {
  description = "The ID of the LoadBalancer in which to create the NAT Rule."
  default     = ""
}

variable "lb_probe_port" {
  description = "(Required) Port on which the Probe queries the backend endpoint. Possible values range from 1 to 65535, inclusive."
  default     = null
}

variable "lb_probe_protocol" {
  description = "(Optional) Specifies the protocol of the end point. Possible values are Http, Https or Tcp. If TCP is specified, a received ACK is required for the probe to be successful. If HTTP is specified, a 200 OK response from the specified URI is required for the probe to be successful."
  default     = null
}

variable "lb_probe_request_path" {
  description = "(Optional) The URI used for requesting health status from the backend endpoint. Required if protocol is set to Http or Https. Otherwise, it is not allowed."
  default     = null
}

variable "lb_probe_interval_in_seconds" {
  description = "(Optional) The interval, in seconds between probes to the backend endpoint for health status. The default value is 15, the minimum value is 5."
  default     = null
}

variable "lb_probe_number_of_probes" {
  description = "(Optional) The number of failed probe attempts after which the backend endpoint is removed from rotation. The default value is 2. NumberOfProbes multiplied by intervalInSeconds value must be greater or equal to 10.Endpoints are returned to rotation when at least one probe is successful."
  default     = null
}

variable "lb_probe_timeouts" {
  description = "Set timeouts for lb probe"
  default     = {}
}

#-----------------------------------------------------------
# Azure lb outbound rule
#-----------------------------------------------------------
variable "enable_lb_outbound_rule" {
  description = "Enable lb outbound rule usage"
  default     = false
}

variable "lb_outbound_rule_name" {
  description = "Specifies the name of the Outbound Rule. Changing this forces a new resource to be created."
  default     = ""
}

variable "lb_outbound_rule_loadbalancer_id" {
  description = "The ID of the Load Balancer in which to create the Outbound Rule. Changing this forces a new resource to be created."
  default     = ""
}

variable "lb_outbound_rule_backend_address_pool_id" {
  description = "The ID of the Backend Address Pool. Outbound traffic is randomly load balanced across IPs in the backend IPs."
  default     = ""
}

variable "lb_outbound_rule_protocol" {
  description = "(Required) The transport protocol for the external endpoint. Possible values are Udp, Tcp or All"
  default     = null
}

variable "lb_outbound_rule_frontend_ip_configuration" {
  description = "(Required) One or more frontend_ip_configuration blocks"
  default     = []
}

variable "lb_outbound_rule_enable_tcp_reset" {
  description = "(Optional) Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination. This element is only used when the protocol is set to TCP."
  default     = null
}

variable "lb_outbound_rule_allocated_outbound_ports" {
  description = "(Optional) The number of outbound ports to be used for NAT. Defaults to 1024."
  default     = null
}

variable "lb_outbound_rule_idle_timeout_in_minutes" {
  description = "(Optional) The timeout for the TCP idle connection"
  default     = null
}

variable "lb_outbound_rule_timeouts" {
  description = "Set timeouts for lb outbound rule"
  default     = {}
}

#-----------------------------------------------------------
# Azure lb nat rule
#-----------------------------------------------------------
variable "enable_lb_nat_rule" {
  description = "Enable lb nat rule usage"
  default     = false
}

variable "lb_nat_rule_name" {
  description = "Specifies the name of the NAT Rule."
  default     = ""
}

variable "lb_nat_rule_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the resource."
  default     = null
}

variable "lb_nat_rule_loadbalancer_id" {
  description = "The ID of the Load Balancer in which to create the NAT Rule."
  default     = ""
}

variable "lb_nat_rule_frontend_ip_configuration_name" {
  description = "(Required) The name of the resource group in which to create the resource."
  default     = null
}

variable "lb_nat_rule_protocol" {
  description = "(Required) The transport protocol for the external endpoint. Possible values are Udp, Tcp or All."
  default     = null
}

variable "lb_nat_rule_frontend_port" {
  description = "(Required) The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive."
  default     = null
}

variable "lb_nat_rule_backend_port" {
  description = "(Required) The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive."
  default     = null
}

variable "lb_nat_rule_idle_timeout_in_minutes" {
  description = "(Optional) Specifies the idle timeout in minutes for TCP connections. Valid values are between 4 and 30 minutes. Defaults to 4 minutes."
  default     = null
}

variable "lb_nat_rule_enable_floating_ip" {
  description = "(Optional) Are the Floating IPs enabled for this Load Balancer Rule? A 'floating' IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false."
  default     = null
}

variable "lb_nat_rule_enable_tcp_reset" {
  description = "(Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false."
  default     = null
}

variable "lb_nat_rule_timeouts" {
  description = "Set timeouts for lb nat rule"
  default     = {}
}

#-----------------------------------------------------------
# Azure lb nat pool
#-----------------------------------------------------------
variable "enable_lb_nat_pool" {
  description = "Enable lb nat pool usage"
  default     = false
}

variable "lb_nat_pool_name" {
  description = "Specifies the name of the NAT pool."
  default     = ""
}

variable "lb_nat_pool_resource_group_name" {
  description = "Required) The name of the resource group in which to create the resource."
  default     = null
}

variable "lb_nat_pool_loadbalancer_id" {
  description = "The ID of the Load Balancer in which to create the NAT pool."
  default     = ""
}

variable "lb_nat_pool_frontend_ip_configuration_name" {
  description = "(Required) The name of the frontend IP configuration exposing this rule."
  default     = null
}

variable "lb_nat_pool_protocol" {
  description = "(Required) The transport protocol for the external endpoint. Possible values are Udp or Tcp"
  default     = null
}

variable "lb_nat_pool_frontend_port_start" {
  description = "(Required) The first port number in the range of external ports that will be used to provide Inbound NAT to NICs associated with this Load Balancer. Possible values range between 1 and 65534, inclusive."
  default     = null
}

variable "lb_nat_pool_frontend_port_end" {
  description = "(Required) The last port number in the range of external ports that will be used to provide Inbound NAT to NICs associated with this Load Balancer. Possible values range between 1 and 65534, inclusive."
  default     = null
}

variable "lb_nat_pool_backend_port" {
  description = "(Required) The port used for the internal endpoint. Possible values range between 1 and 65535, inclusive."
  default     = null
}

variable "lb_nat_pool_idle_timeout_in_minutes" {
  description = "(Optional) Specifies the idle timeout in minutes for TCP connections. Valid values are between 4 and 30. Defaults to 4."
  default     = null
}

variable "lb_nat_pool_floating_ip_enabled" {
  description = "(Optional) Are the floating IPs enabled for this Load Balancer Rule? A floating IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false."
  default     = null
}

variable "lb_nat_pool_tcp_reset_enabled" {
  description = "(Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false."
  default     = null
}

variable "lb_nat_pool_timeouts" {
  description = "Set timeouts for lb nat pool"
  default     = {}
}

#-----------------------------------------------------------
# Azure lb backend address pool
#-----------------------------------------------------------
variable "enable_lb_backend_address_pool" {
  description = "Enable lb backend address pool usage"
  default     = false
}

variable "lb_backend_address_pool_name" {
  description = "Specifies the name of the Backend Address Pool."
  default     = ""
}

variable "lb_backend_address_pool_loadbalancer_id" {
  description = "The ID of the Load Balancer in which to create the Backend Address Pool."
  default     = ""
}

variable "lb_backend_address_pool_tunnel_interface" {
  description = "(Optional) One or more tunnel_interface blocks"
  default     = []
}

variable "lb_nat_pool_timeouts" {
  description = "Set timeouts for lb nat pool"
  default     = {}
}

#-----------------------------------------------------------
# Azure lb backend address pool address
#-----------------------------------------------------------
variable "enable_lb_backend_address_pool_address" {
  description = "Enable lb backend address pool address usage"
  default     = false
}

variable "lb_backend_address_pool_address_name" {
  description = "The name which should be used for this Backend Address Pool Address. Changing this forces a new Backend Address Pool Address to be created."
  default     = ""
}

variable "lb_backend_address_pool_address_backend_address_pool_id" {
  description = "The ID of the Backend Address Pool. Changing this forces a new Backend Address Pool Address to be created."
  default     = ""
}

variable "lb_backend_address_pool_address_virtual_network_id" {
  description = "(Required) The ID of the Virtual Network within which the Backend Address Pool should exist."
  default     = null
}

variable "lb_backend_address_pool_address_ip_address" {
  description = "(Required) The Static IP Address which should be allocated to this Backend Address Pool."
  default     = null
}

variable "lb_backend_address_pool_address_timeouts" {
  description = "Set timeouts for lb backend address pool address"
  default     = {}
}