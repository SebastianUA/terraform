#-----------------------------------------------------------
# identity network source
#-----------------------------------------------------------
output "identity_network_source_compartment_id" {
  description = "The OCID of the tenancy containing the network source. The tenancy is the root compartment."
  value       = element(concat(oci_identity_network_source.identity_network_source.*.compartment_id, [""]), 0)
}

output "identity_network_source_description" {
  description = "The description you assign to the network source. Does not have to be unique, and it's changeable."
  value       = element(concat(oci_identity_network_source.identity_network_source.*.description, [""]), 0)
}


output "identity_network_source_id" {
  description = "The OCID of the network source."
  value       = element(concat(oci_identity_network_source.identity_network_source.*.id, [""]), 0)
}

output "identity_network_source_inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_network_source.identity_network_source.*.inactive_state, [""]), 0)
}

output "identity_network_source_name" {
  description = "The name you assign to the network source during creation. The name must be unique across the tenancy and cannot be changed."
  value       = element(concat(oci_identity_network_source.identity_network_source.*.name, [""]), 0)
}

output "identity_network_source_public_source_list" {
  description = "A list of allowed public IP addresses and CIDR ranges."
  value       = element(concat(oci_identity_network_source.identity_network_source.*.public_source_list, [""]), 0)
}

output "identity_network_source_services" {
  description = "A list of services allowed to make on-behalf-of requests. These requests can have different source IPs than those specified in the network source. Currently, only all and none are supported. The default is all."
  value       = element(concat(oci_identity_network_source.identity_network_source.*.services, [""]), 0)
}

output "identity_network_source_state" {
  description = "The network source object's current state. After creating a network source, make sure its lifecycleState changes from CREATING to ACTIVE before using it."
  value       = element(concat(oci_identity_network_source.identity_network_source.*.state, [""]), 0)
}

output "identity_network_source_time_created" {
  description = "Date and time the group was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_identity_network_source.identity_network_source.*.time_created, [""]), 0)
}

output "identity_network_source_virtual_source_list" {
  description = "A list of allowed VCN OCID and IP range pairs."
  value       = concat(oci_identity_network_source.identity_network_source.*.virtual_source_list, [""])
}

#-----------------------------------------------------------
# identity policy
#-----------------------------------------------------------
output "identity_policy_compartment_id" {
  description = "The OCID of the compartment containing the policy (either the tenancy or another compartment)."
  value       = element(concat(oci_identity_policy.identity_policy.*.compartment_id, [""]), 0)
}

output "identity_policy_description" {
  description = "The description you assign to the policy. Does not have to be unique, and it's changeable."
  value       = element(concat(oci_identity_policy.identity_policy.*.description, [""]), 0)
}

output "identity_policy_id" {
  description = "The OCID of the policy."
  value       = element(concat(oci_identity_policy.identity_policy.*.id, [""]), 0)
}

output "identity_policy_inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_policy.identity_policy.*.inactive_state, [""]), 0)
}

output "identity_policy_name" {
  description = "The name you assign to the policy during creation. The name must be unique across all policies in the tenancy and cannot be changed."
  value       = element(concat(oci_identity_policy.identity_policy.*.name, [""]), 0)
}

output "identity_policy_state" {
  description = "The policy's current state."
  value       = element(concat(oci_identity_policy.identity_policy.*.state, [""]), 0)
}

output "identity_policy_statements" {
  description = "An array of one or more policy statements written in the policy language."
  value       = concat(oci_identity_policy.identity_policy.*.statements, [""])
}

output "identity_policy_time_created" {
  description = "Date and time the policy was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_identity_policy.identity_policy.*.time_created, [""]), 0)
}

output "identity_policy_version_date" {
  description = "The version of the policy. If null or set to an empty string, when a request comes in for authorization, the policy will be evaluated according to the current behavior of the services at that moment. If set to a particular date (YYYY-MM-DD), the policy will be evaluated according to the behavior of the services on that date."
  value       = element(concat(oci_identity_policy.identity_policy.*.version_date, [""]), 0)
}

#-----------------------------------------------------------
# identity identity provider
#-----------------------------------------------------------
output "identity_identity_provider_id" {
  description = "The OCID of the IdentityProvider."
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.id, [""]), 0)
}

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
  value       = element(concat(oci_identity_identity_provider.identity_identity_provider.*.freeform_attributes, [""]), 0)
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

#-----------------------------------------------------------
# identity authentication policy
#-----------------------------------------------------------
output "identity_authentication_policy_compartment_id" {
  description = "Compartment OCID."
  value       = element(concat(oci_identity_authentication_policy.identity_authentication_policy.*.compartment_id, [""]), 0)
}

output "identity_authentication_policy_network_policy" {
  description = "Network policy, Consists of a list of Network Source ids."
  value       = concat(oci_identity_authentication_policy.identity_authentication_policy.*.network_policy, [""])
}

output "identity_authentication_policy_password_policy" {
  description = "Password policy, currently set for the given compartment"
  value       = concat(oci_identity_authentication_policy.identity_authentication_policy.*.password_policy, [""])
}

#-----------------------------------------------------------
# identity compartment
#-----------------------------------------------------------
output "identity_compartment_id" {
  description = "The OCID of the compartment."
  value       = element(concat(oci_identity_compartment.identity_compartment.*.id, [""]), 0)
}

output "identity_compartment_inactive_state" {
  description = "The detailed status of INACTIVE lifecycleState."
  value       = element(concat(oci_identity_compartment.identity_compartment.*.inactive_state, [""]), 0)
}

output "identity_compartment_is_accessible" {
  description = "Indicates whether or not the compartment is accessible for the user making the request. Returns true when the user has INSPECT permissions directly on a resource in the compartment or indirectly (permissions can be on a resource in a subcompartment)."
  value       = element(concat(oci_identity_compartment.identity_compartment.*.is_accessible, [""]), 0)
}

output "identity_compartment_name" {
  description = "The name you assign to the compartment during creation. The name must be unique across all compartments in the parent. Avoid entering confidential information."
  value       = element(concat(oci_identity_compartment.identity_compartment.*.name, [""]), 0)
}

output "identity_compartment_state" {
  description = "The compartment's current state."
  value       = element(concat(oci_identity_compartment.identity_compartment.*.state, [""]), 0)
}

output "identity_compartment_compartment_id" {
  description = "The OCID of the parent compartment containing the compartment."
  value       = element(concat(oci_identity_compartment.identity_compartment.*.compartment_id, [""]), 0)
}

output "identity_compartment_description" {
  description = "The description you assign to the compartment. Does not have to be unique, and it's changeable."
  value       = element(concat(oci_identity_compartment.identity_compartment.*.description, [""]), 0)
}
