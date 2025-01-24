# Work with IDENTITY_GROUP via terraform

A terraform module for making IDENTITY_GROUP.


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

module "identity_group" {
  source = "../../modules/identity_group"

  enable_identity_group         = true
  identity_group_compartment_id = ""
  identity_group_description    = ""
  identity_group_name           = ""

  tags = {}
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_identity_dynamic_group` - Enable identity dynamic group usages (`default = False`)
- `identity_dynamic_group_compartment_id` - (Required) The OCID of the tenancy containing the group. (`default = null`)
- `identity_dynamic_group_description` - (Required) (Updatable) The description you assign to the group during creation. Does not have to be unique, and it's changeable. (`default = null`)
- `identity_dynamic_group_matching_rule` - (Required) (Updatable) The matching rule to dynamically match an instance certificate to this dynamic group. For rule syntax, see Managing Dynamic Groups. (`default = null`)
- `identity_dynamic_group_name` - The name you assign to the group during creation. The name must be unique across all groups in the tenancy and cannot be changed. (`default = ""`)
- `identity_dynamic_group_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `identity_dynamic_group_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Dynamic Group * update - (Defaults to 20 minutes), when updating the Dynamic Group * delete - (Defaults to 20 minutes), when destroying the Dynamic Group (`default = {}`)
- `enable_identity_group` - Enable identity group usages (`default = False`)
- `identity_group_compartment_id` - (Required) The OCID of the tenancy containing the group. (`default = null`)
- `identity_group_description` - (Required) (Updatable) The description you assign to the group during creation. Does not have to be unique, and it's changeable. (`default = null`)
- `identity_group_name` - The name you assign to the group during creation. The name must be unique across all groups in the tenancy and cannot be changed. (`default = ""`)
- `identity_group_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags.  (`default = {}`)
- `identity_group_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Group * update - (Defaults to 20 minutes), when updating the Group * delete - (Defaults to 20 minutes), when destroying the Group (`default = {}`)
- `enable_identity_user_group_membership` - Enable identity user group membership usages (`default = False`)
- `identity_user_group_membership_group_id` - The OCID of the group. (`default = ""`)
- `identity_user_group_membership_user_id` - (Required) The OCID of the user. (`default = null`)
- `identity_user_group_membership_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the User Group Membership * update - (Defaults to 20 minutes), when updating the User Group Membership * delete - (Defaults to 20 minutes), when destroying the User Group Membership (`default = {}`)
- `enable_identity_idp_group_mapping` - Enable identity idp group mapping usages (`default = False`)
- `identity_idp_group_mapping_group_id` - (Updatable) The OCID of the IAM Service group you want to map to the IdP group. (`default = ""`)
- `identity_idp_group_mapping_identity_provider_id` - (Required) The OCID of the identity provider. (`default = null`)
- `identity_idp_group_mapping_idp_group_name` - (Required) (Updatable) The name of the IdP group you want to map. (`default = null`)
- `identity_idp_group_mapping_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Idp Group Mapping * update - (Defaults to 20 minutes), when updating the Idp Group Mapping * delete - (Defaults to 20 minutes), when destroying the Idp Group Mapping (`default = {}`)
- `enable_identity_identity_provider` - Enable identity identity provider usages (`default = False`)
- `identity_identity_provider_compartment_id` - (Required) The OCID of your tenancy. (`default = null`)
- `identity_identity_provider_description` - (Required) (Updatable) The description you assign to the IdentityProvider during creation. Does not have to be unique, and it's changeable. (`default = null`)
- `identity_identity_provider_metadata` - (Required) (Updatable) The XML that contains the information required for federating. (`default = null`)
- `identity_identity_provider_metadata_url` - (Required) (Updatable) The URL for retrieving the identity provider's metadata, which contains information required for federating. (`default = null`)
- `identity_identity_provider_name` - (Required) The name you assign to the IdentityProvider during creation. The name must be unique across all IdentityProvider objects in the tenancy and cannot be changed. (`default = ""`)
- `identity_identity_provider_product_type` - (Required) The identity provider service or product. Supported identity providers are Oracle Identity Cloud Service (IDCS) and Microsoft Active Directory Federation Services (ADFS). Example: IDCS (`default = null`)
- `identity_identity_provider_protocol` - (Required) (Updatable) The protocol used for federation. Example: SAML2 (`default = null`)
- `identity_identity_provider_freeform_attributes` - (Optional) (Updatable) Extra name value pairs associated with this identity provider. (`default = null`)
- `identity_identity_provider_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `identity_identity_provider_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Identity Provider * update - (Defaults to 20 minutes), when updating the Identity Provider * delete - (Defaults to 20 minutes), when destroying the Identity Provider (`default = {}`)

## Module Output Variables
----------------------
- `identity_dynamic_group_compartment_id` - The OCID of the tenancy containing the group.
- `identity_dynamic_group_description` - The description you assign to the group. Does not have to be unique, and it's changeable.
- `identity_dynamic_group_id` - The OCID of the group.
- `identity_dynamic_group_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_dynamic_group_matching_rule` - A rule string that defines which instance certificates will be matched. For syntax, see Managing Dynamic Groups.
- `identity_dynamic_group_name` - The name you assign to the group during creation. The name must be unique across all groups in the tenancy and cannot be changed.
- `identity_dynamic_group_state` - The group's current state.
- `identity_group_compartment_id` - The OCID of the tenancy containing the group.
- `identity_group_description` - The description you assign to the group. Does not have to be unique, and it's changeable.
- `identity_group_id` - The OCID of the group.
- `identity_group_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_group_name` - The name you assign to the group during creation. The name must be unique across all groups in the tenancy and cannot be changed.
- `identity_group_state` - The group's current state.
- `identity_user_group_membership_compartment_id` - The OCID of the tenancy containing the user, group, and membership object.
- `identity_user_group_membership_group_id` - The OCID of the group.
- `identity_user_group_membership_id` - The OCID of the membership.
- `identity_user_group_membership_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_user_group_membership_state` - The membership's current state.
- `identity_user_group_membership_user_id` - The OCID of the user.
- `identity_idp_group_mapping_compartment_id` - The OCID of the tenancy containing the IdentityProvider.
- `identity_idp_group_mapping_group_id` - The OCID of the IAM Service group that is mapped to the IdP group.
- `identity_idp_group_mapping_id` - The OCID of the IdpGroupMapping.
- `identity_idp_group_mapping_identity_provider_id` - The OCID of the IdentityProvider this mapping belongs to.
- `identity_idp_group_mapping_idp_group_name` - The name of the IdP group that is mapped to the IAM Service group.
- `identity_idp_group_mapping_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_idp_group_mapping_state` - The mapping's current state.
- `identity_identity_provider_compartment_id` - The OCID of the tenancy containing the IdentityProvider.
- `identity_identity_provider_description` - The description you assign to the IdentityProvider during creation. Does not have to be unique, and it's changeable.
- `identity_identity_provider_freeform_attributes` - Extra name value pairs associated with this identity provider.
- `identity_identity_provider_id` -  The OCID of the IdentityProvider.
- `identity_identity_provider_inactive_state` - The detailed status of INACTIVE lifecycleState.
- `identity_identity_provider_metadata` - The XML that contains the information required for federating Identity with SAML2 Identity Provider.
- `identity_identity_provider_metadata_url` - The URL for retrieving the identity provider's metadata, which contains information required for federating.
- `identity_identity_provider_name` - The name you assign to the IdentityProvider during creation. The name must be unique across all IdentityProvider objects in the tenancy and cannot be changed. This is the name federated users see when choosing which identity provider to use when signing in to the Oracle Cloud Infrastructure Console.
- `identity_identity_provider_product_type` - The identity provider service or product. Supported identity providers are Oracle Identity Cloud Service (IDCS) and Microsoft Active Directory Federation Services (ADFS).
- `identity_identity_provider_protocol` - The protocol used for federation. Allowed value: SAML2. Example: SAML2
- `identity_identity_provider_redirect_url` - The URL to redirect federated users to for authentication with the identity provider.
- `identity_identity_provider_signing_certificate` - The identity provider's signing certificate used by the IAM Service to validate the SAML2 token.
- `identity_identity_provider_state` - The current state.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
