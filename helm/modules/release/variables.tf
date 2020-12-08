#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for helm release resources"
  default     = "test"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

#---------------------------------------------------
# Helm release
#---------------------------------------------------
variable "enable_release" {
  description = "Enable helm release usage"
  default     = false
}

variable "release_name" {
  description = "Release name."
  default     = ""
}

variable "release_chart" {
  description = "(Required) Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if repository is specified. It is also possible to use the <repository>/<chart> format here if you are running Terraform on a system that the repository has been added to with helm repo add but this is not recommended."
  default     = ""
}

variable "release_repository" {
  description = "(Optional) Repository URL where to locate the requested chart."
  default     = null
}

variable "release_version" {
  description = "(Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed."
  default     = null
}

variable "release_namespace" {
  description = "(Optional) The namespace to install the release into. Defaults to default."
  default     = "default"
}

variable "release_create_namespace" {
  description = "(Optional) Create the namespace if it does not yet exist. Defaults to false."
  default     = false
}

variable "release_values" {
  description = "(Optional) List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
  default     = null
}

variable "release_repository_key_file" {
  description = "(Optional) The repositories cert key file"
  default     = null
}

variable "release_repository_cert_file" {
  description = "(Optional) The repositories cert file"
  default     = null
}

variable "release_repository_ca_file" {
  description = "(Optional) The Repositories CA File."
  default     = null
}

variable "release_repository_username" {
  description = "(Optional) Username for HTTP basic authentication against the repository."
  default     = null
}

variable "release_repository_password" {
  description = "(Optional) Password for HTTP basic authentication against the repository."
  default     = null
}

variable "release_devel" {
  description = "(Optional) Use chart development versions, too. Equivalent to version '>0.0.0-0'. If version is set, this is ignored."
  default     = null
}

variable "release_verify" {
  description = "(Optional) Verify the package before installing it. Helm uses a provenance file to verify the integrity of the chart; this must be hosted alongside the chart. For more information see the Helm Documentation. Defaults to false."
  default     = false
}

variable "release_keyring" {
  description = "(Optional) Location of public keys used for verification. Used only if verify is true. Defaults to /.gnupg/pubring.gpg in the location set by home"
  default     = "/.gnupg/pubring.gpg"
}

variable "release_timeout" {
  description = "(Optional) Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks). Defaults to 300 seconds."
  default     = 300
}

variable "release_disable_webhooks" {
  description = "(Optional) Prevent hooks from running. Defauts to false"
  default     = false
}

variable "release_reuse_values" {
  description = "(Optional) When upgrading, reuse the last release's values and merge in any overrides. If 'reset_values' is specified, this is ignored. Defaults to false."
  default     = false
}

variable "release_reset_values" {
  description = "(Optional) When upgrading, reset the values to the ones built into the chart. Defaults to false."
  default     = false
}

variable "release_force_update" {
  description = "(Optional) Force resource update through delete/recreate if needed. Defaults to false"
  default     = false
}

variable "release_recreate_pods" {
  description = "(Optional) Perform pods restart during upgrade/rollback. Defaults to false."
  default     = false
}

variable "release_cleanup_on_fail" {
  description = "(Optional) Allow deletion of new resources created in this upgrade when upgrade fails. Defaults to false."
  default     = false
}

variable "release_max_history" {
  description = "(Optional) Maximum number of release versions stored per release. Defaults to 0 (no limit)."
  default     = 0
}

variable "release_atomic" {
  description = "(Optional) If set, installation process purges chart on fail. The wait flag will be set automatically if atomic is used. Defaults to false"
  default     = false
}

variable "release_skip_crds" {
  description = "(Optional) If set, no CRDs will be installed. By default, CRDs are installed if not already present. Defaults to false."
  default     = false
}

variable "release_render_subchart_notes" {
  description = "(Optional) If set, render subchart notes along with the parent. Defaults to true."
  default     = true
}

variable "release_disable_openapi_validation" {
  description = "(Optional) If set, the installation process will not validate rendered templates against the Kubernetes OpenAPI Schema. Defaults to false"
  default     = false
}

variable "release_wait" {
  description = "(Optional) Will wait until all resources are in a ready state before marking the release as successful. It will wait for as long as timeout. Defaults to true"
  default     = true
}

variable "release_dependency_update" {
  description = "(Optional) Runs helm dependency update before installing the chart. Defaults to false."
  default     = false
}

variable "release_replace" {
  description = "(Optional) Re-use the given name, even if that name is already used. This is unsafe in production. Defaults to false"
  default     = false
}

variable "release_description" {
  description = "(Optional) Set release description attribute (visible in the history)."
  default     = null
}

variable "release_lint" {
  description = "(Optional) Run the helm chart linter during the plan. Defaults to false."
  default     = false
}

variable "release_set" {
  description = "fdfdsf"
  default     = "fsdds"
}

variable "release_set_sensitive" {
  description = "(Optional) Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff."
  default     = []
}

// variable "release_set_string" {
//   description = "(Optional) Value block with custom STRING values to be merged with the values yaml."
//   default     = []
// }

variable "release_postrender" {
  description = "(Optional) Configure a command to run after helm renders the manifest which can alter the manifest contents."
  default     = []
}