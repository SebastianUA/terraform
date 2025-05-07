#-----------------------------------------------------------
# core image
#-----------------------------------------------------------
output "core_image_listing_type" {
  description = "The listing type of the image. The default value is 'NONE'."
  value       = element(concat(oci_core_image.core_image.*.listing_type, [""]), 0)
}

output "core_image_operating_system" {
  description = "The image's operating system. Example: Oracle Linux"
  value       = element(concat(oci_core_image.core_image.*.operating_system, [""]), 0)
}

output "core_image_operating_system_version" {
  description = "The image's operating system version. Example: 7.2"
  value       = element(concat(oci_core_image.core_image.*.operating_system_version, [""]), 0)
}

output "core_image_size_in_mbs" {
  description = "The boot volume size for an instance launched from this image (1 MB = 1,048,576 bytes). Note this is not the same as the size of the image when it was exported or the actual size of the image. Example: 47694"
  value       = element(concat(oci_core_image.core_image.*.size_in_mbs, [""]), 0)
}

output "core_image_state" {
  description = "The current state of the image."
  value       = element(concat(oci_core_image.core_image.*.state, [""]), 0)
}

output "core_image_id" {
  description = "The OCID of the image."
  value       = element(concat(oci_core_image.core_image.*.id, [""]), 0)
}

output "core_image_launch_mode" {
  description = "Specifies the configuration mode for launching virtual machine (VM) instances. "
  value       = element(concat(oci_core_image.core_image.*.launch_mode, [""]), 0)
}

output "core_image_display_name" {
  description = "A user-friendly name for the image. It does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_image.core_image.*.display_name, [""]), 0)
}

output "core_image_base_image_id" {
  description = "The OCID of the image originally used to launch the instance."
  value       = element(concat(oci_core_image.core_image.*.image_id, [""]), 0)
}

output "core_image_billable_size_in_gbs" {
  description = "The size of the internal storage for this image that is subject to billing (1 GB = 1,073,741,824 bytes). Example: 100"
  value       = element(concat(oci_core_image.core_image.*.billable_size_in_gbs, [""]), 0)
}

output "core_image_compartment_id" {
  description = "The OCID of the compartment containing the instance you want to use as the basis for the image."
  value       = element(concat(oci_core_image.core_image.*.compartment_id, [""]), 0)
}

output "core_image_create_image_allowed" {
  description = "Whether instances launched with this image can be used to create new images. For example, you cannot create an image of an Oracle Database instance. Example: true"
  value       = element(concat(oci_core_image.core_image.*.create_image_allowed, [""]), 0)
}

output "core_image_agent_features" {
  description = "Oracle Cloud Agent features supported on the image."
  value       = concat(oci_core_image.core_image.*.agent_features, [""])
}

output "core_image_launch_options" {
  description = "Options for tuning the compatibility and performance of VM shapes. The values that you specify override any default values."
  value       = concat(oci_core_image.core_image.*.launch_options, [""])
}

#-----------------------------------------------------------
# core shape management
#-----------------------------------------------------------
output "core_shape_management_id" {
  description = "The image's Oracle ID (OCID)."
  value       = element(concat(oci_core_shape_management.core_shape_management.*.id, [""]), 0)
}

output "core_shape_management_image_id" {
  description = "The OCID of the image containing the shape."
  value       = element(concat(oci_core_shape_management.core_shape_management.*.image_id, [""]), 0)
}

output "core_shape_management_shape_name" {
  description = "The compatible Shape for the image."
  value       = element(concat(oci_core_shape_management.core_shape_management.*.shape_name, [""]), 0)
}

#-----------------------------------------------------------
# core compute image capability schema
#-----------------------------------------------------------
output "core_compute_image_capability_schema_compartment_id" {
  description = "The OCID of the compartment containing the compute global image capability schema"
  value       = element(concat(oci_core_compute_image_capability_schema.core_compute_image_capability_schema.*.compartment_id, [""]), 0)
}

output "core_compute_image_capability_schema_compute_global_image_capability_schema_id" {
  description = "The ocid of the compute global image capability schema"
  value       = element(concat(oci_core_compute_image_capability_schema.core_compute_image_capability_schema.*.compute_global_image_capability_schema_id, [""]), 0)
}

output "core_compute_image_capability_schema_compute_global_image_capability_schema_version_name" {
  description = "The name of the compute global image capability schema version"
  value       = element(concat(oci_core_compute_image_capability_schema.core_compute_image_capability_schema.*.compute_global_image_capability_schema_version_name, [""]), 0)
}

output "core_compute_image_capability_schema_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_compute_image_capability_schema.core_compute_image_capability_schema.*.display_name, [""]), 0)
}

