# secretsmanager secret
output "secretsmanager_secret_id" {
  value = module.secretsmanager.secretsmanager_secret_id
}

output "secretsmanager_secret_arn" {
  value = module.secretsmanager.secretsmanager_secret_arn
}

output "secretsmanager_secret_rotation_enabled" {
  value = module.secretsmanager.secretsmanager_secret_rotation_enabled
}

# AWS secretsmanager secret version
output "secretsmanager_secret_version_id" {
  value = module.secretsmanager.secretsmanager_secret_version_id
}

output "secretsmanager_secret_version_arn" {
  value = module.secretsmanager.secretsmanager_secret_version_arn
}

output "secretsmanager_secret_version_version_id" {
  value = module.secretsmanager.secretsmanager_secret_version_version_id
}

output "secretsmanager_secret_version_secret_string" {
  value = jsondecode(element(module.secretsmanager.secretsmanager_secret_version_secret_string, 0))
}
