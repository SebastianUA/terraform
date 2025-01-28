# Work with IDENTITY via terraform

A terraform module for making IDENTITY.


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

module "identity" {
  source = "../../modules/identity"

}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `compartment_id` - (Required) (Updatable) The OCID of the compartment to (`default = null`)
- `tags` - Add additional tags (`default = {}`)
- `enable_identity_network_source` - Enable identity network source usages (`default = False`)
- `identity_network_source_description` - (Required) (Updatable) The description you assign to the network source during creation. Does not have to be unique, and it's changeable. (`default = null`)
- `identity_network_source_name` - (Required) The name you assign to the network source during creation. The name must be unique across all groups in the tenancy and cannot be changed. (`default = ""`)
- `identity_network_source_public_source_list` - (Optional) (Updatable) A list of allowed public IP addresses and CIDR ranges. (`default = null`)
- `identity_network_source_services` - (Optional) (Updatable) A list of services allowed to make on-behalf-of requests. These requests can have different source IP addresses than those listed in the network source. Currently, only all and none are supported. The default is all. (`default = null`)
- `identity_network_source_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `identity_network_source_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Source * update - (Defaults to 20 minutes), when updating the Network Source * delete - (Defaults to 20 minutes), when destroying the Network Source (`default = {}`)
- `enable_identity_policy` - Enable identity policy usages (`default = False`)
- `identity_policy_description` - (Required) (Updatable) The description you assign to the policy during creation. Does not have to be unique, and it's changeable. (`default = null`)
- `identity_policy_name` - The name you assign to the policy during creation. The name must be unique across all policies in the tenancy and cannot be changed. (`default = ""`)
- `identity_policy_statements` - (Required) (Updatable) An array of policy statements written in the policy language. See How Policies Work and Common Policies. (`default = null`)
- `identity_policy_version_date` - (Optional) (Updatable) The version of the policy. If null or set to an empty string, when a request comes in for authorization, the policy will be evaluated according to the current behavior of the services at that moment. If set to a particular date (YYYY-MM-DD), the policy will be evaluated according to the behavior of the services on that date. (`default = null`)
- `identity_policy_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `identity_policy_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Policy * update - (Defaults to 20 minutes), when updating the Policy * delete - (Defaults to 20 minutes), when destroying the Policy (`default = {}`)
- `enable_identity_identity_provider` - Enable identity identity provider usages (`default = False`)
- `identity_identity_provider_description` - (Required) (Updatable) The description you assign to the IdentityProvider during creation. Does not have to be unique, and it's changeable. (`default = null`)
- `identity_identity_provider_metadata` - (Required) (Updatable) The XML that contains the information required for federating. (`default = null`)
- `identity_identity_provider_metadata_url` - (Required) (Updatable) The URL for retrieving the identity provider's metadata, which contains information required for federating. (`default = null`)
- `identity_identity_provider_name` - The name you assign to the IdentityProvider during creation. The name must be unique across all IdentityProvider objects in the tenancy and cannot be changed. (`default = ""`)
- `identity_identity_provider_product_type` - (Required) The identity provider service or product. Supported identity providers are Oracle Identity Cloud Service (IDCS) and Microsoft Active Directory Federation Services (ADFS). Example: IDCS (`default = null`)
- `identity_identity_provider_protocol` - (Required) (Updatable) The protocol used for federation. Example: SAML2 (`default = null`)
- `identity_identity_provider_freeform_attributes` - (Optional) (Updatable) Extra name value pairs associated with this identity provider. (`default = null`)
- `identity_identity_provider_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = null`)
- `identity_identity_provider_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Identity Provider * update - (Defaults to 20 minutes), when updating the Identity Provider * delete - (Defaults to 20 minutes), when destroying the Identity Provider (`default = {}`)
- `enable_identity_authentication_policy` - Enable identity authentication policy usage (`default = False`)
- `identity_authentication_policy_network_policy` - (Optional) (Updatable) Network policy, Consists of a list of Network Source ids. (`default = {}`)
- `identity_authentication_policy_password_policy` - (Optional) (Updatable) Password policy, currently set for the given compartment. (`default = {}`)
- `identity_authentication_policy_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Authentication Policy * update - (Defaults to 20 minutes), when updating the Authentication Policy * delete - (Defaults to 20 minutes), when destroying the Authentication Policy (`default = {}`)
- `enable_identity_compartment` - Enable identity compartment usages (`default = False`)
- `identity_compartment_description` - (Required) (Updatable) The description you assign to the compartment during creation. Does not have to be unique, and it's changeable. (`default = null`)
- `identity_compartment_name` - (Updatable) The name you assign to the compartment during creation. The name must be unique across all compartments in the parent compartment. Avoid entering confidential information. (`default = ""`)
- `identity_compartment_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `identity_compartment_enable_delete` - (Optional) Defaults to false. If omitted or set to false the provider will implicitly import the compartment if there is a name collision, and will not actually delete the compartment on destroy or removal of the resource declaration. If set to true, the provider will throw an error on a name collision with another compartment, and will attempt to delete the compartment on destroy or removal of the resource declaration. (`default = null`)

## Module Output Variables
----------------------
- `identity_network_source_compartment_id` - The OCID of the tenancy containing the network source. The tenancy is the root compartment.
- `identity_network_source_description` - The description you assign to the network source. Does not have to be unique, and it's changeable.
- `identity_network_source_id` - The OCID of the network source.
- `identity_network_source_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_network_source_name` - The name you assign to the network source during creation. The name must be unique across the tenancy and cannot be changed.
- `identity_network_source_public_source_list` - A list of allowed public IP addresses and CIDR ranges.
- `identity_network_source_services` - A list of services allowed to make on-behalf-of requests. These requests can have different source IPs than those specified in the network source. Currently, only all and none are supported. The default is all.
- `identity_network_source_state` - The network source object's current state. After creating a network source, make sure its lifecycleState changes from CREATING to ACTIVE before using it.
- `identity_network_source_time_created` - Date and time the group was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `identity_network_source_virtual_source_list` - A list of allowed VCN OCID and IP range pairs.
- `identity_policy_compartment_id` - The OCID of the compartment containing the policy (either the tenancy or another compartment).
- `identity_policy_description` - The description you assign to the policy. Does not have to be unique, and it's changeable.
- `identity_policy_id` - The OCID of the policy.
- `identity_policy_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_policy_name` - The name you assign to the policy during creation. The name must be unique across all policies in the tenancy and cannot be changed.
- `identity_policy_state` - The policy's current state.
- `identity_policy_statements` - An array of one or more policy statements written in the policy language.
- `identity_policy_time_created` - Date and time the policy was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `identity_policy_version_date` - The version of the policy. If null or set to an empty string, when a request comes in for authorization, the policy will be evaluated according to the current behavior of the services at that moment. If set to a particular date (YYYY-MM-DD), the policy will be evaluated according to the behavior of the services on that date.
- `identity_identity_provider_id` - The OCID of the IdentityProvider.
- `identity_identity_provider_compartment_id` - The OCID of the tenancy containing the IdentityProvider.
- `identity_identity_provider_description` - The description you assign to the IdentityProvider during creation. Does not have to be unique, and it's changeable.
- `identity_identity_provider_freeform_attributes` - Extra name value pairs associated with this identity provider.
- `identity_identity_provider_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_identity_provider_metadata` - The XML that contains the information required for federating Identity with SAML2 Identity Provider.
- `identity_identity_provider_metadata_url` - The URL for retrieving the identity provider's metadata, which contains information required for federating.
- `identity_identity_provider_name` - The name you assign to the IdentityProvider during creation. The name must be unique across all IdentityProvider objects in the tenancy and cannot be changed. This is the name federated users see when choosing which identity provider to use when signing in to the Oracle Cloud Infrastructure Console.
- `identity_identity_provider_product_type` - The identity provider service or product. Supported identity providers are Oracle Identity Cloud Service (IDCS) and Microsoft Active Directory Federation Services (ADFS).
- `identity_identity_provider_protocol` - The protocol used for federation. Allowed value: SAML2. Example: SAML2
- `identity_identity_provider_redirect_url` - The URL to redirect federated users to for authentication with the identity provider.
- `identity_identity_provider_signing_certificate` - The identity provider's signing certificate used by the IAM Service to validate the SAML2 token.
- `identity_identity_provider_state` - The current state.
- `identity_authentication_policy_compartment_id` - Compartment OCID.
- `identity_authentication_policy_network_policy` - Network policy, Consists of a list of Network Source ids.
- `identity_authentication_policy_password_policy` - Password policy, currently set for the given compartment
- `identity_compartment_id` - The OCID of the compartment.
- `identity_compartment_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_compartment_is_accessible` - Indicates whether or not the compartment is accessible for the user making the request. Returns true when the user has INSPECT permissions directly on a resource in the compartment or indirectly (permissions can be on a resource in a subcompartment).
- `identity_compartment_name` - The name you assign to the compartment during creation. The name must be unique across all compartments in the parent. Avoid entering confidential information.
- `identity_compartment_state` - The compartment's current state.
- `identity_compartment_compartment_id` - The OCID of the parent compartment containing the compartment.
- `identity_compartment_description` - The description you assign to the compartment. Does not have to be unique, and it's changeable.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
