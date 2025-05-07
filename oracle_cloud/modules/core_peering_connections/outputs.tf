#-----------------------------------------------------------
# core_cpe 
#-----------------------------------------------------------
output "core_cpe_id" {
  description = "The CPE's Oracle ID (OCID)."
  value       = element(concat(oci_core_cpe.core_cpe.*.id, [""]), 0)
}

output "core_cpe_compartment_id" {
  description = "The OCID of the compartment containing the CPE."
  value       = element(concat(oci_core_cpe.core_cpe.*.compartment_id, [""]), 0)
}

output "core_cpe_cpe_device_shape_id" {
  description = "The OCID of the CPE's device type. The Networking service maintains a general list of CPE device types (for example, Cisco ASA). For each type, Oracle provides CPE configuration content that can help a network engineer configure the CPE. The OCID uniquely identifies the type of device. To get the OCIDs for the device types on the list, see ListCpeDeviceShapes."
  value       = element(concat(oci_core_cpe.core_cpe.*.cpe_device_shape_id, [""]), 0)
}

output "core_cpe_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_cpe.core_cpe.*.display_name, [""]), 0)
}

output "core_cpe_ip_address" {
  description = "ip_address"
  value       = element(concat(oci_core_cpe.core_cpe.*.ip_address, [""]), 0)
}

output "core_cpe_is_private" {
  description = "Indicates whether this CPE is of type private or not."
  value       = element(concat(oci_core_cpe.core_cpe.*.is_private, [""]), 0)
}

output "core_cpe_time_created" {
  description = "The date and time the CPE was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_cpe.core_cpe.*.time_created, [""]), 0)
}

#-----------------------------------------------------------
# core console history
#-----------------------------------------------------------
output "core_console_history_id" {
  description = "The OCID of the console history metadata object."
  value       = element(concat(oci_core_console_history.core_console_history.*.id, [""]), 0)
}

output "core_console_history_availability_domain" {
  description = "The availability domain of an instance. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_console_history.core_console_history.*.availability_domain, [""]), 0)
}

output "core_console_history_compartment_id" {
  description = "The OCID of the compartment."
  value       = element(concat(oci_core_console_history.core_console_history.*.compartment_id, [""]), 0)
}

output "core_console_history_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_console_history.core_console_history.*.display_name, [""]), 0)
}

output "core_console_history_instance_id" {
  description = "The OCID of the instance this console history was fetched from."
  value       = element(concat(oci_core_console_history.core_console_history.*.instance_id, [""]), 0)
}

output "core_console_history_state" {
  description = "The current state of the console history."
  value       = element(concat(oci_core_console_history.core_console_history.*.state, [""]), 0)
}

output "core_console_history_time_created" {
  description = "The date and time the history was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_console_history.core_console_history.*.time_created, [""]), 0)
}

#-----------------------------------------------------------
# core console history
#-----------------------------------------------------------
output "core_remote_peering_connection_id" {
  description = "The OCID of the RPC."
  value       = element(concat(oci_core_remote_peering_connection.core_remote_peering_connection.*.id, [""]), 0)
}

output "core_remote_peering_connection_compartment_id" {
  description = "The OCID of the compartment that contains the RPC."
  value       = element(concat(oci_core_remote_peering_connection.core_remote_peering_connection.*.compartment_id, [""]), 0)
}

output "core_remote_peering_connection_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_remote_peering_connection.core_remote_peering_connection.*.display_name, [""]), 0)
}

output "core_remote_peering_connection_drg_id" {
  description = "The OCID of the DRG that this RPC belongs to."
  value       = element(concat(oci_core_remote_peering_connection.core_remote_peering_connection.*.drg_id, [""]), 0)
}

output "core_remote_peering_connection_is_cross_tenancy_peering" {
  description = "Whether the VCN at the other end of the peering is in a different tenancy. Example: false"
  value       = element(concat(oci_core_remote_peering_connection.core_remote_peering_connection.*.is_cross_tenancy_peering, [""]), 0)
}

