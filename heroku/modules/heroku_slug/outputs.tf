#---------------------------------------------------
# Heroku slug
#---------------------------------------------------
output "slug_id" {
  description = "The ID of the slug"
  value       = heroku_slug.slug.*.id
}

output "slug_app" {
  description = "The ID or unique name of the Heroku app"
  value       = heroku_slug.slug.*.app
}

output "slug_blob" {
  description = "Slug archive (compressed tar of executable code)"
  value       = heroku_slug.slug.*.blob
}

output "slug_buildpack_provided_description" {
  description = "Description of language or app framework, 'Ruby/Rack'"
  value       = heroku_slug.slug.*.buildpack_provided_description
}

output "slug_checksum" {
  description = "Hash of the slug for verifying its integrity, auto-generated from contents of file_path or file_url"
  value       = heroku_slug.slug.*.checksum
}

output "slug_commit" {
  description = "Identification of the code with your version control system (eg: SHA of the git HEAD), '60883d9e8947a57e04dc9124f25df004866a2051'"
  value       = heroku_slug.slug.*.commit
}

output "slug_commit_description" {
  description = "Description of the provided commit"
  value       = heroku_slug.slug.*.commit_description
}

output "slug_process_types" {
  description = "Map of processes to launch on Heroku Dynos"
  value       = heroku_slug.slug.*.process_types
}

output "slug_size" {
  description = "Slug archive filesize in bytes"
  value       = heroku_slug.slug.*.size
}

output "slug_stack" {
  description = "Heroku stack name"
  value       = heroku_slug.slug.*.stack
}

output "slug_stack_id" {
  description = "Heroku stack ID"
  value       = heroku_slug.slug.*.stack_id
}
