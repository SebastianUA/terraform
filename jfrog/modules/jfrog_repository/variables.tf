#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for newrelic_alert resources"
  default     = "test"
}

variable "environment" {
  description = "Set environment for Jfrog"
  default     = "dev"
}

#---------------------------------------------------
# Jfrog artifactory local repository
#---------------------------------------------------
variable "enable_local_repository" {
  description = "Enable local repository usage"
  default     = false
}

variable "local_repository_key" {
  description = "Set key for local repository"
  default     = ""
}

variable "local_repository_package_type" {
  description = "Set local repository package type"
  default     = null
}

variable "local_repository_description" {
  description = "Set description for local repository"
  default     = null
}

variable "local_repository_notes" {
  description = "Set notes local repository"
  default     = null
}

variable "local_repository_includes_pattern" {
  description = "Set includes pattern for local repository"
  default     = null
}

variable "local_repository_excludes_pattern" {
  description = "Set excludes pattern for local repository"
  default     = null
}

variable "local_repository_repo_layout_ref" {
  description = "Set repo layout ref for local repository"
  default     = null
}

variable "local_repository_handle_releases" {
  description = "Set handle releases for local repository"
  default     = null
}

variable "local_repository_handle_snapshots" {
  description = "Set handle snapshots for local repository"
  default     = null
}

variable "local_repository_max_unique_snapshots" {
  description = "Set max unique snapshots for local repository"
  default     = null
}

variable "local_repository_debian_trivial_layout" {
  description = "Set debian trivial layout for local repository"
  default     = null
}

variable "local_repository_checksum_policy_type" {
  description = "Set checksum policy type for local repository"
  default     = null
}

variable "local_repository_max_unique_tags" {
  description = "Set max unique tags for local repository"
  default     = null
}

variable "local_repository_snapshot_version_behavior" {
  description = "Set snapshot version behavior for local repository"
  default     = null
}

variable "local_repository_suppress_pom_consistency_checks" {
  description = "Set suppress pom consistency checks for local repository"
  default     = null
}

variable "local_repository_blacked_out" {
  description = "Set blacked out for local repository"
  default     = null
}

variable "local_repository_property_sets" {
  description = "Set property sets for local repository"
  default     = null
}

variable "local_repository_archive_browsing_enabled" {
  description = "Set archive browsing enabled for local repository"
  default     = null
}

variable "local_repository_calculate_yum_metadata" {
  description = "Set calculate yum metadata for local repository"
  default     = null
}

variable "local_repository_yum_root_depth" {
  description = "Set yum root depth for local repository"
  default     = null
}

variable "local_repository_docker_api_version" {
  description = "Set docker api version for local repository"
  default     = null
}

variable "local_repository_enable_file_lists_indexing" {
  description = "Set enable file lists indexing for local repository"
  default     = null
}

variable "local_repository_force_nuget_authentication" {
  description = "Set force nuget authentication for local repository"
  default     = null
}

#---------------------------------------------------
# Jfrog artifactory remote repository
#---------------------------------------------------
variable "enable_remote_repository" {
  description = "Enable remote repository usage"
  default     = false
}

variable "remote_repository_description" {
  description = "Set description"
  default     = null
}

variable "remote_repository_notes" {
  description = "Set notes"
  default     = null
}

variable "remote_repository_share_configuration" {
  description = "Set share_configuration"
  default     = null
}

variable "remote_repository_key" {
  description = "Set key for remote repository"
  default     = ""
}

variable "remote_repository_package_type" {
  description = "Set remote repository package type"
  default     = null
}

variable "remote_repository_url" {
  description = "Set url for remote repository"
  default     = null
}

variable "remote_repository_includes_pattern" {
  description = "Set includes pattern for remote repository"
  default     = null
}

variable "remote_repository_excludes_pattern" {
  description = "Set excludes pattern for remote repository"
  default     = null
}

variable "remote_repository_repo_layout_ref" {
  description = "Set repo layout ref for remote repository"
  default     = null
}

variable "remote_repository_handle_releases" {
  description = "Set handle releases for remote repository"
  default     = null
}

variable "remote_repository_handle_snapshots" {
  description = "Set handle snapshots for remote repository"
  default     = null
}

variable "remote_repository_max_unique_snapshots" {
  description = "Set max unique snapshots for remote repository"
  default     = null
}

variable "remote_repository_suppress_pom_consistency_checks" {
  description = "Set suppress pom consistency checks for remote repository"
  default     = null
}

variable "remote_repository_username" {
  description = "Set username for remote repository"
  default     = null
}

variable "remote_repository_password" {
  description = "Set password for remote repository"
  default     = null
}

variable "remote_repository_proxy" {
  description = "Set proxy for remote repository"
  default     = null
}