output "core_remote_peering_connection_peer_id" {
  description = "If this RPC is peered, this value is the OCID of the other RPC."
  value       = element(concat(oci_core_remote_peering_connection.core_remote_peering_connection.*.peer_id, [""]), 0)
}

output "core_remote_peering_connection_peer_region_name" {
  description = "If this RPC is peered, this value is the region that contains the other RPC. Example: us-ashburn-1"
  value       = element(concat(oci_core_remote_peering_connection.core_remote_peering_connection.*.peer_region_name, [""]), 0)
}

output "core_remote_peering_connection_peer_tenancy_id" {
  description = "If this RPC is peered, this value is the OCID of the other RPC's tenancy."
  value       = element(concat(oci_core_remote_peering_connection.core_remote_peering_connection.*.peer_tenancy_id, [""]), 0)
}

output "core_remote_peering_connection_peering_status" {
  description = "Whether the RPC is peered with another RPC. NEW means the RPC has not yet been peered. PENDING means the peering is being established. REVOKED means the RPC at the other end of the peering has been deleted."
  value       = element(concat(oci_core_remote_peering_connection.core_remote_peering_connection.*.peering_status, [""]), 0)
}

output "core_remote_peering_connection_state" {
  description = "The RPC's current lifecycle state."
  value       = element(concat(oci_core_remote_peering_connection.core_remote_peering_connection.*.state, [""]), 0)
}

output "core_remote_peering_connection_time_created" {
  description = "The date and time the RPC was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_remote_peering_connection.core_remote_peering_connection.*.time_created, [""]), 0)
}

#-----------------------------------------------------------
# core ipsec
#-----------------------------------------------------------
output "core_ipsec_id" {
  description = "The IPSec connection's Oracle ID (OCID)."
  value       = element(concat(oci_core_ipsec.core_ipsec.*.id, [""]), 0)
}

output "core_ipsec_compartment_id" {
  description = "The OCID of the compartment containing the IPSec connection."
  value       = element(concat(oci_core_ipsec.core_ipsec.*.compartment_id, [""]), 0)
}

output "core_ipsec_cpe_id" {
  description = "The OCID of the Cpe object."
  value       = element(concat(oci_core_ipsec.core_ipsec.*.cpe_id, [""]), 0)
}

output "core_ipsec_cpe_local_identifier" {
  description = "Your identifier for your CPE device. Can be either an IP address or a hostname (specifically, the fully qualified domain name (FQDN)). The type of identifier here must correspond to the value for cpeLocalIdentifierType."
  value       = element(concat(oci_core_ipsec.core_ipsec.*.cpe_local_identifier, [""]), 0)
}

output "core_ipsec_cpe_local_identifier_type" {
  description = "The type of identifier for your CPE device. The value here must correspond to the value for cpeLocalIdentifier."
  value       = element(concat(oci_core_ipsec.core_ipsec.*.cpe_local_identifier_type, [""]), 0)
}

output "core_ipsec_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_ipsec.core_ipsec.*.display_name, [""]), 0)
}

output "core_ipsec_drg_id" {
  description = "The OCID of the DRG."
  value       = element(concat(oci_core_ipsec.core_ipsec.*.drg_id, [""]), 0)
}

output "core_ipsec_state" {
  description = "The IPSec connection's current state."
  value       = element(concat(oci_core_ipsec.core_ipsec.*.state, [""]), 0)
}


output "core_ipsec_static_routes" {
  description = "Static routes to the CPE. The CIDR must not be a multicast address or class E address."
  value       = element(concat(oci_core_ipsec.core_ipsec.*.static_routes, [""]), 0)
}

output "core_ipsec_tunnel_configuration" {
  description = "Tunnel configuration for private ipsec connection over fastconnect."
  value       = element(concat(oci_core_ipsec.core_ipsec.*.tunnel_configuration, [""]), 0)
}

output "core_ipsec_time_created" {
  description = "The date and time the IPSec connection was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_ipsec.core_ipsec.*.time_created, [""]), 0)
}


