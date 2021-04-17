#---------------------------------------------------
# Jfrog artifactory local repository
#---------------------------------------------------
resource "artifactory_local_repository" "local_repository" {
  count = var.enable_local_repository ? 1 : 0

  key          = var.local_repository_key != "" ? var.local_repository_key : "${var.name}-local-repo-${var.environment}"
  package_type = var.local_repository_package_type

  description                     = var.local_repository_description
  notes                           = var.local_repository_notes
  includes_pattern                = var.local_repository_includes_pattern
  excludes_pattern                = var.local_repository_excludes_pattern
  repo_layout_ref                 = var.local_repository_repo_layout_ref
  handle_releases                 = var.local_repository_handle_releases
  handle_snapshots                = var.local_repository_handle_snapshots
  max_unique_snapshots            = var.local_repository_max_unique_snapshots
  debian_trivial_layout           = var.local_repository_debian_trivial_layout
  checksum_policy_type            = var.local_repository_checksum_policy_type
  max_unique_tags                 = var.local_repository_max_unique_tags
  snapshot_version_behavior       = var.local_repository_snapshot_version_behavior
  suppress_pom_consistency_checks = var.local_repository_suppress_pom_consistency_checks
  blacked_out                     = var.local_repository_blacked_out
  property_sets                   = var.local_repository_property_sets
  archive_browsing_enabled        = var.local_repository_archive_browsing_enabled
  calculate_yum_metadata          = var.local_repository_calculate_yum_metadata
  yum_root_depth                  = var.local_repository_yum_root_depth
  docker_api_version              = var.local_repository_docker_api_version
  enable_file_lists_indexing      = var.local_repository_enable_file_lists_indexing
  force_nuget_authentication      = var.local_repository_force_nuget_authentication

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
