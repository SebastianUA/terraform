# Work with CORE_IMAGE via terraform

A terraform module for making CORE_IMAGE.


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

module "core_image" {
  source = "../../modules/core_image"

  enable_core_image               = true
  core_image_compartment_id       = ""
  core_image_display_name         = ""
  core_image_launch_mode          = null
  core_image_image_source_details = []

}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `compartment_id` - (Required) (Updatable) The OCID of the compartment to (`default = null`)
- `enable_core_image` - Enable core image usages (`default = False`)
- `core_image_display_name` - (Optional) (Updatable) A user-friendly name for the image. It does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = ""`)
- `core_image_launch_mode` - (Optional) Specifies the configuration mode for launching virtual machine (VM) instances. (`default = null`)
- `core_image_instance_id` - (Optional) The OCID of the instance you want to use as the basis for the image. (`default = null`)
- `core_image_image_source_details` - (Optional) - Set source details for image (`default = []`)
- `core_image_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_image_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 2 hours), when creating the Image * update - (Defaults to 2 hours), when updating the Image * delete - (Defaults to 2 hours), when destroying the Image (`default = {}`)
- `enable_core_shape_management` - Enable core shape management usages (`default = False`)
- `core_shape_management_image_id` - The OCID of the Image to which the shape should be added. (`default = ""`)
- `core_shape_management_shape_name` - (Required) The compatible shape that is to be added to the compatible shapes list for the image. (`default = null`)
- `enable_core_compute_image_capability_schema` - Enable core compute image capability schema usages (`default = False`)
- `core_compute_image_capability_schema_compute_global_image_capability_schema_version_name` - (Required) The name of the compute global image capability schema version (`default = null`)
- `core_compute_image_capability_schema_image_id` - The ocid of the image (`default = ""`)
- `core_compute_image_capability_schema_schema_data` - (Required) (Updatable) The map of each capability name to its ImageCapabilitySchemaDescriptor. (`default = {}`)
- `core_compute_image_capability_schema_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_compute_image_capability_schema_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `core_compute_image_capability_schema_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Compute Image Capability Schema * update - (Defaults to 20 minutes), when updating the Compute Image Capability Schema * delete - (Defaults to 20 minutes), when destroying the Compute Image Capability Schema (`default = {}`)
- `enable_core_app_catalog_subscription` - Enable core app catalog subscription usages (`default = False`)
- `core_app_catalog_subscription_listing_id` - (Required) The OCID of the listing. (`default = null`)
- `core_app_catalog_subscription_listing_resource_version` - (Required) Listing resource version. (`default = null`)
- `core_app_catalog_subscription_oracle_terms_of_use_link` - (Required) Oracle TOU link (`default = null`)
- `core_app_catalog_subscription_signature` - (Required) A generated signature for this listing resource version retrieved the agreements API. (`default = null`)
- `core_app_catalog_subscription_time_retrieved` - (Required) Date and time the agreements were retrieved, in RFC3339 format. Example: 2018-03-20T12:32:53.532Z (`default = null`)
- `core_app_catalog_subscription_eula_link` - (Optional) EULA link (`default = null`)
- `core_app_catalog_subscription_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the App Catalog Subscription * update - (Defaults to 20 minutes), when updating the App Catalog Subscription * delete - (Defaults to 20 minutes), when destroying the App Catalog Subscription (`default = {}`)
- `enable_core_app_catalog_listing_resource_version_agreement` - Enable core app catalog listing resource version agreement usages (`default = False`)
- `core_app_catalog_listing_resource_version_agreement_listing_id` - (Required) The OCID of the listing. (`default = null`)
- `core_app_catalog_listing_resource_version_agreement_listing_resource_version` - (Required) Listing Resource Version. (`default = null`)

## Module Output Variables
----------------------
- `core_image_listing_type` - The listing type of the image. The default value is 'NONE'.
- `core_image_operating_system` - The image's operating system. Example: Oracle Linux
- `core_image_operating_system_version` - The image's operating system version. Example: 7.2
- `core_image_size_in_mbs` - The boot volume size for an instance launched from this image (1 MB = 1,048,576 bytes). Note this is not the same as the size of the image when it was exported or the actual size of the image. Example: 47694
- `core_image_state` - The current state of the image.
- `core_image_id` - The OCID of the image.
- `core_image_launch_mode` - Specifies the configuration mode for launching virtual machine (VM) instances. 
- `core_image_display_name` - A user-friendly name for the image. It does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_image_base_image_id` - The OCID of the image originally used to launch the instance.
- `core_image_billable_size_in_gbs` - The size of the internal storage for this image that is subject to billing (1 GB = 1,073,741,824 bytes). Example: 100
- `core_image_compartment_id` - The OCID of the compartment containing the instance you want to use as the basis for the image.
- `core_image_create_image_allowed` - Whether instances launched with this image can be used to create new images. For example, you cannot create an image of an Oracle Database instance. Example: true
- `core_image_agent_features` - Oracle Cloud Agent features supported on the image.
- `core_image_launch_options` - Options for tuning the compatibility and performance of VM shapes. The values that you specify override any default values.
- `core_shape_management_id` - The image's Oracle ID (OCID).
- `core_shape_management_image_id` - The OCID of the image containing the shape.
- `core_shape_management_shape_name` - The compatible Shape for the image.
- `core_compute_image_capability_schema_compartment_id` - The OCID of the compartment containing the compute global image capability schema
- `core_compute_image_capability_schema_compute_global_image_capability_schema_id` - The ocid of the compute global image capability schema
- `core_compute_image_capability_schema_compute_global_image_capability_schema_version_name` - The name of the compute global image capability schema version
- `core_compute_image_capability_schema_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_compute_image_capability_schema_id` - The compute image capability schema OCID.
- `core_compute_image_capability_schema_image_id` - The OCID of the image associated with this compute image capability schema
- `core_compute_image_capability_schema_schema_data` - A mapping of each capability name to its ImageCapabilityDescriptor.
- `core_app_catalog_subscription_compartment_id` - The compartmentID of the subscription.
- `core_app_catalog_subscription_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_app_catalog_subscription_listing_id` - The ocid of the listing resource.
- `core_app_catalog_subscription_listing_resource_id` - Listing resource id.
- `core_app_catalog_subscription_listing_resource_version` - Listing resource version.
- `core_app_catalog_subscription_publisher_name` - Name of the publisher who published this listing.
- `core_app_catalog_subscription_summary` - The short summary to the listing.
- `core_app_catalog_subscription_time_created` - Date and time at which the subscription was created, in RFC3339 format. Example: 2018-03-20T12:32:53.532Z
- `core_app_catalog_listing_resource_version_agreement_eula_link` - EULA link
- `core_app_catalog_listing_resource_version_agreement_listing_id` - The OCID of the listing associated with these agreements.
- `core_app_catalog_listing_resource_version_agreement_listing_resource_version` - Listing resource version associated with these agreements.
- `core_app_catalog_listing_resource_version_agreement_oracle_terms_of_use_link` - Oracle TOU link
- `core_app_catalog_listing_resource_version_agreement_signature` - A generated signature for this agreement retrieval operation which should be used in the create subscription call.
- `core_app_catalog_listing_resource_version_agreement_time_retrieved` - Date and time the agreements were retrieved, in RFC3339 format. Example: 2018-03-20T12:32:53.532Z


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
