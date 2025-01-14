# Work with FUNCTIONS via terraform

A terraform module for making FUNCTIONS.


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
  fingerprint      = var.provider_oci_fingerprint
  private_key_path = var.provider_oci_private_key_path
  region           = var.provider_oci_region
  tenancy_ocid     = var.provider_oci_tenancy_ocid
  user_ocid        = var.provider_oci_user_ocid
  alias            = var.provider_oci_alias
}

module "functions" {
  source = "../../modules/functions"

  enable_functions_application         = true
  functions_application_compartment_id = ""
  functions_application_display_name   = ""
  functions_application_subnet_ids     = []

  enable_functions_function = true
  # functions_function_application_id = ""
  functions_function_display_name  = ""
  functions_function_memory_in_mbs = 128

  functions_function_image        = null
  functions_function_image_digest = null

  tags = {}
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_functions_function` - Enable functions function usages (`default = False`)
- `functions_function_application_id` - The OCID of the application this function belongs to. (`default = ""`)
- `functions_function_display_name` - The display name of the function. The display name must be unique within the application containing the function. Avoid entering confidential information. (`default = ""`)
- `functions_function_memory_in_mbs` - (Required) (Updatable) Maximum usable memory for the function (MiB). (`default = null`)
- `functions_function_config` - (Optional) (Updatable) Function configuration. These values are passed on to the function as environment variables, this overrides application configuration values. Keys must be ASCII strings consisting solely of letters, digits, and the '_' (underscore) character, and must not begin with a digit. Values should be limited to printable unicode characters. Example: {'MY_FUNCTION_CONFIG': 'ConfVal'} (`default = null`)
- `functions_function_image` - (Optional) (Updatable) The qualified name of the Docker image to use in the function, including the image tag. The image should be in the Oracle Cloud Infrastructure Registry that is in the same region as the function itself. This field must be updated if image_digest is updated. Example: phx.ocir.io/ten/functions/function:0.0.1 (`default = null`)
- `functions_function_image_digest` - (Optional) (Updatable) The image digest for the version of the image that will be pulled when invoking this function. If no value is specified, the digest currently associated with the image in the Oracle Cloud Infrastructure Registry will be used. This field must be updated if image is updated. Example: sha256:ca0eeb6fb05351dfc8759c20733c91def84cb8007aa89a5bf606bc8b315b9fc7 (`default = null`)
- `functions_function_timeout_in_seconds` - (Optional) (Updatable) Timeout for executions of the function. Value in seconds. (`default = null`)
- `functions_function_provisioned_concurrency_config` - (Optional) (Updatable) Define the strategy for provisioned concurrency for the function. (`default = {}`)
- `functions_function_source_details` - (Optional) The source details for the Function. The function can be created from various sources. (`default = []`)
- `functions_function_trace_config` - (Optional) (Updatable) Define the tracing configuration for a function. (`default = {}`)
- `functions_function_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `functions_function_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Function * update - (Defaults to 20 minutes), when updating the Function * delete - (Defaults to 20 minutes), when destroying the Function (`default = {}`)
- `enable_functions_application` - Enable functions application usages (`default = False`)
- `functions_application_compartment_id` - (Required) (Updatable) The OCID of the compartment to create the application within. (`default = null`)
- `functions_application_display_name` - The display name of the application. The display name must be unique within the compartment containing the application. Avoid entering confidential information. (`default = ""`)
- `functions_application_subnet_ids` - (Required) The OCIDs of the subnets in which to run functions in the application. (`default = null`)
- `functions_application_config` - (Optional) (Updatable) Application configuration. These values are passed on to the function as environment variables, functions may override application configuration. Keys must be ASCII strings consisting solely of letters, digits, and the '_' (underscore) character, and must not begin with a digit. Values should be limited to printable unicode characters. Example: {'MY_FUNCTION_CONFIG': 'ConfVal'} (`default = {}`)
- `functions_application_network_security_group_ids` - (Optional) (Updatable) The OCIDs of the Network Security Groups to add the application to. (`default = null`)
- `functions_application_shape` - (Optional) Valid values are GENERIC_X86, GENERIC_ARM and GENERIC_X86_ARM. Default is GENERIC_X86. Setting this to GENERIC_X86, will run the functions in the application on X86 processor architecture. Setting this to GENERIC_ARM, will run the functions in the application on ARM processor architecture. When set to GENERIC_X86_ARM, functions in the application are run on either X86 or ARM processor architecture. Accepted values are: GENERIC_X86, GENERIC_ARM, GENERIC_X86_ARM (`default = null`)
- `functions_application_syslog_url` - (Optional) (Updatable) A syslog URL to which to send all function logs. Supports tcp, udp, and tcp+tls. The syslog URL must be reachable from all of the subnets configured for the application. Note: If you enable the Oracle Cloud Infrastructure Logging service for this application, the syslogUrl value is ignored. Function logs are sent to the Oracle Cloud Infrastructure Logging service, and not to the syslog URL. Example: tcp://logserver.myserver:1234 (`default = null`)
- `functions_application_image_policy_config` - (Optional) (Updatable) Define the image signature verification policy for an application. (`default = {}`)
- `functions_application_trace_config` - (Optional) (Updatable) Define the tracing configuration for an application. (`default = {}`)
- `functions_application_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `functions_application_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Application * update - (Defaults to 20 minutes), when updating the Application * delete - (Defaults to 20 minutes), when destroying the Application (`default = {}`)
- `enable_functions_invoke_function` - Enable functions invoke function usages (`default = False`)
- `functions_invoke_function_function_id` - The OCID of this function. (`default = ""`)
- `functions_invoke_function_invoke_function_body` - (Optional) The body of the function invocation. Note: The maximum size of the request is limited. This limit is currently 6MB and the endpoint will not accept requests that are bigger than this limit. Cannot be defined if input_body_source_path or invoke_function_body_base64_encoded is defined. (`default = null`)
- `functions_invoke_function_fn_intent` - (Optional) An optional intent header that indicates to the FDK the way the event should be interpreted. E.g. 'httprequest', 'cloudevent'. (`default = null`)
- `functions_invoke_function_fn_invoke_type` - (Optional) Indicates whether Oracle Functions should execute the request and return the result ('sync') of the execution, or whether Oracle Functions should return as soon as processing has begun ('detached') and leave result handling to the function. (`default = null`)
- `functions_invoke_function_base64_encode_content` - (Optional) The Base64 encoded body of the function invocation. Base64 encoded input avoids corruption in Terraform state. Cannot be defined if invoke_function_body or input_body_source_path is defined. Note: The maximum size of the request is limited. This limit is currently 6MB and the endpoint will not accept requests that are bigger than this limit. (`default = null`)
- `functions_invoke_function_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Invoke Function * update - (Defaults to 20 minutes), when updating the Invoke Function * delete - (Defaults to 20 minutes), when destroying the Invoke Function (`default = {}`)

## Module Output Variables
----------------------
- `functions_function_id` - The OCID of the function.
- `functions_function_image` - The qualified name of the Docker image to use in the function, including the image tag. The image should be in the Oracle Cloud Infrastructure Registry that is in the same region as the function itself. This field must be updated if image_digest is updated. Example: phx.ocir.io/ten/functions/function:0.0.1
- `functions_function_image_digest` - The image digest for the version of the image that will be pulled when invoking this function. If no value is specified, the digest currently associated with the image in the Oracle Cloud Infrastructure Registry will be used. This field must be updated if image is updated. Example: sha256:ca0eeb6fb05351dfc8759c20733c91def84cb8007aa89a5bf606bc8b315b9fc7
- `functions_function_invoke_endpoint` - The base https invoke URL to set on a client in order to invoke a function. This URL will never change over the lifetime of the function and can be cached.
- `functions_function_memory_in_mbs` - Maximum usable memory for the function (MiB).
- `functions_function_provisioned_concurrency_config` - Define the strategy for provisioned concurrency for the function.
- `functions_function_application_id` - The OCID of the application the function belongs to.
- `functions_function_compartment_id` - The OCID of the compartment that contains the function.
- `functions_function_config` - Function configuration. Overrides application configuration. Keys must be ASCII strings consisting solely of letters, digits, and the '_' (underscore) character, and must not begin with a digit. Values should be limited to printable unicode characters. 
- `functions_function_display_name` - The display name of the function. The display name is unique within the application containing the function.
- `functions_function_shape` - The processor shape (GENERIC_X86/GENERIC_ARM) on which to run functions in the application, extracted from the image manifest.
- `functions_function_source_details` - The source details for the Function. The function can be created from various sources.
- `functions_function_state` - The current state of the function.
- `functions_application_id` - The OCID of the application.
- `functions_application_network_security_group_ids` - The OCIDs of the Network Security Groups to add the application to.
- `functions_application_image_policy_config` - Define the image signature verification policy for an application.
- `functions_application_display_name` - The display name of the application. The display name is unique within the compartment containing the application.
- `functions_application_shape` - Valid values are GENERIC_X86, GENERIC_ARM and GENERIC_X86_ARM. Default is GENERIC_X86. Setting this to GENERIC_X86, will run the functions in the application on X86 processor architecture. Setting this to GENERIC_ARM, will run the functions in the application on ARM processor architecture. When set to GENERIC_X86_ARM, functions in the application are run on either X86 or ARM processor architecture. Accepted values are: GENERIC_X86, GENERIC_ARM, GENERIC_X86_ARM
- `functions_application_state` - The current state of the application.
- `functions_application_subnet_ids` - The OCIDs of the subnets in which to run functions in the application.
- `functions_application_syslog_url` - A syslog URL to which to send all function logs. Supports tcp, udp, and tcp+tls. The syslog URL must be reachable from all of the subnets configured for the application. Note: If you enable the Oracle Cloud Infrastructure Logging service for this application, the syslogUrl value is ignored. Function logs are sent to the Oracle Cloud Infrastructure Logging service, and not to the syslog URL. Example: tcp://logserver.myserver:1234
- `functions_application_trace_config` - Define the tracing configuration for an application.
- `functions_application_compartment_id` - The OCID of the compartment that contains the application.
- `functions_application_config` - Application configuration for functions in this application (passed as environment variables). Can be overridden by function configuration. Keys must be ASCII strings consisting solely of letters, digits, and the '_' (underscore) character, and must not begin with a digit. Values should be limited to printable unicode characters.
- `functions_invoke_function_id` - ID of functions invoke function
- `functions_invoke_function_content` - Content of the response string, if any. If base64_encode_content is set to true, then this content will be base64 encoded.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
