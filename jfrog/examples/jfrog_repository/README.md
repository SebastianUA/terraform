# Work with JFROG_REPOSITORY via terraform

A terraform module for making JFROG_REPOSITORY.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

# Required for Terraform 0.13 and up (https://www.terraform.io/upgrade-guides/0-13.html)
terraform {

  // required_version = ">= 0.13"

  required_providers {
    jfrog = {
      source  = "jfrog/artifactory"
      version = "2.2.4"
    }
  }
}

variable "artifactory_url" {
  description = "The base URL of the Artifactory deployment"
  type        = string
}
variable "artifactory_username" {
  description = "The username for the Artifactory administrator"
  type        = string
}
variable "artifactory_password" {
  description = "The password for the Artifactory administrator"
  type        = string
}

# Configure the Artifactory provider
provider "artifactory" {
  url = "artifactory.linux-notes.org" # "${var.artifactory_url}"

  username = "captain" # "${var.artifactory_username}"
  password = "captain" # "${var.artifactory_password}"
  # or
  access_token = null
  api_key      = null

}

module "jfrog_local_repository" {
  source = "../../modules/jfrog_repository"

  enable_local_repository       = true
  local_repository_key          = "local-repo-1"
  local_repository_package_type = "npm"
}

module "jfrog_remote_repository" {
  source = "../../modules/jfrog_repository"

  enable_remote_repository       = true
  remote_repository_key          = "remote-repo-1"
  remote_repository_package_type = "npm"
  remote_repository_url          = "https://registry.npmjs.org/"

  remote_repository_repo_layout_ref = "npm-default"
}

module "jfrog_virtual_repository" {
  source = "../../modules/jfrog_repository"