output "core_ipsec_transport_type" {
  description = "The transport type used for the IPSec connection."
  value       = element(concat(oci_core_ipsec.core_ipsec.*.transport_type, [""]), 0)
}

#-----------------------------------------------------------
# core ipsec connection tunnel management
#-----------------------------------------------------------
output "core_ipsec_connection_tunnel_management_id" {
  description = "The tunnel's Oracle ID (OCID)."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.id, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_ipsec_id" {
  description = "The OCID of the IPSec connection."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.ipsec_id, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_tunnel_id" {
  description = "The OCID of the IPSec connection's tunnel."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.tunnel_id, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_routing" {
  description = "The type of routing to use for this tunnel (either BGP dynamic routing, STATIC routing or POLICY routing)."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.routing, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_associated_virtual_circuits" {
  description = "The list of virtual circuit OCIDs over which your network can reach this tunnel."
  value       = concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.associated_virtual_circuits, [""])
}

output "core_ipsec_connection_tunnel_management_bgp_session_info" {
  description = "Information for establishing a BGP session for the IPSec tunnel."
  value       = concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.bgp_session_info, [""])
}

output "core_ipsec_connection_tunnel_management_compartment_id" {
  description = "The OCID of the compartment containing the tunnel."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.compartment_id, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_cpe_ip" {
  description = "The IP address of the CPE device's VPN headend. Example: 203.0.113.22"
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.cpe_ip, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.display_name, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_encryption_domain_config" {
  description = "Configuration information used by the encryption domain policy."
  value       = concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.encryption_domain_config, [""])
}

output "core_ipsec_connection_tunnel_management_routing" {
  description = "the routing strategy used for this tunnel, either static route or BGP dynamic routing"
  value       = concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.routing, [""])
}

output "core_ipsec_connection_tunnel_management_ike_version" {
  description = "Internet Key Exchange protocol version."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.ike_version, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_state" {
  description = "The IPSec connection's tunnel's lifecycle state."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.state, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_status" {
  description = "The tunnel's current state."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.status, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_time_created" {
  description = "The date and time the IPSec connection tunnel was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.time_created, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_time_status_updated" {
  description = "When the status of the tunnel last changed, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.time_status_updated, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_vpn_ip" {
  description = "The IP address of Oracle's VPN headend. Example: 129.146.17.50"
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.vpn_ip, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_dpd_mode" {
  description = "Dead peer detection (DPD) mode set on the Oracle side of the connection."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.dpd_mode, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_dpd_timeout_in_sec" {
  description = "DPD timeout in seconds."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.dpd_timeout_in_sec, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_nat_translation_enabled" {
  description = "By default (the AUTO setting), IKE sends packets with a source and destination port set to 500, and when it detects that the port used to forward packets has changed (most likely because a NAT device is between the CPE device and the Oracle VPN headend) it will try to negotiate the use of NAT-T."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.nat_translation_enabled, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_oracle_can_initiate" {
  description = "Indicates whether Oracle can only respond to a request to start an IPSec tunnel from the CPE device, or both respond to and initiate requests."
  value       = element(concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.oracle_can_initiate, [""]), 0)
}

output "core_ipsec_connection_tunnel_management_phase_one_details" {
  description = "(Optional) IPSec tunnel details specific to ISAKMP phase one. See TunnelPhaseOneDetails."
  value       = concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.phase_one_details, [""])
}

output "core_ipsec_connection_tunnel_management_phase_two_details" {
  description = "(IPsec tunnel detail information specific to phase two."
  value       = concat(oci_core_ipsec_connection_tunnel_management.core_ipsec_connection_tunnel_management.*.phase_two_details, [""])
}

#-----------------------------------------------------------
# core cross connect
#-----------------------------------------------------------
output "core_cross_connect_id" {
  description = "The cross-connect's Oracle ID (OCID)."
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.id, [""]), 0)
}

