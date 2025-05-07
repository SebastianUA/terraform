#-----------------------------------------------------------
# identity dynamic group
#-----------------------------------------------------------
output "identity_dynamic_group_compartment_id" {
  description = "The OCID of the tenancy containing the group."
  value       = element(concat(oci_identity_dynamic_group.identity_dynamic_group.*.compartment_id, [""]), 0)
}

output "identity_dynamic_group_description" {
  description = "The description you assign to the group. Does not have to be unique, and it's changeable."
  value       = element(concat(oci_identity_dynamic_group.identity_dynamic_group.*.description, [""]), 0)
}

output "identity_dynamic_group_id" {
  description = "The OCID of the group."
  value       = element(concat(oci_identity_dynamic_group.identity_dynamic_group.*.id, [""]), 0)
}

output "identity_dynamic_group_inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_dynamic_group.identity_dynamic_group.*.inactive_state, [""]), 0)
}

output "identity_dynamic_group_matching_rule" {
  description = "A rule string that defines which instance certificates will be matched. For syntax, see Managing Dynamic Groups."
  value       = element(concat(oci_identity_dynamic_group.identity_dynamic_group.*.matching_rule, [""]), 0)
}

output "identity_dynamic_group_name" {
  description = "The name you assign to the group during creation. The name must be unique across all groups in the tenancy and cannot be changed."
  value       = element(concat(oci_identity_dynamic_group.identity_dynamic_group.*.name, [""]), 0)
}

output "identity_dynamic_group_state" {
  description = "The group's current state."
  value       = element(concat(oci_identity_dynamic_group.identity_dynamic_group.*.state, [""]), 0)
}

#-----------------------------------------------------------
# identity group
#-----------------------------------------------------------
output "identity_group_compartment_id" {
  description = "The OCID of the tenancy containing the group."
  value       = element(concat(oci_identity_group.identity_group.*.compartment_id, [""]), 0)
}

output "identity_group_description" {
  description = "The description you assign to the group. Does not have to be unique, and it's changeable."
  value       = element(concat(oci_identity_group.identity_group.*.description, [""]), 0)
}

output "identity_group_id" {
  description = "The OCID of the group."
  value       = element(concat(oci_identity_group.identity_group.*.id, [""]), 0)
}

output "identity_group_inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_group.identity_group.*.inactive_state, [""]), 0)
}

output "identity_group_name" {
  description = "The name you assign to the group during creation. The name must be unique across all groups in the tenancy and cannot be changed."
  value       = element(concat(oci_identity_group.identity_group.*.name, [""]), 0)
}

output "identity_group_state" {
  description = "The group's current state."
  value       = element(concat(oci_identity_group.identity_group.*.state, [""]), 0)
}

#-----------------------------------------------------------
# identity user group membership
#-----------------------------------------------------------
output "identity_user_group_membership_compartment_id" {
  description = "The OCID of the tenancy containing the user, group, and membership object."
  value       = element(concat(oci_identity_user_group_membership.identity_user_group_membership.*.compartment_id, [""]), 0)
}

output "identity_user_group_membership_group_id" {
  description = "The OCID of the group."
  value       = element(concat(oci_identity_user_group_membership.identity_user_group_membership.*.group_id, [""]), 0)
}

output "identity_user_group_membership_id" {
  description = "The OCID of the membership."
  value       = element(concat(oci_identity_user_group_membership.identity_user_group_membership.*.id, [""]), 0)
}

output "identity_user_group_membership_inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_user_group_membership.identity_user_group_membership.*.inactive_state, [""]), 0)
}

output "identity_user_group_membership_state" {
  description = "The membership's current state."
  value       = element(concat(oci_identity_user_group_membership.identity_user_group_membership.*.state, [""]), 0)
}

output "identity_user_group_membership_user_id" {
  description = "The OCID of the user."
  value       = element(concat(oci_identity_user_group_membership.identity_user_group_membership.*.user_id, [""]), 0)
}

