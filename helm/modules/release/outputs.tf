#---------------------------------------------------
# Helm release
#---------------------------------------------------
output "release_id" {
  description = "Id of Helm release"
  value       = element(concat(helm_release.release.*.id, [""]), 0)
}

output "release_metadata" {
  description = "Metadata of Helm release"
  value       = concat(helm_release.release.*.metadata, [""])
}