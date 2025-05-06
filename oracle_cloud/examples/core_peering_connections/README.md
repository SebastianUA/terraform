# Work with CORE_PEERING_CONNECTIONS via terraform

A terraform module for making CORE_PEERING_CONNECTIONS.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.21.0"
    }
  }
}

provider "oci" {
  # config_file = var.provider_oci_config_file
  # profile     = var.provider_oci_profile

  fingerprint      = var.provider_oci_fingerprint
  private_key_path = var.provider_oci_private_key_path
  region           = var.provider_oci_region
  tenancy_ocid     = var.provider_oci_tenancy_ocid
  user_ocid        = var.provider_oci_user_ocid
}

module "core_vcn" {
  source = "../../modules/core_peering_connections"

  # enable

}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `compartment_id` - (Required) The OCID of the compartment (`default = null`)
- `enable_core_cpe` - Enable core cpe usages (`default = False`)
- `core_cpe_ip_address` - (Required) The public IP address of the on-premises router. Example: 203.0.113.2 (`default = null`)
- `core_cpe_cpe_device_shape_id` - (Optional) (Updatable) The OCID of the CPE device type. You can provide a value if you want to later generate CPE device configuration content for IPSec connections that use this CPE. You can also call UpdateCpe later to provide a value. For a list of possible values, see ListCpeDeviceShapes. (`default = null`)
- `core_cpe_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_cpe_is_private` - (Optional) Indicates whether this CPE is of type private or not. (`default = null`)
- `core_cpe_defined_tags` - (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'} (`default = {}`)
- `core_cpe_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Cpe * update - (Defaults to 20 minutes), when updating the Cpe * delete - (Defaults to 20 minutes), when destroying the Cpe (`default = {}`)
- `enable_core_console_history` - Enable core console history usages (`default = False`)
- `core_console_history_instance_id` - (Required) The OCID of the instance to get the console history from. (`default = null`)
- `core_console_history_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_console_history_defined_tags` - (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'} (`default = {}`)
- `core_console_history_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Console History * update - (Defaults to 20 minutes), when updating the Console History * delete - (Defaults to 20 minutes), when destroying the Console History (`default = {}`)
- `enable_core_remote_peering_connection` - Enable core remote peering connection usages (`default = False`)
- `core_remote_peering_connection_drg_id` - (Required) The OCID of the DRG the RPC belongs to. (`default = null`)
- `core_remote_peering_connection_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_remote_peering_connection_peer_id` - (Optional) The OCID of the RPC you want to peer with. (`default = null`)
- `core_remote_peering_connection_peer_region_name` - (Optional) The name of the region that contains the RPC you want to peer with. Example: us-ashburn-1 (`default = null`)
- `core_remote_peering_connection_defined_tags` - (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'} (`default = {}`)
- `core_remote_peering_connection_timeouts` - The timeouts block allows you to specify timeouts for certain operations (`default = {}`)
- `enable_core_ipsec` - Enable core ipsec usages (`default = False`)
- `core_ipsec_cpe_id` - (Required) The OCID of the Cpe object. (`default = null`)
- `core_ipsec_drg_id` - (Required) The OCID of the DRG. (`default = null`)
- `core_ipsec_static_routes` - (Required) (Updatable) Static routes to the CPE. A static route's CIDR must not be a multicast address or class E address. (`default = null`)
- `core_ipsec_cpe_local_identifier` - (Optional) (Updatable) Your identifier for your CPE device. Can be either an IP address or a hostname (specifically, the fully qualified domain name (FQDN)). The type of identifier you provide here must correspond to the value for cpeLocalIdentifierType. (`default = null`)
- `core_ipsec_cpe_local_identifier_type` - (Optional) (Updatable) The type of identifier for your CPE device. The value you provide here must correspond to the value for cpeLocalIdentifier. (`default = null`)
- `core_ipsec_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_ipsec_tunnel_configuration` - (Optional) (Non-updatable) Tunnel configuration for private ipsec connection over fastconnect. (`default = []`)
- `core_ipsec_defined_tags` - (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'} (`default = {}`)
- `core_ipsec_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ip Sec Connection * update - (Defaults to 20 minutes), when updating the Ip Sec Connection * delete - (Defaults to 20 minutes), when destroying the Ip Sec Connection (`default = {}`)
- `enable_core_ipsec_connection_tunnel_management` - Enable core ipsec connection tunnel management usages (`default = False`)
- `core_ipsec_connection_tunnel_management_ipsec_id` - (Required) The OCID of the IPSec connection. (`default = ""`)
- `core_ipsec_connection_tunnel_management_tunnel_id` - (Required) The OCID of the IPSec connection's tunnel. (`default = null`)
- `core_ipsec_connection_tunnel_management_routing` - (Optional) The type of routing to use for this tunnel (either BGP dynamic routing, STATIC routing or POLICY routing). (`default = null`)
- `core_ipsec_connection_tunnel_management_bgp_session_info` - (Optional) Information for establishing a BGP session for the IPSec tunnel. Required if the tunnel uses BGP dynamic routing. (`default = []`)
- `core_ipsec_connection_tunnel_management_display_name` - (Optional) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_ipsec_connection_tunnel_management_encryption_domain_config` - (Optional) Configuration information used by the encryption domain policy. Required if the tunnel uses POLICY routing. (`default = []`)
- `core_ipsec_connection_tunnel_management_shared_secret` - (Optional) The shared secret (pre-shared key) to use for the IPSec tunnel. If you don't provide a value, Oracle generates a value for you. You can specify your own shared secret later if you like with UpdateIPSecConnectionTunnelSharedSecret. (`default = null`)
- `core_ipsec_connection_tunnel_management_ike_version` - (Optional) Internet Key Exchange protocol version. (`default = null`)
- `enable_core_cross_connect` - Eable core cross connect usages (`default = False`)
- `core_cross_connect_location_name` - (Required) The name of the FastConnect location where this cross-connect will be installed. To get a list of the available locations, see ListCrossConnectLocations. Example: CyrusOne, Chandler, AZ (`default = null`)
- `core_cross_connect_port_speed_shape_name` - (Required) The port speed for this cross-connect. To get a list of the available port speeds, see ListCrossConnectPortSpeedShapes. Example: 10 Gbps (`default = null`)
- `core_cross_connect_cross_connect_group_id` - (Optional) The OCID of the cross-connect group to put this cross-connect in. (`default = null`)
- `core_cross_connect_customer_reference_name` - (Optional) (Updatable) A reference name or identifier for the physical fiber connection that this cross-connect uses. (`default = null`)
- `core_cross_connect_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_cross_connect_far_cross_connect_or_cross_connect_group_id` - (Optional) If you already have an existing cross-connect or cross-connect group at this FastConnect location, and you want this new cross-connect to be on a different router (for the purposes of redundancy), provide the OCID of that existing cross-connect or cross-connect group. (`default = null`)
- `core_cross_connect_macsec_properties` - (Optional) (Updatable) Properties used to configure MACsec (if capable). (`default = []`)
- `core_cross_connect_near_cross_connect_or_cross_connect_group_id` - (Optional) If you already have an existing cross-connect or cross-connect group at this FastConnect location, and you want this new cross-connect to be on a different router (for the purposes of redundancy), provide the OCID of that existing cross-connect or cross-connect group. (`default = null`)
- `core_cross_connect_defined_tags` - (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'} (`default = {}`)
- `core_cross_connect_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Cross Connect * update - (Defaults to 20 minutes), when updating the Cross Connect * delete - (Defaults to 20 minutes), when destroying the Cross Connect (`default = {}`)
- `enable_core_cross_connect_group` - Enable core cross connect group usages (`default = False`)
- `core_cross_connect_group_customer_reference_name` - (Optional) (Updatable) A reference name or identifier for the physical fiber connection that this cross-connect group uses. (`default = null`)
- `core_cross_connect_group_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_cross_connect_group_macsec_properties` - (Optional) (Updatable) Properties used to configure MACsec (if capable). (`default = []`)
- `core_cross_connect_group_defined_tags` - (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'} (`default = {}`)
- `core_cross_connect_group_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Cross Connect Group * update - (Defaults to 20 minutes), when updating the Cross Connect Group * delete - (Defaults to 20 minutes), when destroying the Cross Connect Group (`default = {}`)

## Module Output Variables
----------------------
- `core_cpe_id` - The CPE's Oracle ID (OCID).
- `core_cpe_compartment_id` - The OCID of the compartment containing the CPE.
- `core_cpe_cpe_device_shape_id` - The OCID of the CPE's device type. The Networking service maintains a general list of CPE device types (for example, Cisco ASA). For each type, Oracle provides CPE configuration content that can help a network engineer configure the CPE. The OCID uniquely identifies the type of device. To get the OCIDs for the device types on the list, see ListCpeDeviceShapes.
- `core_cpe_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_cpe_ip_address` - ip_address
- `core_cpe_is_private` - Indicates whether this CPE is of type private or not.
- `core_cpe_time_created` - The date and time the CPE was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_console_history_id` - The OCID of the console history metadata object.
- `core_console_history_availability_domain` - The availability domain of an instance. Example: Uocm:PHX-AD-1
- `core_console_history_compartment_id` - The OCID of the compartment.
- `core_console_history_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_console_history_instance_id` - The OCID of the instance this console history was fetched from.
- `core_console_history_state` - The current state of the console history.
- `core_console_history_time_created` - The date and time the history was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_remote_peering_connection_id` - The OCID of the RPC.
- `core_remote_peering_connection_compartment_id` - The OCID of the compartment that contains the RPC.
- `core_remote_peering_connection_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_remote_peering_connection_drg_id` - The OCID of the DRG that this RPC belongs to.
- `core_remote_peering_connection_is_cross_tenancy_peering` - Whether the VCN at the other end of the peering is in a different tenancy. Example: false
- `core_remote_peering_connection_peer_id` - If this RPC is peered, this value is the OCID of the other RPC.
- `core_remote_peering_connection_peer_region_name` - If this RPC is peered, this value is the region that contains the other RPC. Example: us-ashburn-1
- `core_remote_peering_connection_peer_tenancy_id` - If this RPC is peered, this value is the OCID of the other RPC's tenancy.
- `core_remote_peering_connection_peering_status` - Whether the RPC is peered with another RPC. NEW means the RPC has not yet been peered. PENDING means the peering is being established. REVOKED means the RPC at the other end of the peering has been deleted.
- `core_remote_peering_connection_state` - The RPC's current lifecycle state.
- `core_remote_peering_connection_time_created` - The date and time the RPC was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_ipsec_id` - The IPSec connection's Oracle ID (OCID).
- `core_ipsec_compartment_id` - The OCID of the compartment containing the IPSec connection.
- `core_ipsec_cpe_id` - The OCID of the Cpe object.
- `core_ipsec_cpe_local_identifier` - Your identifier for your CPE device. Can be either an IP address or a hostname (specifically, the fully qualified domain name (FQDN)). The type of identifier here must correspond to the value for cpeLocalIdentifierType.
- `core_ipsec_cpe_local_identifier_type` - The type of identifier for your CPE device. The value here must correspond to the value for cpeLocalIdentifier.
- `core_ipsec_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_ipsec_drg_id` - The OCID of the DRG.
- `core_ipsec_state` - The IPSec connection's current state.
- `core_ipsec_static_routes` - Static routes to the CPE. The CIDR must not be a multicast address or class E address.
- `core_ipsec_tunnel_configuration` - Tunnel configuration for private ipsec connection over fastconnect.
- `core_ipsec_time_created` - The date and time the IPSec connection was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_ipsec_transport_type` - The transport type used for the IPSec connection.
- `core_ipsec_connection_tunnel_management_id` - The tunnel's Oracle ID (OCID).
- `core_ipsec_connection_tunnel_management_ipsec_id` - The OCID of the IPSec connection.
- `core_ipsec_connection_tunnel_management_tunnel_id` - The OCID of the IPSec connection's tunnel.
- `core_ipsec_connection_tunnel_management_routing` - The type of routing to use for this tunnel (either BGP dynamic routing, STATIC routing or POLICY routing).
- `core_ipsec_connection_tunnel_management_associated_virtual_circuits` - The list of virtual circuit OCIDs over which your network can reach this tunnel.
- `core_ipsec_connection_tunnel_management_bgp_session_info` - Information for establishing a BGP session for the IPSec tunnel.
- `core_ipsec_connection_tunnel_management_compartment_id` - The OCID of the compartment containing the tunnel.
- `core_ipsec_connection_tunnel_management_cpe_ip` - The IP address of the CPE device's VPN headend. Example: 203.0.113.22
- `core_ipsec_connection_tunnel_management_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_ipsec_connection_tunnel_management_encryption_domain_config` - Configuration information used by the encryption domain policy.
- `core_ipsec_connection_tunnel_management_routing` - the routing strategy used for this tunnel, either static route or BGP dynamic routing
- `core_ipsec_connection_tunnel_management_ike_version` - Internet Key Exchange protocol version.
- `core_ipsec_connection_tunnel_management_state` - The IPSec connection's tunnel's lifecycle state.
- `core_ipsec_connection_tunnel_management_status` - The tunnel's current state.
- `core_ipsec_connection_tunnel_management_time_created` - The date and time the IPSec connection tunnel was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_ipsec_connection_tunnel_management_time_status_updated` - When the status of the tunnel last changed, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_ipsec_connection_tunnel_management_vpn_ip` - The IP address of Oracle's VPN headend. Example: 129.146.17.50
- `core_ipsec_connection_tunnel_management_dpd_mode` - Dead peer detection (DPD) mode set on the Oracle side of the connection.
- `core_ipsec_connection_tunnel_management_dpd_timeout_in_sec` - DPD timeout in seconds.
- `core_ipsec_connection_tunnel_management_nat_translation_enabled` - By default (the AUTO setting), IKE sends packets with a source and destination port set to 500, and when it detects that the port used to forward packets has changed (most likely because a NAT device is between the CPE device and the Oracle VPN headend) it will try to negotiate the use of NAT-T.
- `core_ipsec_connection_tunnel_management_oracle_can_initiate` - Indicates whether Oracle can only respond to a request to start an IPSec tunnel from the CPE device, or both respond to and initiate requests.
- `core_ipsec_connection_tunnel_management_phase_one_details` - (Optional) IPSec tunnel details specific to ISAKMP phase one. See TunnelPhaseOneDetails.
- `core_ipsec_connection_tunnel_management_phase_two_details` - (IPsec tunnel detail information specific to phase two.
- `core_cross_connect_id` - The cross-connect's Oracle ID (OCID).
- `core_cross_connect_compartment_id` - The OCID of the compartment containing the cross-connect group.
- `core_cross_connect_cross_connect_group_id` - The OCID of the cross-connect group this cross-connect belongs to (if any).
- `core_cross_connect_customer_reference_name` - A reference name or identifier for the physical fiber connection that this cross-connect uses.
- `core_cross_connect_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_cross_connect_location_name` - The name of the FastConnect location where this cross-connect is installed.
- `core_cross_connect_macsec_properties` - macsec_properties
- `core_cross_connect_oci_logical_device_name` - The FastConnect device that terminates the logical connection. This device might be different than the device that terminates the physical connection.
- `core_cross_connect_oci_physical_device_name` - The FastConnect device that terminates the physical connection.
- `core_cross_connect_port_name` - A string identifying the meet-me room port for this cross-connect.
- `core_cross_connect_port_speed_shape_name` - The port speed for this cross-connect. Example: 10 Gbps
- `core_cross_connect_state` - The cross-connect's current state.
- `core_cross_connect_time_created` - The date and time the cross-connect was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_cross_connect_group_id` - The cross-connect group's Oracle ID (OCID).
- `core_cross_connect_group_compartment_id` - The OCID of the compartment containing the cross-connect group.
- `core_cross_connect_group_customer_reference_name` - A reference name or identifier for the physical fiber connection that this cross-connect group uses.
- `core_cross_connect_group_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_cross_connect_group_macsec_properties` - Properties used for MACsec (if capable)
- `core_cross_connect_group_oci_logical_device_name` - The FastConnect device that terminates the logical connection. This device might be different than the device that terminates the physical connection.
- `core_cross_connect_group_oci_physical_device_name` - The FastConnect device that terminates the physical connection.
- `core_cross_connect_group_state` - The cross-connect group's current state.
- `core_cross_connect_group_time_created` - The date and time the cross-connect group was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
