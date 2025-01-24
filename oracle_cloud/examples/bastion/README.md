# Work with BASTION via terraform

A terraform module for making BASTION.


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

module "bastion" {
  source = "../../modules/bastion"

  enable_bastion           = true
  bastion_bastion_type     = "standard"
  bastion_compartment_id   = "ocid1.compartment.oc1..exampleuniqueID"
  bastion_target_subnet_id = "ocid1.subnet.oc1.phx.exampleuniqueID"

  bastion_name = "ibastion-1"
  tags         = {}
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_bastion` - Enable bastion usage (`default = False`)
- `bastion_bastion_type` - (Required) The type of bastion. Use standard (`default = null`)
- `bastion_compartment_id` - (Required) (Updatable) The unique identifier (OCID) of the compartment where the bastion is located. (`default = null`)
- `bastion_target_subnet_id` - (Required) The unique identifier (OCID) of the subnet that the bastion connects to. (`default = null`)
- `bastion_name` - (Optional) The name of the bastion, which can't be changed after creation. (`default = ""`)
- `bastion_client_cidr_block_allow_list` - (Optional) (Updatable) A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion. (`default = null`)
- `bastion_dns_proxy_status` - (Optional) Flag to enable FQDN and SOCKS5 Proxy Support. Example: ENABLED, DISABLED (`default = null`)
- `bastion_max_session_ttl_in_seconds` - (Optional) (Updatable) The maximum amount of time that any session on the bastion can remain active. (`default = null`)
- `bastion_phone_book_entry` - (Optional) The phonebook entry of the customer's team, which can't be changed after creation. Not applicable to standard bastions. (`default = null`)
- `bastion_static_jump_host_ip_addresses` - (Optional) (Updatable) A list of IP addresses of the hosts that the bastion has access to. Not applicable to standard bastions. (`default = null`)
- `bastion_freeform_tags` - (Optional) (Updatable) Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only. Example: {'bar-key': 'value'} (`default = null`)
- `bastion_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Bastion * update - (Defaults to 20 minutes), when updating the Bastion * delete - (Defaults to 20 minutes), when destroying the Bastion (`default = {}`)
- `enable_session` - Enable session usages (`default = False`)
- `session_bastion_id` - The unique identifier (OCID) of the bastion that is hosting this session. (`default = ""`)
- `session_key_details` - Public key details for a bastion session. (`default = {}`)
- `session_target_resource_details` - Details about a bastion session's target resource. (`default = {}`)
- `session_display_name` - (Optional) (Updatable) The name of the session. (`default = ""`)
- `session_key_type` - (Optional) The type of the key used to connect to the session. PUB is a standard public key in OpenSSH format. (`default = null`)
- `session_session_ttl_in_seconds` - (Optional) The amount of time the session can remain active. (`default = null`)
- `session_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Session * update - (Defaults to 20 minutes), when updating the Session * delete - (Defaults to 20 minutes), when destroying the Session (`default = {}`)

## Module Output Variables
----------------------
- `bastion_id` - The unique identifier (OCID) of the bastion, which can't be changed after creation.
- `bastion_bastion_type` - The type of bastion.
- `bastion_compartment_id` - The unique identifier (OCID) of the compartment where the bastion is located.
- `bastion_dns_proxy_status` - Flag to enable FQDN and SOCKS5 Proxy Support. Example: ENABLED, DISABLED
- `bastion_max_session_ttl_in_seconds` - The maximum amount of time that any session on the bastion can remain active.
- `bastion_max_sessions_allowed` - The maximum number of active sessions allowed on the bastion.
- `bastion_name` - The name of the bastion, which can't be changed after creation.
- `bastion_phone_book_entry` - The phonebook entry of the customer's team, which can't be changed after creation. Not applicable to standard bastions.
- `bastion_private_endpoint_ip_address` - The private IP address of the created private endpoint.
- `bastion_state` - The current state of the bastion.
- `bastion_static_jump_host_ip_addresses` - A list of IP addresses of the hosts that the bastion has access to. Not applicable to standard bastions.
- `bastion_target_subnet_id` - The unique identifier (OCID) of the subnet that the bastion connects to.
- `bastion_target_vcn_id` - The unique identifier (OCID) of the virtual cloud network (VCN) that the bastion connects to.
- `session_id` - The unique identifier (OCID) of the session, which can't be changed after creation.
- `session_display_name` - The name of the session.
- `session_bastion_user_name` - The username that the session uses to connect to the target resource.
- `session_bastion_public_host_key_info` - The public key of the bastion host. You can use this to verify that you're connecting to the correct bastion.
- `session_bastion_name` - The name of the bastion that is hosting this session.
- `session_bastion_id` - The unique identifier (OCID) of the bastion that is hosting this session.
- `session_key_type` - The type of the key used to connect to the session. PUB is a standard public key in OpenSSH format.
- `session_lifecycle_details` - A message describing the current session state in more detail.
- `session_session_ttl_in_seconds` - The amount of time the session can remain active.
- `session_ssh_metadata` - The connection message for the session.
- `session_state` - The current state of the session.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
