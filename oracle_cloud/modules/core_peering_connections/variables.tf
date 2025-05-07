#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

variable "compartment_id" {
  description = "(Required) The OCID of the compartment"
  default     = null
}

#-----------------------------------------------------------
# core cpe
#-----------------------------------------------------------
variable "enable_core_cpe" {
  description = "Enable core cpe usages"
  default     = false
}

variable "core_cpe_ip_address" {
  description = "(Required) The public IP address of the on-premises router. Example: 203.0.113.2"
  default     = null
}

variable "core_cpe_cpe_device_shape_id" {
  description = "(Optional) (Updatable) The OCID of the CPE device type. You can provide a value if you want to later generate CPE device configuration content for IPSec connections that use this CPE. You can also call UpdateCpe later to provide a value. For a list of possible values, see ListCpeDeviceShapes."
  default     = null
}

variable "core_cpe_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_cpe_is_private" {
  description = "(Optional) Indicates whether this CPE is of type private or not."
  default     = null
}

variable "core_cpe_defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'}"
  default     = {}
}

variable "core_cpe_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Cpe * update - (Defaults to 20 minutes), when updating the Cpe * delete - (Defaults to 20 minutes), when destroying the Cpe"
  default     = {}
}

#-----------------------------------------------------------
# core console history
#-----------------------------------------------------------
variable "enable_core_console_history" {
  description = "Enable core console history usages"
  default     = false
}

variable "core_console_history_instance_id" {
  description = "(Required) The OCID of the instance to get the console history from."
  default     = null
}

variable "core_console_history_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_console_history_defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'}"
  default     = {}
}

variable "core_console_history_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Console History * update - (Defaults to 20 minutes), when updating the Console History * delete - (Defaults to 20 minutes), when destroying the Console History"
  default     = {}
}

#-----------------------------------------------------------
# core remote peering connection
#-----------------------------------------------------------
variable "enable_core_remote_peering_connection" {
  description = "Enable core remote peering connection usages"
  default     = false
}

variable "core_remote_peering_connection_drg_id" {
  description = "(Required) The OCID of the DRG the RPC belongs to."
  default     = null
}

variable "core_remote_peering_connection_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_remote_peering_connection_peer_id" {
  description = "(Optional) The OCID of the RPC you want to peer with."
  default     = null
}

variable "core_remote_peering_connection_peer_region_name" {
  description = "(Optional) The name of the region that contains the RPC you want to peer with. Example: us-ashburn-1"
  default     = null
}

variable "core_remote_peering_connection_defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'}"
  default     = {}
}

variable "core_remote_peering_connection_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations"
  default     = {}
}

#-----------------------------------------------------------
# core ipsec
#-----------------------------------------------------------
variable "enable_core_ipsec" {
  description = "Enable core ipsec usages"
  default     = false
}

variable "core_ipsec_cpe_id" {
  description = "(Required) The OCID of the Cpe object."
  default     = null
}

variable "core_ipsec_drg_id" {
  description = "(Required) The OCID of the DRG."
  default     = null
}

variable "core_ipsec_static_routes" {
  description = "(Required) (Updatable) Static routes to the CPE. A static route's CIDR must not be a multicast address or class E address."
  default     = null
}

variable "core_ipsec_cpe_local_identifier" {
  description = "(Optional) (Updatable) Your identifier for your CPE device. Can be either an IP address or a hostname (specifically, the fully qualified domain name (FQDN)). The type of identifier you provide here must correspond to the value for cpeLocalIdentifierType."
  default     = null
}

variable "core_ipsec_cpe_local_identifier_type" {
  description = "(Optional) (Updatable) The type of identifier for your CPE device. The value you provide here must correspond to the value for cpeLocalIdentifier."
  default     = null
}

variable "core_ipsec_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_ipsec_tunnel_configuration" {
  description = "(Optional) (Non-updatable) Tunnel configuration for private ipsec connection over fastconnect."
  default     = []
}

variable "core_ipsec_defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'}"
  default     = {}
}

variable "core_ipsec_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ip Sec Connection * update - (Defaults to 20 minutes), when updating the Ip Sec Connection * delete - (Defaults to 20 minutes), when destroying the Ip Sec Connection"
  default     = {}
}

#-----------------------------------------------------------
# core ipsec connection tunnel management
#-----------------------------------------------------------
variable "enable_core_ipsec_connection_tunnel_management" {
  description = "Enable core ipsec connection tunnel management usages"
  default     = false
}

