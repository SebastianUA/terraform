# Work with IDENTITY_TAG via terraform

A terraform module for making IDENTITY_TAG.


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

module "identity_tag" {
  source = "../../modules/identity_tag"

  enable_identity_tag_namespace         = true
  identity_tag_namespace_compartment_id = ""
  identity_tag_namespace_name           = ""
  identity_tag_namespace_description    = ""

  enable_identity_tag           = true
  identity_tag_name             = ""
  identity_tag_description      = ""
  identity_tag_tag_namespace_id = ""

  tags = {}

}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_identity_tag` - Enable identity tag usages (`default = False`)
- `identity_tag_name` - The name you assign to the tag during creation. This is the tag key definition. The name must be unique within the tag namespace and cannot be changed. (`default = ""`)
- `identity_tag_description` - (Required) (Updatable) The description you assign to the tag during creation. (`default = null`)
- `identity_tag_tag_namespace_id` - (Required) The OCID of the tag namespace. (`default = ""`)
- `identity_tag_is_cost_tracking` - (Optional) (Updatable) Indicates whether the tag is enabled for cost tracking. (`default = null`)
- `identity_tag_is_retired` - (Optional) (Updatable) Indicates whether the tag is retired. See Retiring Key Definitions and Namespace Definitions. (`default = null`)
- `identity_tag_validator` - (Optional) (Updatable) Validates a definedTag value. Each validator performs validation steps in addition to the standard validation for definedTag values. For more information, see Limits on Tags. (`default = []`)
- `identity_tag_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `identity_tag_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 15 minutes), when creating the Tag * update - (Defaults to 15 minutes), when updating the Tag * delete - (Defaults to 12 hours), when destroying the Tag (`default = {}`)
- `enable_identity_tag_namespace` - Enable identity tag namespace usages (`default = False`)
- `identity_tag_namespace_compartment_id` - (Required) (Updatable) The OCID of the tenancy containing the tag namespace. (`default = null`)
- `identity_tag_namespace_name` - The name you assign to the tag namespace during creation. It must be unique across all tag namespaces in the tenancy and cannot be changed. (`default = ""`)
- `identity_tag_namespace_description` - (Required) (Updatable) The description you assign to the tag namespace during creation. (`default = ""`)
- `identity_tag_namespace_is_retired` - (Optional) (Updatable) Whether the tag namespace is retired. For more information, see Retiring Key Definitions and Namespace Definitions. (`default = null`)
- `identity_tag_namespace_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `identity_tag_namespace_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Tag Namespace * update - (Defaults to 20 minutes), when updating the Tag Namespace * delete - (Defaults to 20 minutes), when destroying the Tag Namespace (`default = {}`)
- `enable_identity_tag_default` - Enable identity tag default usages (`default = False`)
- `identity_tag_default_compartment_id` - (Required) The OCID of the compartment. The tag default will be applied to all new resources created in this compartment. (`default = null`)
- `identity_tag_default_tag_definition_id` - Required) The OCID of the tag definition. The tag default will always assign a default value for this tag definition. (`default = null`)
- `identity_tag_default_value` - (Required) (Updatable) The default value for the tag definition. This will be applied to all new resources created in the compartment. (`default = null`)
- `identity_tag_default_is_required` - (Optional) (Updatable) If you specify that a value is required, a value is set during resource creation (either by the user creating the resource or another tag defualt). If no value is set, resource creation is blocked. (`default = null`)
- `identity_tag_default_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Tag Default * update - (Defaults to 20 minutes), when updating the Tag Default * delete - (Defaults to 20 minutes), when destroying the Tag Default (`default = {}`)
- `enable_identity_import_standard_tags_management` - Enable identity import standard tags management usages (`default = False`)
- `identity_import_standard_tags_management_compartment_id` - (Required) The OCID of the compartment where the bulk create request is submitted and where the tag namespaces will be created. (`default = null`)
- `identity_import_standard_tags_management_standard_tag_namespace_name` - The name of standard tag namespace that will be imported in bulk (`default = ""`)
- `identity_import_standard_tags_management_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Import Standard Tags Management * update - (Defaults to 20 minutes), when updating the Import Standard Tags Management * delete - (Defaults to 20 minutes), when destroying the Import Standard Tags Management (`default = {}`)

## Module Output Variables
----------------------
- `identity_tag_id` - The OCID of the tag definition.
- `identity_tag_description` - The description you assign to the tag.
- `identity_tag_is_cost_tracking` - Indicates whether the tag is enabled for cost tracking.
- `identity_tag_is_retired` - Indicates whether the tag is retired. See Retiring Key Definitions and Namespace Definitions.
- `identity_tag_name` - The name assigned to the tag during creation. This is the tag key definition. The name must be unique within the tag namespace and cannot be changed.
- `identity_tag_state` - The tag's current state. After creating a tag, make sure its lifecycleState is ACTIVE before using it. After retiring a tag, make sure its lifecycleState is INACTIVE before using it. If you delete a tag, you cannot delete another tag until the deleted tag's lifecycleState changes from DELETING to DELETED.
- `identity_tag_tag_namespace_id` - The OCID of the namespace that contains the tag definition.
- `identity_tag_validator` - Validates a definedTag value. Each validator performs validation steps in addition to the standard validation for definedTag values. For more information, see Limits on Tags.
- `identity_tag_namespace_compartment_id` - The OCID of the compartment that contains the tag namespace.
- `identity_tag_namespace_description` - The description you assign to the tag namespace.
- `identity_tag_namespace_id` - The OCID of the tag namespace.
- `identity_tag_namespace_is_retired` - Whether the tag namespace is retired. For more information, see Retiring Key Definitions and Namespace Definitions.
- `identity_tag_namespace_name` - The name of the tag namespace. It must be unique across all tag namespaces in the tenancy and cannot be changed.
- `identity_tag_namespace_state` - The tagnamespace's current state. After creating a tagnamespace, make sure its lifecycleState is ACTIVE before using it. After retiring a tagnamespace, make sure its lifecycleState is INACTIVE before using it.
- `identity_tag_default_id` - The OCID of the tag default.
- `identity_tag_default_is_required` - If you specify that a value is required, a value is set during resource creation (either by the user creating the resource or another tag defualt). If no value is set, resource creation is blocked.
- `identity_tag_default_state` - The tag default's current state. After creating a TagDefault, make sure its lifecycleState is ACTIVE before using it.
- `identity_tag_default_tag_definition_id` - The OCID of the tag definition. The tag default will always assign a default value for this tag definition.
- `identity_tag_default_tag_definition_name` - The name used in the tag definition. This field is informational in the context of the tag default.
- `identity_tag_default_tag_namespace_id` - The OCID of the tag namespace that contains the tag definition.
- `identity_tag_default_time_created` - Date and time the TagDefault object was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `identity_tag_default_value` - The default value for the tag definition. This will be applied to all new resources created in the compartment.
- `identity_tag_default_compartment_id` - The OCID of the compartment. The tag default applies to all new resources that get created in the compartment. Resources that existed before the tag default was created are not tagged.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