variable "remote_repository_hard_fail" {
  description = "Set hard fail for remote repository"
  default     = null
}

variable "remote_repository_offline" {
  description = "Set offline for remote repository"
  default     = null
}

variable "remote_repository_blacked_out" {
  description = "Set blacked out for remote repository"
  default     = null
}

variable "remote_repository_store_artifacts_locally" {
  description = "Set store artifacts locally for remote repository"
  default     = null
}

variable "remote_repository_socket_timeout_millis" {
  description = "Set socket timeout millis for remote repository"
  default     = null
}

variable "remote_repository_local_address" {
  description = "Set local address for remote repository"
  default     = null
}

variable "remote_repository_retrieval_cache_period_seconds" {
  description = "Set retrieval cache period seconds for remote repository"
  default     = null
}

variable "remote_repository_missed_cache_period_seconds" {
  description = "Set missed cache period seconds for remote repository"
  default     = null
}

variable "remote_repository_unused_artifacts_cleanup_period_hours" {
  description = "Set unused artifacts cleanup period hours for remote repository"
  default     = null
}

variable "remote_repository_fetch_jars_eagerly" {
  description = "Set fetch jars eagerly for remote repository"
  default     = null
}

variable "remote_repository_fetch_sources_eagerly" {
  description = "Set fetch sources eagerly for remote repository"
  default     = null
}

variable "remote_repository_synchronize_properties" {
  description = "Set synchronize properties for remote repository"
  default     = null
}

variable "remote_repository_block_mismatching_mime_types" {
  description = "Set block mismatching mime types for remote repository"
  default     = null
}

variable "remote_repository_property_sets" {
  description = "Set property sets for remote repository"
  default     = null
}

variable "remote_repository_allow_any_host_auth" {
  description = "Set allow any host auth for remote repository"
  default     = null
}

variable "remote_repository_enable_cookie_management" {
  description = "Set enable cookie management for remote repository"
  default     = null
}

variable "remote_repository_client_tls_certificate" {
  description = "Set client tls certificate for remote repository"
  default     = null
}

variable "remote_repository_pypi_registry_url" {
  description = "Set pypi registry url for remote repository"
  default     = null
}

variable "remote_repository_bypass_head_requests" {
  description = "Set bypass head requests for remote repository"
  default     = null
}

variable "remote_repository_enable_token_authentication" {
  description = "Set enable token authentication for remote repository"
  default     = null
}

variable "remote_repository_feed_context_path" {
  description = "Set feed context path for remote repository"
  default     = null
}

variable "remote_repository_download_context_path" {
  description = "Set download context path for remote repository"
  default     = null
}

variable "remote_repository_v3_feed_url" {
  description = "Set v3 feed url for remote repository"
  default     = null
}

variable "remote_repository_force_nuget_authentication" {
  description = "Set force nuget authentication for remote repository"
  default     = null
}

#---------------------------------------------------
# Jfrog artifactory virtual repository
#---------------------------------------------------
variable "enable_virtual_repository" {
  description = "Enable virtual repository usage"
  default     = false
}

variable "virtual_repository_repositories" {
  description = "Set repositories"
  default     = null
}

variable "virtual_repository_key" {
  description = "Set key for virtual repository"
  default     = ""
}

variable "virtual_repository_package_type" {
  description = "Set virtual repository package type"
  default     = null
}

variable "virtual_repository_description" {
  description = "Set description for virtual repository"
  default     = null
}

variable "virtual_repository_notes" {
  description = "Set notes for virtual repository"
  default     = null
}

variable "virtual_repository_includes_pattern" {
  description = "Set includes pattern for virtual repository"
  default     = null
}

variable "virtual_repository_excludes_pattern" {
  description = "Set excludes pattern for virtual repository"
  default     = null
}

variable "virtual_repository_repo_layout_ref" {
  description = "Set repo layout ref for virtual repository"
  default     = null
}

variable "virtual_repository_debian_trivial_layout" {
  description = "Set debian trivial layout for virtual repository"
  default     = null
}

variable "virtual_repository_artifactory_requests_can_retrieve_remote_artifacts" {
  description = "Set artifactory requests can retrieve remote artifacts for virtual repository"
  default     = null
}

variable "virtual_repository_key_pair" {
  description = "Set key pair for virtual repository"
  default     = null
}

variable "virtual_repository_pom_repository_references_cleanup_policy" {
  description = "Set pom repository references cleanup policy for virtual repository"
  default     = null
}

variable "virtual_repository_default_deployment_repo" {
  description = "Set default deployment repo for virtual repository"
  default     = null
}

variable "virtual_repository_force_nuget_authentication" {
  description = "Set force nuget authentication for virtual repository"
  default     = null
}