variable "core_ipsec_connection_tunnel_management_ipsec_id" {
  description = "(Required) The OCID of the IPSec connection."
  default     = ""
}

variable "core_ipsec_connection_tunnel_management_tunnel_id" {
  description = "(Required) The OCID of the IPSec connection's tunnel."
  default     = null
}

variable "core_ipsec_connection_tunnel_management_routing" {
  description = "(Optional) The type of routing to use for this tunnel (either BGP dynamic routing, STATIC routing or POLICY routing)."
  default     = null
}

variable "core_ipsec_connection_tunnel_management_bgp_session_info" {
  description = "(Optional) Information for establishing a BGP session for the IPSec tunnel. Required if the tunnel uses BGP dynamic routing."
  default     = []
}

variable "core_ipsec_connection_tunnel_management_display_name" {
  description = "(Optional) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_ipsec_connection_tunnel_management_encryption_domain_config" {
  description = "(Optional) Configuration information used by the encryption domain policy. Required if the tunnel uses POLICY routing."
  default     = []
}

variable "core_ipsec_connection_tunnel_management_shared_secret" {
  description = "(Optional) The shared secret (pre-shared key) to use for the IPSec tunnel. If you don't provide a value, Oracle generates a value for you. You can specify your own shared secret later if you like with UpdateIPSecConnectionTunnelSharedSecret."
  default     = null
}

variable "core_ipsec_connection_tunnel_management_ike_version" {
  description = "(Optional) Internet Key Exchange protocol version."
  default     = null
}

#-----------------------------------------------------------
# core cross connect
#-----------------------------------------------------------
variable "enable_core_cross_connect" {
  description = "Eable core cross connect usages"
  default     = false
}

variable "core_cross_connect_location_name" {
  description = "(Required) The name of the FastConnect location where this cross-connect will be installed. To get a list of the available locations, see ListCrossConnectLocations. Example: CyrusOne, Chandler, AZ"
  default     = null
}

variable "core_cross_connect_port_speed_shape_name" {
  description = "(Required) The port speed for this cross-connect. To get a list of the available port speeds, see ListCrossConnectPortSpeedShapes. Example: 10 Gbps"
  default     = null
}

variable "core_cross_connect_cross_connect_group_id" {
  description = "(Optional) The OCID of the cross-connect group to put this cross-connect in."
  default     = null
}

variable "core_cross_connect_customer_reference_name" {
  description = "(Optional) (Updatable) A reference name or identifier for the physical fiber connection that this cross-connect uses."
  default     = null
}

variable "core_cross_connect_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_cross_connect_far_cross_connect_or_cross_connect_group_id" {
  description = "(Optional) If you already have an existing cross-connect or cross-connect group at this FastConnect location, and you want this new cross-connect to be on a different router (for the purposes of redundancy), provide the OCID of that existing cross-connect or cross-connect group."
  default     = null
}

variable "core_cross_connect_macsec_properties" {
  description = "(Optional) (Updatable) Properties used to configure MACsec (if capable)."
  default     = []
}

variable "core_cross_connect_near_cross_connect_or_cross_connect_group_id" {
  description = "(Optional) If you already have an existing cross-connect or cross-connect group at this FastConnect location, and you want this new cross-connect to be on a different router (for the purposes of redundancy), provide the OCID of that existing cross-connect or cross-connect group."
  default     = null
}

variable "core_cross_connect_defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'}"
  default     = {}
}

variable "core_cross_connect_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Cross Connect * update - (Defaults to 20 minutes), when updating the Cross Connect * delete - (Defaults to 20 minutes), when destroying the Cross Connect"
  default     = {}
}

#-----------------------------------------------------------
# core cross connect group
#-----------------------------------------------------------
variable "enable_core_cross_connect_group" {
  description = "Enable core cross connect group usages"
  default     = false
}

variable "core_cross_connect_group_customer_reference_name" {
  description = "(Optional) (Updatable) A reference name or identifier for the physical fiber connection that this cross-connect group uses."
  default     = null
}

variable "core_cross_connect_group_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_cross_connect_group_macsec_properties" {
  description = "(Optional) (Updatable) Properties used to configure MACsec (if capable)."
  default     = []
}

variable "core_cross_connect_group_defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'}"
  default     = {}
}

variable "core_cross_connect_group_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Cross Connect Group * update - (Defaults to 20 minutes), when updating the Cross Connect Group * delete - (Defaults to 20 minutes), when destroying the Cross Connect Group"
  default     = {}
}

#-----------------------------------------------------------
# core capture filter
#-----------------------------------------------------------
