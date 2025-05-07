#-----------------------------------------------------------
# functions function
#-----------------------------------------------------------
output "functions_function_id" {
  description = "The OCID of the function."
  value       = element(concat(oci_functions_function.functions_function.*.id, [""]), 0)
}

output "functions_function_image" {
  description = "The qualified name of the Docker image to use in the function, including the image tag. The image should be in the Oracle Cloud Infrastructure Registry that is in the same region as the function itself. This field must be updated if image_digest is updated. Example: phx.ocir.io/ten/functions/function:0.0.1"
  value       = element(concat(oci_functions_function.functions_function.*.image, [""]), 0)
}

output "functions_function_image_digest" {
  description = "The image digest for the version of the image that will be pulled when invoking this function. If no value is specified, the digest currently associated with the image in the Oracle Cloud Infrastructure Registry will be used. This field must be updated if image is updated. Example: sha256:ca0eeb6fb05351dfc8759c20733c91def84cb8007aa89a5bf606bc8b315b9fc7"
  value       = element(concat(oci_functions_function.functions_function.*.image_digest, [""]), 0)
}

output "functions_function_invoke_endpoint" {
  description = "The base https invoke URL to set on a client in order to invoke a function. This URL will never change over the lifetime of the function and can be cached."
  value       = element(concat(oci_functions_function.functions_function.*.invoke_endpoint, [""]), 0)
}

output "functions_function_memory_in_mbs" {
  description = "Maximum usable memory for the function (MiB)."
  value       = element(concat(oci_functions_function.functions_function.*.memory_in_mbs, [""]), 0)
}

output "functions_function_provisioned_concurrency_config" {
  description = "Define the strategy for provisioned concurrency for the function."
  value       = concat(oci_functions_function.functions_function.*.provisioned_concurrency_config, [""])
}

output "functions_function_application_id" {
  description = "The OCID of the application the function belongs to."
  value       = element(concat(oci_functions_function.functions_function.*.application_id, [""]), 0)
}

output "functions_function_compartment_id" {
  description = "The OCID of the compartment that contains the function."
  value       = element(concat(oci_functions_function.functions_function.*.compartment_id, [""]), 0)
}

output "functions_function_config" {
  description = "Function configuration. Overrides application configuration. Keys must be ASCII strings consisting solely of letters, digits, and the '_' (underscore) character, and must not begin with a digit. Values should be limited to printable unicode characters. "
  value       = concat(oci_functions_function.functions_function.*.config, [""])
}

output "functions_function_display_name" {
  description = "The display name of the function. The display name is unique within the application containing the function."
  value       = element(concat(oci_functions_function.functions_function.*.display_name, [""]), 0)
}

output "functions_function_shape" {
  description = "The processor shape (GENERIC_X86/GENERIC_ARM) on which to run functions in the application, extracted from the image manifest."
  value       = element(concat(oci_functions_function.functions_function.*.shape, [""]), 0)
}

output "functions_function_source_details" {
  description = "The source details for the Function. The function can be created from various sources."
  value       = concat(oci_functions_function.functions_function.*.source_details, [""])
}

output "functions_function_state" {
  description = "The current state of the function."
  value       = element(concat(oci_functions_function.functions_function.*.state, [""]), 0)
}

#-----------------------------------------------------------
# functions application
#-----------------------------------------------------------
output "functions_application_id" {
  description = "The OCID of the application."
  value       = element(concat(oci_functions_application.functions_application.*.id, [""]), 0)
}

output "functions_application_network_security_group_ids" {
  description = "The OCIDs of the Network Security Groups to add the application to."
  value       = element(concat(oci_functions_application.functions_application.*.network_security_group_ids, [""]), 0)
}

output "functions_application_image_policy_config" {
  description = "Define the image signature verification policy for an application."
  value       = element(concat(oci_functions_application.functions_application.*.image_policy_config, [""]), 0)
}

output "functions_application_display_name" {
  description = "The display name of the application. The display name is unique within the compartment containing the application."
  value       = element(concat(oci_functions_application.functions_application.*.display_name, [""]), 0)
}

output "functions_application_shape" {
  description = "Valid values are GENERIC_X86, GENERIC_ARM and GENERIC_X86_ARM. Default is GENERIC_X86. Setting this to GENERIC_X86, will run the functions in the application on X86 processor architecture. Setting this to GENERIC_ARM, will run the functions in the application on ARM processor architecture. When set to GENERIC_X86_ARM, functions in the application are run on either X86 or ARM processor architecture. Accepted values are: GENERIC_X86, GENERIC_ARM, GENERIC_X86_ARM"
  value       = element(concat(oci_functions_application.functions_application.*.shape, [""]), 0)
}

output "functions_application_state" {
  description = "The current state of the application."
  value       = element(concat(oci_functions_application.functions_application.*.state, [""]), 0)
}

output "functions_application_subnet_ids" {
  description = "The OCIDs of the subnets in which to run functions in the application."
  value       = element(concat(oci_functions_application.functions_application.*.subnet_ids, [""]), 0)
}

output "functions_application_syslog_url" {
  description = "A syslog URL to which to send all function logs. Supports tcp, udp, and tcp+tls. The syslog URL must be reachable from all of the subnets configured for the application. Note: If you enable the Oracle Cloud Infrastructure Logging service for this application, the syslogUrl value is ignored. Function logs are sent to the Oracle Cloud Infrastructure Logging service, and not to the syslog URL. Example: tcp://logserver.myserver:1234"
  value       = element(concat(oci_functions_application.functions_application.*.syslog_url, [""]), 0)
}

output "functions_application_trace_config" {
  description = "Define the tracing configuration for an application."
  value       = element(concat(oci_functions_application.functions_application.*.trace_config, [""]), 0)
}

output "functions_application_compartment_id" {
  description = "The OCID of the compartment that contains the application."
  value       = element(concat(oci_functions_application.functions_application.*.compartment_id, [""]), 0)
}

output "functions_application_config" {
  description = "Application configuration for functions in this application (passed as environment variables). Can be overridden by function configuration. Keys must be ASCII strings consisting solely of letters, digits, and the '_' (underscore) character, and must not begin with a digit. Values should be limited to printable unicode characters."
  value       = element(concat(oci_functions_application.functions_application.*.config, [""]), 0)
}

#-----------------------------------------------------------
# functions invoke function
#-----------------------------------------------------------
output "functions_invoke_function_id" {
  description = "ID of functions invoke function"
  value       = element(concat(oci_functions_invoke_function.functions_invoke_function.*.id, [""]), 0)
}

output "functions_invoke_function_content" {
  description = "Content of the response string, if any. If base64_encode_content is set to true, then this content will be base64 encoded."
  value       = element(concat(oci_functions_invoke_function.functions_invoke_function.*.content, [""]), 0)
}