  enable_virtual_repository       = true
  virtual_repository_key          = "virtual-repo-1"
  virtual_repository_package_type = "maven"
  virtual_repository_repositories = []
}
```

## Module Input Variables
----------------------
- `name` - The name for newrelic_alert resources (`default = test`)
- `environment` - Set environment for Jfrog (`default = dev`)
- `enable_local_repository` - Enable local repository usage (`default = False`)
- `local_repository_key` - Set key for local repository (`default = ""`)
- `local_repository_package_type` - Set local repository package type (`default = null`)
- `local_repository_description` - Set description for local repository (`default = null`)
- `local_repository_notes` - Set notes local repository (`default = null`)
- `local_repository_includes_pattern` - Set includes pattern for local repository (`default = null`)
- `local_repository_excludes_pattern` - Set excludes pattern for local repository (`default = null`)
- `local_repository_repo_layout_ref` - Set repo layout ref for local repository (`default = null`)
- `local_repository_handle_releases` - Set handle releases for local repository (`default = null`)
- `local_repository_handle_snapshots` - Set handle snapshots for local repository (`default = null`)
- `local_repository_max_unique_snapshots` - Set max unique snapshots for local repository (`default = null`)
- `local_repository_debian_trivial_layout` - Set debian trivial layout for local repository (`default = null`)
- `local_repository_checksum_policy_type` - Set checksum policy type for local repository (`default = null`)
- `local_repository_max_unique_tags` - Set max unique tags for local repository (`default = null`)
- `local_repository_snapshot_version_behavior` - Set snapshot version behavior for local repository (`default = null`)
- `local_repository_suppress_pom_consistency_checks` - Set suppress pom consistency checks for local repository (`default = null`)
- `local_repository_blacked_out` - Set blacked out for local repository (`default = null`)
- `local_repository_property_sets` - Set property sets for local repository (`default = null`)
- `local_repository_archive_browsing_enabled` - Set archive browsing enabled for local repository (`default = null`)
- `local_repository_calculate_yum_metadata` - Set calculate yum metadata for local repository (`default = null`)
- `local_repository_yum_root_depth` - Set yum root depth for local repository (`default = null`)
- `local_repository_docker_api_version` - Set docker api version for local repository (`default = null`)
- `local_repository_enable_file_lists_indexing` - Set enable file lists indexing for local repository (`default = null`)
- `local_repository_force_nuget_authentication` - Set force nuget authentication for local repository (`default = null`)
- `enable_remote_repository` - Enable remote repository usage (`default = False`)
- `remote_repository_description` - Set description (`default = null`)
- `remote_repository_notes` - Set notes (`default = null`)
- `remote_repository_share_configuration` - Set share_configuration (`default = null`)
- `remote_repository_key` - Set key for remote repository (`default = ""`)
- `remote_repository_package_type` - Set remote repository package type (`default = null`)
- `remote_repository_url` - Set url for remote repository (`default = null`)
- `remote_repository_includes_pattern` - Set includes pattern for remote repository (`default = null`)
- `remote_repository_excludes_pattern` - Set excludes pattern for remote repository (`default = null`)
- `remote_repository_repo_layout_ref` - Set repo layout ref for remote repository (`default = null`)
- `remote_repository_handle_releases` - Set handle releases for remote repository (`default = null`)
- `remote_repository_handle_snapshots` - Set handle snapshots for remote repository (`default = null`)
- `remote_repository_max_unique_snapshots` - Set max unique snapshots for remote repository (`default = null`)
- `remote_repository_suppress_pom_consistency_checks` - Set suppress pom consistency checks for remote repository (`default = null`)
- `remote_repository_username` - Set username for remote repository (`default = null`)
- `remote_repository_password` - Set password for remote repository (`default = null`)
- `remote_repository_proxy` - Set proxy for remote repository (`default = null`)
- `remote_repository_hard_fail` - Set hard fail for remote repository (`default = null`)
- `remote_repository_offline` - Set offline for remote repository (`default = null`)
- `remote_repository_blacked_out` - Set blacked out for remote repository (`default = null`)
- `remote_repository_store_artifacts_locally` - Set store artifacts locally for remote repository (`default = null`)
- `remote_repository_socket_timeout_millis` - Set socket timeout millis for remote repository (`default = null`)
- `remote_repository_local_address` - Set local address for remote repository (`default = null`)
- `remote_repository_retrieval_cache_period_seconds` - Set retrieval cache period seconds for remote repository (`default = null`)
- `remote_repository_missed_cache_period_seconds` - Set missed cache period seconds for remote repository (`default = null`)
- `remote_repository_unused_artifacts_cleanup_period_hours` - Set unused artifacts cleanup period hours for remote repository (`default = null`)
- `remote_repository_fetch_jars_eagerly` - Set fetch jars eagerly for remote repository (`default = null`)
- `remote_repository_fetch_sources_eagerly` - Set fetch sources eagerly for remote repository (`default = null`)
- `remote_repository_synchronize_properties` - Set synchronize properties for remote repository (`default = null`)
- `remote_repository_block_mismatching_mime_types` - Set block mismatching mime types for remote repository (`default = null`)
- `remote_repository_property_sets` - Set property sets for remote repository (`default = null`)
- `remote_repository_allow_any_host_auth` - Set allow any host auth for remote repository (`default = null`)
- `remote_repository_enable_cookie_management` - Set enable cookie management for remote repository (`default = null`)
- `remote_repository_client_tls_certificate` - Set client tls certificate for remote repository (`default = null`)
- `remote_repository_pypi_registry_url` - Set pypi registry url for remote repository (`default = null`)
- `remote_repository_bypass_head_requests` - Set bypass head requests for remote repository (`default = null`)
- `remote_repository_enable_token_authentication` - Set enable token authentication for remote repository (`default = null`)
- `remote_repository_feed_context_path` - Set feed context path for remote repository (`default = null`)
- `remote_repository_download_context_path` - Set download context path for remote repository (`default = null`)
- `remote_repository_v3_feed_url` - Set v3 feed url for remote repository (`default = null`)
- `remote_repository_force_nuget_authentication` - Set force nuget authentication for remote repository (`default = null`)
- `enable_virtual_repository` - Enable virtual repository usage (`default = False`)
- `virtual_repository_repositories` - Set repositories (`default = null`)
- `virtual_repository_key` - Set key for virtual repository (`default = ""`)
- `virtual_repository_package_type` - Set virtual repository package type (`default = null`)
- `virtual_repository_description` - Set description for virtual repository (`default = null`)
- `virtual_repository_notes` - Set notes for virtual repository (`default = null`)
- `virtual_repository_includes_pattern` - Set includes pattern for virtual repository (`default = null`)
- `virtual_repository_excludes_pattern` - Set excludes pattern for virtual repository (`default = null`)
- `virtual_repository_repo_layout_ref` - Set repo layout ref for virtual repository (`default = null`)
- `virtual_repository_debian_trivial_layout` - Set debian trivial layout for virtual repository (`default = null`)
- `virtual_repository_artifactory_requests_can_retrieve_remote_artifacts` - Set artifactory requests can retrieve remote artifacts for virtual repository (`default = null`)
- `virtual_repository_key_pair` - Set key pair for virtual repository (`default = null`)
- `virtual_repository_pom_repository_references_cleanup_policy` - Set pom repository references cleanup policy for virtual repository (`default = null`)
- `virtual_repository_default_deployment_repo` - Set default deployment repo for virtual repository (`default = null`)
- `virtual_repository_force_nuget_authentication` - Set force nuget authentication for virtual repository (`default = null`)

## Module Output Variables
----------------------
- `local_repository_id` - ID of the local repo
- `remote_repository_id` - ID of the remote repo
- `virtual_repository_id` - ID of the virtual repo


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