#-----------------------------------------------------------
# identity idp group mapping
#-----------------------------------------------------------
output "identity_idp_group_mapping_compartment_id" {
  description = "The OCID of the tenancy containing the IdentityProvider."
  value       = element(concat(oci_identity_idp_group_mapping.identity_idp_group_mapping.*.compartment_id, [""]), 0)
}

output "identity_idp_group_mapping_group_id" {
  description = "The OCID of the IAM Service group that is mapped to the IdP group."
  value       = element(concat(oci_identity_idp_group_mapping.identity_idp_group_mapping.*.group_id, [""]), 0)
}

output "identity_idp_group_mapping_id" {
  description = "The OCID of the IdpGroupMapping."
  value       = element(concat(oci_identity_idp_group_mapping.identity_idp_group_mapping.*.id, [""]), 0)
}

output "identity_idp_group_mapping_identity_provider_id" {
  description = "The OCID of the IdentityProvider this mapping belongs to."
  value       = element(concat(oci_identity_idp_group_mapping.identity_idp_group_mapping.*.identity_provider_id, [""]), 0)
}

output "identity_idp_group_mapping_idp_group_name" {
  description = "The name of the IdP group that is mapped to the IAM Service group."
  value       = element(concat(oci_identity_idp_group_mapping.identity_idp_group_mapping.*.idp_group_name, [""]), 0)
}

output "identity_idp_group_mapping_inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_idp_group_mapping.identity_idp_group_mapping.*.inactive_state, [""]), 0)
}

output "identity_idp_group_mapping_state" {
  description = "The mapping's current state."
  value       = element(concat(oci_identity_idp_group_mapping.identity_idp_group_mapping.*.state, [""]), 0)
}

#-----------------------------------------------------------
# identity identity provider
#-----------------------------------------------------------
output "identity_identity_provider_compartment_id" {
  description = "The OCID of the tenancy containing the IdentityProvider."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.compartment_id, [""]), 0)
}

output "identity_identity_provider_description" {
  description = "The description you assign to the IdentityProvider during creation. Does not have to be unique, and it's changeable."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.description, [""]), 0)
}

output "identity_identity_provider_freeform_attributes" {
  description = "Extra name value pairs associated with this identity provider."
  value       = concat(oci_identity_identity_provider.identity_identity_provider.*.freeform_attributes, [""])
}

output "identity_identity_provider_id" {
  description = " The OCID of the IdentityProvider."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.id, [""]), 0)
}

output "identity_identity_provider_inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.inactive_state, [""]), 0)
}

output "identity_identity_provider_metadata" {
  description = "The XML that contains the information required for federating Identity with SAML2 Identity Provider."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.metadata, [""]), 0)
}

output "identity_identity_provider_metadata_url" {
  description = "The URL for retrieving the identity provider's metadata, which contains information required for federating."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.metadata_url, [""]), 0)
}

output "identity_identity_provider_name" {
  description = "The name you assign to the IdentityProvider during creation. The name must be unique across all IdentityProvider objects in the tenancy and cannot be changed. This is the name federated users see when choosing which identity provider to use when signing in to the Oracle Cloud Infrastructure Console."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.name, [""]), 0)
}

output "identity_identity_provider_product_type" {
  description = "The identity provider service or product. Supported identity providers are Oracle Identity Cloud Service (IDCS) and Microsoft Active Directory Federation Services (ADFS)."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.product_type, [""]), 0)
}

output "identity_identity_provider_protocol" {
  description = "The protocol used for federation. Allowed value: SAML2. Example: SAML2"
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.protocol, [""]), 0)
}

output "identity_identity_provider_redirect_url" {
  description = "The URL to redirect federated users to for authentication with the identity provider."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.redirect_url, [""]), 0)
}

output "identity_identity_provider_signing_certificate" {
  description = "The identity provider's signing certificate used by the IAM Service to validate the SAML2 token."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.signing_certificate, [""]), 0)
}

output "identity_identity_provider_state" {
  description = "The current state."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.state, [""]), 0)
}
