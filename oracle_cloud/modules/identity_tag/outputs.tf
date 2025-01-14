#-----------------------------------------------------------
# identity tag
#-----------------------------------------------------------
output "identity_tag_id" {
  description = "The OCID of the tag definition."
  value       = element(concat(oci_identity_tag.identity_tag.*.id, [""]), 0)
}

output "identity_tag_description" {
  description = "The description you assign to the tag."
  value       = element(concat(oci_identity_tag.identity_tag.*.description, [""]), 0)
}

output "identity_tag_is_cost_tracking" {
  description = "Indicates whether the tag is enabled for cost tracking."
  value       = element(concat(oci_identity_tag.identity_tag.*.is_cost_tracking, [""]), 0)
}

output "identity_tag_is_retired" {
  description = "Indicates whether the tag is retired. See Retiring Key Definitions and Namespace Definitions."
  value       = element(concat(oci_identity_tag.identity_tag.*.is_retired, [""]), 0)
}

output "identity_tag_name" {
  description = "The name assigned to the tag during creation. This is the tag key definition. The name must be unique within the tag namespace and cannot be changed."
  value       = element(concat(oci_identity_tag.identity_tag.*.name, [""]), 0)
}

output "identity_tag_state" {
  description = "The tag's current state. After creating a tag, make sure its lifecycleState is ACTIVE before using it. After retiring a tag, make sure its lifecycleState is INACTIVE before using it. If you delete a tag, you cannot delete another tag until the deleted tag's lifecycleState changes from DELETING to DELETED."
  value       = element(concat(oci_identity_tag.identity_tag.*.state, [""]), 0)
}

output "identity_tag_tag_namespace_id" {
  description = "The OCID of the namespace that contains the tag definition."
  value       = element(concat(oci_identity_tag.identity_tag.*.tag_namespace_id, [""]), 0)
}

output "identity_tag_validator" {
  description = "Validates a definedTag value. Each validator performs validation steps in addition to the standard validation for definedTag values. For more information, see Limits on Tags."
  value       = element(concat(oci_identity_tag.identity_tag.*.validator, [""]), 0)
}

#-----------------------------------------------------------
# identity tag namespace
#-----------------------------------------------------------
output "identity_tag_namespace_compartment_id" {
  description = "The OCID of the compartment that contains the tag namespace."
  value       = element(concat(oci_identity_tag_namespace.identity_tag_namespace.*.compartment_id, [""]), 0)
}

output "identity_tag_namespace_description" {
  description = "The description you assign to the tag namespace."
  value       = element(concat(oci_identity_tag_namespace.identity_tag_namespace.*.description, [""]), 0)
}

output "identity_tag_namespace_id" {
  description = "The OCID of the tag namespace."
  value       = element(concat(oci_identity_tag_namespace.identity_tag_namespace.*.id, [""]), 0)
}

output "identity_tag_namespace_is_retired" {
  description = "Whether the tag namespace is retired. For more information, see Retiring Key Definitions and Namespace Definitions."
  value       = element(concat(oci_identity_tag_namespace.identity_tag_namespace.*.is_retired, [""]), 0)
}

output "identity_tag_namespace_name" {
  description = "The name of the tag namespace. It must be unique across all tag namespaces in the tenancy and cannot be changed."
  value       = element(concat(oci_identity_tag_namespace.identity_tag_namespace.*.name, [""]), 0)
}

output "identity_tag_namespace_state" {
  description = "The tagnamespace's current state. After creating a tagnamespace, make sure its lifecycleState is ACTIVE before using it. After retiring a tagnamespace, make sure its lifecycleState is INACTIVE before using it."
  value       = element(concat(oci_identity_tag_namespace.identity_tag_namespace.*.id, [""]), 0)
}

#-----------------------------------------------------------
# identity tag default
#-----------------------------------------------------------
output "identity_tag_default_id" {
  description = "The OCID of the tag default."
  value       = element(concat(oci_identity_tag_default.identity_tag_default.*.id, [""]), 0)
}

output "identity_tag_default_is_required" {
  description = "If you specify that a value is required, a value is set during resource creation (either by the user creating the resource or another tag defualt). If no value is set, resource creation is blocked."
  value       = element(concat(oci_identity_tag_default.identity_tag_default.*.is_required, [""]), 0)
}

output "identity_tag_default_state" {
  description = "The tag default's current state. After creating a TagDefault, make sure its lifecycleState is ACTIVE before using it."
  value       = element(concat(oci_identity_tag_default.identity_tag_default.*.state, [""]), 0)
}

output "identity_tag_default_tag_definition_id" {
  description = "The OCID of the tag definition. The tag default will always assign a default value for this tag definition."
  value       = element(concat(oci_identity_tag_default.identity_tag_default.*.tag_definition_id, [""]), 0)
}

output "identity_tag_default_tag_definition_name" {
  description = "The name used in the tag definition. This field is informational in the context of the tag default."
  value       = element(concat(oci_identity_tag_default.identity_tag_default.*.tag_definition_name, [""]), 0)
}

output "identity_tag_default_tag_namespace_id" {
  description = "The OCID of the tag namespace that contains the tag definition."
  value       = element(concat(oci_identity_tag_default.identity_tag_default.*.tag_namespace_id, [""]), 0)
}
output "identity_tag_default_time_created" {
  description = "Date and time the TagDefault object was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_identity_tag_default.identity_tag_default.*.time_created, [""]), 0)
}

output "identity_tag_default_value" {
  description = "The default value for the tag definition. This will be applied to all new resources created in the compartment."
  value       = element(concat(oci_identity_tag_default.identity_tag_default.*.value, [""]), 0)
}

output "identity_tag_default_compartment_id" {
  description = "The OCID of the compartment. The tag default applies to all new resources that get created in the compartment. Resources that existed before the tag default was created are not tagged."
  value       = element(concat(oci_identity_tag_default.identity_tag_default.*.compartment_id, [""]), 0)
}