output "core_cross_connect_compartment_id" {
  description = "The OCID of the compartment containing the cross-connect group."
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.compartment_id, [""]), 0)
}

output "core_cross_connect_cross_connect_group_id" {
  description = "The OCID of the cross-connect group this cross-connect belongs to (if any)."
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.cross_connect_group_id, [""]), 0)
}

output "core_cross_connect_customer_reference_name" {
  description = "A reference name or identifier for the physical fiber connection that this cross-connect uses."
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.customer_reference_name, [""]), 0)
}

output "core_cross_connect_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.display_name, [""]), 0)
}

output "core_cross_connect_location_name" {
  description = "The name of the FastConnect location where this cross-connect is installed."
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.location_name, [""]), 0)
}

output "core_cross_connect_macsec_properties" {
  description = "macsec_properties"
  value       = concat(oci_core_cross_connect.core_cross_connect.*.macsec_properties, [""])
}

output "core_cross_connect_oci_logical_device_name" {
  description = "The FastConnect device that terminates the logical connection. This device might be different than the device that terminates the physical connection."
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.oci_logical_device_name, [""]), 0)
}

output "core_cross_connect_oci_physical_device_name" {
  description = "The FastConnect device that terminates the physical connection."
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.oci_physical_device_name, [""]), 0)
}

output "core_cross_connect_port_name" {
  description = "A string identifying the meet-me room port for this cross-connect."
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.port_name, [""]), 0)
}

output "core_cross_connect_port_speed_shape_name" {
  description = "The port speed for this cross-connect. Example: 10 Gbps"
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.port_speed_shape_name, [""]), 0)
}

output "core_cross_connect_state" {
  description = "The cross-connect's current state."
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.state, [""]), 0)
}

output "core_cross_connect_time_created" {
  description = "The date and time the cross-connect was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_cross_connect.core_cross_connect.*.time_created, [""]), 0)
}

#-----------------------------------------------------------
# core cross connect group
#-----------------------------------------------------------
output "core_cross_connect_group_id" {
  description = "The cross-connect group's Oracle ID (OCID)."
  value       = element(concat(oci_core_cross_connect_group.core_cross_connect_group.*.id, [""]), 0)
}

output "core_cross_connect_group_compartment_id" {
  description = "The OCID of the compartment containing the cross-connect group."
  value       = element(concat(oci_core_cross_connect_group.core_cross_connect_group.*.compartment_id, [""]), 0)
}

output "core_cross_connect_group_customer_reference_name" {
  description = "A reference name or identifier for the physical fiber connection that this cross-connect group uses."
  value       = element(concat(oci_core_cross_connect_group.core_cross_connect_group.*.customer_reference_name, [""]), 0)
}

output "core_cross_connect_group_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_cross_connect_group.core_cross_connect_group.*.display_name, [""]), 0)
}

output "core_cross_connect_group_macsec_properties" {
  description = "Properties used for MACsec (if capable)"
  value       = concat(oci_core_cross_connect_group.core_cross_connect_group.*.macsec_properties, [""])
}

output "core_cross_connect_group_oci_logical_device_name" {
  description = "The FastConnect device that terminates the logical connection. This device might be different than the device that terminates the physical connection."
  value       = element(concat(oci_core_cross_connect_group.core_cross_connect_group.*.oci_logical_device_name, [""]), 0)
}

output "core_cross_connect_group_oci_physical_device_name" {
  description = "The FastConnect device that terminates the physical connection."
  value       = element(concat(oci_core_cross_connect_group.core_cross_connect_group.*.oci_physical_device_name, [""]), 0)
}

output "core_cross_connect_group_state" {
  description = "The cross-connect group's current state."
  value       = element(concat(oci_core_cross_connect_group.core_cross_connect_group.*.state, [""]), 0)
}

output "core_cross_connect_group_time_created" {
  description = "The date and time the cross-connect group was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_cross_connect_group.core_cross_connect_group.*.time_created, [""]), 0)
}

#-----------------------------------------------------------
# core capture filter
#-----------------------------------------------------------
