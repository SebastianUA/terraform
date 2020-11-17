output "random_uuid_result" {
  description = "The generated uuid presented in string format."
  value       = module.random.uuid_result
}

output "random_string_result" {
  description = "Random string generated."
  value       = module.random.string_result
}

output "random_shuffle_result" {
  description = "Random shuffle generated."
  value       = module.random.shuffle_result
}

output "random_pet_result" {
  description = "Random pet generated."
  value       = module.random.pet_id
}

output "random_integer_result" {
  description = "(int) The random Integer result."
  value       = module.random.integer_result
}

output "random_password_result" {
  description = "Password ID"
  value       = module.random.password_result
}

output "random_id_id_b64_url" {
  description = ""
  value       = module.random.id_b64_url
}
