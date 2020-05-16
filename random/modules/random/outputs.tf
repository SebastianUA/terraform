#---------------------------------------------------
# Random uuid
#---------------------------------------------------
output "uuid_id" {
    description = "The ID of uuid"
    value       = element(concat(random_uuid.uuid.*.id, [""]), 0)
}

output "uuid_result" {
    description = "The generated uuid presented in string format."
    value       = element(concat(random_uuid.uuid.*.result, [""]), 0)
}

#---------------------------------------------------
# Random string
#---------------------------------------------------
output "string_id" {
    description = "The ID of string"
    value       = element(concat(random_string.string.*.id, [""]), 0)
}

output "string_result" {
    description = "Random string generated."
    value       = element(concat(random_string.string.*.result, [""]), 0)
}

#---------------------------------------------------
# Random shuffle
#---------------------------------------------------
output "shuffle_id" {
    description = "The ID of shuffle"
    value       = element(concat(random_shuffle.shuffle.*.id, [""]), 0)
}

output "shuffle_result" {
    description = "Random permutation of the list of strings given in input."
    value       = element(concat(random_shuffle.shuffle.*.result, [""]), 0)
}

#---------------------------------------------------
# Random pet
#---------------------------------------------------
output "pet_id" {
    description = "(string) The random pet name"
    value       = element(concat(random_pet.pet.*.id, [""]), 0)
}

#---------------------------------------------------
# Random integer
#---------------------------------------------------
output "integer_id" {
    description = "(string) An internal id."
    value       = element(concat(random_integer.integer.*.id, [""]), 0)
}

output "integer_result" {
    description = "(int) The random Integer result."
    value       = element(concat(random_integer.integer.*.result, [""]), 0)
}

#---------------------------------------------------
# Random password
#---------------------------------------------------
output "password_result" {
    description = "The random password result."
    value       = element(concat(random_password.password.*.result, [""]), 0)
}

#---------------------------------------------------
# Random id
#---------------------------------------------------
output "id_b64_url" {
    description = "The generated id presented in base64, using the URL-friendly character set: case-sensitive letters, digits and the characters _ and -."
    value       = element(concat(random_id.id.*.b64_url, [""]), 0)
}

output "id_b64_std" {
    description = "The generated id presented in base64 without additional transformations."
    value       = element(concat(random_id.id.*.b64_std, [""]), 0)
}

output "id_hex" {
    description = "The generated id presented in padded hexadecimal digits. This result will always be twice as long as the requested byte length."
    value       = element(concat(random_id.id.*.hex, [""]), 0)
}

output "id_dec" {
    description = "The generated id presented in non-padded decimal digits."
    value       = element(concat(random_id.id.*.dec, [""]), 0)
}
