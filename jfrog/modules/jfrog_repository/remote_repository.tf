#---------------------------------------------------
# Jfrog artifactory remote repository
#---------------------------------------------------
resource "artifactory_remote_repository" "remote_repository" {
  count = var.enable_remote_repository ? 1 : 0

  key          = var.remote_repository_key != "" ? var.remote_repository_key : "${var.name}-remote-repo-${var.environment}"
  package_type = var.remote_repository_package_type
  url          = var.remote_repository_url

  description                           = var.remote_repository_description
  notes                                 = var.remote_repository_notes
  includes_pattern                      = var.remote_repository_includes_pattern
  excludes_pattern                      = var.remote_repository_excludes_pattern
  repo_layout_ref                       = var.remote_repository_repo_layout_ref
  handle_releases                       = var.remote_repository_handle_releases
  handle_snapshots                      = var.remote_repository_handle_snapshots
  max_unique_snapshots                  = var.remote_repository_max_unique_snapshots
  suppress_pom_consistency_checks       = var.remote_repository_suppress_pom_consistency_checks
  username                              = var.remote_repository_username
  password                              = var.remote_repository_password
  proxy                                 = var.remote_repository_proxy
  hard_fail                             = var.remote_repository_hard_fail
  offline                               = var.remote_repository_offline
  blacked_out                           = var.remote_repository_blacked_out
  store_artifacts_locally               = var.remote_repository_store_artifacts_locally
  socket_timeout_millis                 = var.remote_repository_socket_timeout_millis
  local_address                         = var.remote_repository_local_address
  retrieval_cache_period_seconds        = var.remote_repository_retrieval_cache_period_seconds
  missed_cache_period_seconds           = var.remote_repository_missed_cache_period_seconds
  unused_artifacts_cleanup_period_hours = var.remote_repository_unused_artifacts_cleanup_period_hours
  fetch_jars_eagerly                    = var.remote_repository_fetch_jars_eagerly
  fetch_sources_eagerly                 = var.remote_repository_fetch_sources_eagerly
  share_configuration                   = var.remote_repository_share_configuration
  synchronize_properties                = var.remote_repository_synchronize_properties
  block_mismatching_mime_types          = var.remote_repository_block_mismatching_mime_types
  property_sets                         = var.remote_repository_property_sets
  allow_any_host_auth                   = var.remote_repository_allow_any_host_auth
  enable_cookie_management              = var.remote_repository_enable_cookie_management
  client_tls_certificate                = var.remote_repository_client_tls_certificate
  pypi_registry_url                     = var.remote_repository_pypi_registry_url
  bypass_head_requests                  = var.remote_repository_bypass_head_requests
  enable_token_authentication           = var.remote_repository_enable_token_authentication
  feed_context_path                     = var.remote_repository_feed_context_path
  download_context_path                 = var.remote_repository_download_context_path
  v3_feed_url                           = var.remote_repository_v3_feed_url
  force_nuget_authentication            = var.remote_repository_force_nuget_authentication

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}