output "core_compute_image_capability_schema_id" {
  description = "The compute image capability schema OCID."
  value       = element(concat(oci_core_compute_image_capability_schema.core_compute_image_capability_schema.*.id, [""]), 0)
}

output "core_compute_image_capability_schema_image_id" {
  description = "The OCID of the image associated with this compute image capability schema"
  value       = element(concat(oci_core_compute_image_capability_schema.core_compute_image_capability_schema.*.image_id, [""]), 0)
}

output "core_compute_image_capability_schema_schema_data" {
  description = "A mapping of each capability name to its ImageCapabilityDescriptor."
  value       = concat(oci_core_compute_image_capability_schema.core_compute_image_capability_schema.*.schema_data, [""])
}

#-----------------------------------------------------------
# core app catalog subscription
#-----------------------------------------------------------
output "core_app_catalog_subscription_compartment_id" {
  description = "The compartmentID of the subscription."
  value       = element(concat(oci_core_app_catalog_subscription.core_app_catalog_subscription.*.compartment_id, [""]), 0)
}

output "core_app_catalog_subscription_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_app_catalog_subscription.core_app_catalog_subscription.*.display_name, [""]), 0)
}

output "core_app_catalog_subscription_listing_id" {
  description = "The ocid of the listing resource."
  value       = element(concat(oci_core_app_catalog_subscription.core_app_catalog_subscription.*.listing_id, [""]), 0)
}

output "core_app_catalog_subscription_listing_resource_id" {
  description = "Listing resource id."
  value       = element(concat(oci_core_app_catalog_subscription.core_app_catalog_subscription.*.listing_resource_id, [""]), 0)
}

output "core_app_catalog_subscription_listing_resource_version" {
  description = "Listing resource version."
  value       = element(concat(oci_core_app_catalog_subscription.core_app_catalog_subscription.*.listing_resource_version, [""]), 0)
}

output "core_app_catalog_subscription_publisher_name" {
  description = "Name of the publisher who published this listing."
  value       = element(concat(oci_core_app_catalog_subscription.core_app_catalog_subscription.*.publisher_name, [""]), 0)
}

output "core_app_catalog_subscription_summary" {
  description = "The short summary to the listing."
  value       = concat(oci_core_app_catalog_subscription.core_app_catalog_subscription.*.summary, [""])
}

output "core_app_catalog_subscription_time_created" {
  description = "Date and time at which the subscription was created, in RFC3339 format. Example: 2018-03-20T12:32:53.532Z"
  value       = element(concat(oci_core_app_catalog_subscription.core_app_catalog_subscription.*.time_created, [""]), 0)
}

#-----------------------------------------------------------
# core app catalog listing resource version agreement
#-----------------------------------------------------------
output "core_app_catalog_listing_resource_version_agreement_eula_link" {
  description = "EULA link"
  value       = element(concat(oci_core_app_catalog_listing_resource_version_agreement.core_app_catalog_listing_resource_version_agreement.*.eula_link, [""]), 0)
}

output "core_app_catalog_listing_resource_version_agreement_listing_id" {
  description = "The OCID of the listing associated with these agreements."
  value       = element(concat(oci_core_app_catalog_listing_resource_version_agreement.core_app_catalog_listing_resource_version_agreement.*.listing_id, [""]), 0)
}

output "core_app_catalog_listing_resource_version_agreement_listing_resource_version" {
  description = "Listing resource version associated with these agreements."
  value       = element(concat(oci_core_app_catalog_listing_resource_version_agreement.core_app_catalog_listing_resource_version_agreement.*.listing_resource_version, [""]), 0)
}

output "core_app_catalog_listing_resource_version_agreement_oracle_terms_of_use_link" {
  description = "Oracle TOU link"
  value       = element(concat(oci_core_app_catalog_listing_resource_version_agreement.core_app_catalog_listing_resource_version_agreement.*.oracle_terms_of_use_link, [""]), 0)
}

output "core_app_catalog_listing_resource_version_agreement_signature" {
  description = "A generated signature for this agreement retrieval operation which should be used in the create subscription call."
  value       = element(concat(oci_core_app_catalog_listing_resource_version_agreement.core_app_catalog_listing_resource_version_agreement.*.signature, [""]), 0)
}

output "core_app_catalog_listing_resource_version_agreement_time_retrieved" {
  description = "Date and time the agreements were retrieved, in RFC3339 format. Example: 2018-03-20T12:32:53.532Z"
  value       = element(concat(oci_core_app_catalog_listing_resource_version_agreement.core_app_catalog_listing_resource_version_agreement.*.time_retrieved, [""]), 0)
}
