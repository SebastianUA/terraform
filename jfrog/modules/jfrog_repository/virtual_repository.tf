#---------------------------------------------------
# Jfrog artifactory virtual repository
#---------------------------------------------------
resource "artifactory_virtual_repository" "virtual_repository" {
  count = var.enable_virtual_repository ? 1 : 0

  key          = var.virtual_repository_key != "" ? var.virtual_repository_key : "${var.name}-virtual-repo-${var.environment}"
  package_type = var.virtual_repository_package_type
  repositories = var.virtual_repository_repositories

  description                                        = var.virtual_repository_description
  notes                                              = var.virtual_repository_notes
  includes_pattern                                   = var.virtual_repository_includes_pattern
  excludes_pattern                                   = var.virtual_repository_excludes_pattern
  repo_layout_ref                                    = var.virtual_repository_repo_layout_ref
  debian_trivial_layout                              = var.virtual_repository_debian_trivial_layout
  artifactory_requests_can_retrieve_remote_artifacts = var.virtual_repository_artifactory_requests_can_retrieve_remote_artifacts
  key_pair                                           = var.virtual_repository_key_pair
  pom_repository_references_cleanup_policy           = var.virtual_repository_pom_repository_references_cleanup_policy
  default_deployment_repo                            = var.virtual_repository_default_deployment_repo
  force_nuget_authentication                         = var.virtual_repository_force_nuget_authentication

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}