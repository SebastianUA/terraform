#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# functions function
#-----------------------------------------------------------
variable "enable_functions_function" {
  description = "Enable functions function usages"
  default     = false
}

variable "functions_function_application_id" {
  description = "The OCID of the application this function belongs to."
  default     = ""
}

variable "functions_function_display_name" {
  description = "The display name of the function. The display name must be unique within the application containing the function. Avoid entering confidential information."
  default     = ""
}

variable "functions_function_memory_in_mbs" {
  description = "(Required) (Updatable) Maximum usable memory for the function (MiB)."
  default     = null
}

variable "functions_function_config" {
  description = "(Optional) (Updatable) Function configuration. These values are passed on to the function as environment variables, this overrides application configuration values. Keys must be ASCII strings consisting solely of letters, digits, and the '_' (underscore) character, and must not begin with a digit. Values should be limited to printable unicode characters. Example: {'MY_FUNCTION_CONFIG': 'ConfVal'}"
  default     = null
}

variable "functions_function_image" {
  description = "(Optional) (Updatable) The qualified name of the Docker image to use in the function, including the image tag. The image should be in the Oracle Cloud Infrastructure Registry that is in the same region as the function itself. This field must be updated if image_digest is updated. Example: phx.ocir.io/ten/functions/function:0.0.1"
  default     = null
}

variable "functions_function_image_digest" {
  description = "(Optional) (Updatable) The image digest for the version of the image that will be pulled when invoking this function. If no value is specified, the digest currently associated with the image in the Oracle Cloud Infrastructure Registry will be used. This field must be updated if image is updated. Example: sha256:ca0eeb6fb05351dfc8759c20733c91def84cb8007aa89a5bf606bc8b315b9fc7"
  default     = null
}

variable "functions_function_timeout_in_seconds" {
  description = "(Optional) (Updatable) Timeout for executions of the function. Value in seconds."
  default     = null
}

variable "functions_function_provisioned_concurrency_config" {
  description = "(Optional) (Updatable) Define the strategy for provisioned concurrency for the function."
  default     = {}
}

variable "functions_function_source_details" {
  description = "(Optional) The source details for the Function. The function can be created from various sources."
  default     = []
}

variable "functions_function_trace_config" {
  description = "(Optional) (Updatable) Define the tracing configuration for a function."
  default     = {}
}

variable "functions_function_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "functions_function_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Function * update - (Defaults to 20 minutes), when updating the Function * delete - (Defaults to 20 minutes), when destroying the Function"
  default     = {}
}

#-----------------------------------------------------------
# functions application
#-----------------------------------------------------------
variable "enable_functions_application" {
  description = "Enable functions application usages"
  default     = false
}

variable "functions_application_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to create the application within."
  default     = null
}

variable "functions_application_display_name" {
  description = "The display name of the application. The display name must be unique within the compartment containing the application. Avoid entering confidential information."
  default     = ""
}

variable "functions_application_subnet_ids" {
  description = "(Required) The OCIDs of the subnets in which to run functions in the application."
  default     = null
}

variable "functions_application_config" {
  description = "(Optional) (Updatable) Application configuration. These values are passed on to the function as environment variables, functions may override application configuration. Keys must be ASCII strings consisting solely of letters, digits, and the '_' (underscore) character, and must not begin with a digit. Values should be limited to printable unicode characters. Example: {'MY_FUNCTION_CONFIG': 'ConfVal'}"
  default     = {}
}

variable "functions_application_network_security_group_ids" {
  description = "(Optional) (Updatable) The OCIDs of the Network Security Groups to add the application to."
  default     = null
}

variable "functions_application_shape" {
  description = "(Optional) Valid values are GENERIC_X86, GENERIC_ARM and GENERIC_X86_ARM. Default is GENERIC_X86. Setting this to GENERIC_X86, will run the functions in the application on X86 processor architecture. Setting this to GENERIC_ARM, will run the functions in the application on ARM processor architecture. When set to GENERIC_X86_ARM, functions in the application are run on either X86 or ARM processor architecture. Accepted values are: GENERIC_X86, GENERIC_ARM, GENERIC_X86_ARM"
  default     = null
}

variable "functions_application_syslog_url" {
  description = "(Optional) (Updatable) A syslog URL to which to send all function logs. Supports tcp, udp, and tcp+tls. The syslog URL must be reachable from all of the subnets configured for the application. Note: If you enable the Oracle Cloud Infrastructure Logging service for this application, the syslogUrl value is ignored. Function logs are sent to the Oracle Cloud Infrastructure Logging service, and not to the syslog URL. Example: tcp://logserver.myserver:1234"
  default     = null
}

variable "functions_application_image_policy_config" {
  description = "(Optional) (Updatable) Define the image signature verification policy for an application."
  default     = {}
}

variable "functions_application_trace_config" {
  description = "(Optional) (Updatable) Define the tracing configuration for an application."
  default     = {}
}

variable "functions_application_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "functions_application_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Application * update - (Defaults to 20 minutes), when updating the Application * delete - (Defaults to 20 minutes), when destroying the Application"
  default     = {}
}

#-----------------------------------------------------------
# functions invoke function
#-----------------------------------------------------------
variable "enable_functions_invoke_function" {
  description = "Enable functions invoke function usages"
  default     = false
}

variable "functions_invoke_function_function_id" {
  description = "The OCID of this function."
  default     = ""
}

variable "functions_invoke_function_invoke_function_body" {
  description = "(Optional) The body of the function invocation. Note: The maximum size of the request is limited. This limit is currently 6MB and the endpoint will not accept requests that are bigger than this limit. Cannot be defined if input_body_source_path or invoke_function_body_base64_encoded is defined."
  default     = null
}

variable "functions_invoke_function_fn_intent" {
  description = "(Optional) An optional intent header that indicates to the FDK the way the event should be interpreted. E.g. 'httprequest', 'cloudevent'."
  default     = null
}

variable "functions_invoke_function_fn_invoke_type" {
  description = "(Optional) Indicates whether Oracle Functions should execute the request and return the result ('sync') of the execution, or whether Oracle Functions should return as soon as processing has begun ('detached') and leave result handling to the function."
  default     = null
}

variable "functions_invoke_function_base64_encode_content" {
  description = "(Optional) The Base64 encoded body of the function invocation. Base64 encoded input avoids corruption in Terraform state. Cannot be defined if invoke_function_body or input_body_source_path is defined. Note: The maximum size of the request is limited. This limit is currently 6MB and the endpoint will not accept requests that are bigger than this limit."
  default     = null
}

variable "functions_invoke_function_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Invoke Function * update - (Defaults to 20 minutes), when updating the Invoke Function * delete - (Defaults to 20 minutes), when destroying the Invoke Function"
  default     = {}
}
