#---------------------------------------------------
# Jfrog artifactory local repository
#---------------------------------------------------
output "local_repository_id" {
  description = "ID of the local repo"
  value       = element(concat(artifactory_local_repository.local_repository.*.id, [""]), 0)
}

#---------------------------------------------------
# Jfrog artifactory remote repository
#---------------------------------------------------
output "remote_repository_id" {
  description = "ID of the remote repo"
  value       = element(concat(artifactory_remote_repository.remote_repository.*.id, [""]), 0)
}

#---------------------------------------------------
# Jfrog artifactory virtual repository
#---------------------------------------------------
output "virtual_repository_id" {
  description = "ID of the virtual repo"
  value       = element(concat(artifactory_virtual_repository.virtual_repository.*.id, [""]), 0)
}