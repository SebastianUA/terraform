#---------------------------------------------------
# Helm release
#---------------------------------------------------
output "release_id" {
  description = "Id of Helm release"
  value       = element(concat(helm_release.release[0].*.id, [""]), 0)
}

output "release_metadata" {
  description = "Metadata of Helm release"
  value       = helm_release.release[0].metadata
}
 