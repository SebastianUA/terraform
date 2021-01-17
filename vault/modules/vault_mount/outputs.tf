#---------------------------------------------------
# Vault mount
#---------------------------------------------------
output "mount_id" {
  description = "ID of the mount."
  value       = element(concat(vault_mount.mount.*.id, [""]), 0)
}

output "mount_accessor" {
  description = "The accessor for this mount."
  value       = element(concat(vault_mount.mount.*.accessor, [""]), 0)
}
