#---------------------------------------------------
# Heroku build
#---------------------------------------------------
output "build_id" {
  description = "The ID of the build"
  value       = heroku_build.build.*.id
}

output "build_uuid" {
  description = "The ID of the build"
  value       = heroku_build.build.*.uuid
}

output "build_output_stream_url" {
  description = "URL that streams the log output from the build"
  value       = heroku_build.build.*.output_stream_url
}

output "build_release_id" {
  description = "The Heroku app release created with a build's slug"
  value       = heroku_build.build.*.release_id
}

output "build_slug_id" {
  description = "The Heroku slug created by a build"
  value       = heroku_build.build.*.slug_id
}

output "build_stack" {
  description = "Name or ID of the Heroku stack"
  value       = heroku_build.build.*.stack
}

output "build_status" {
  description = "The status of a build. Possible values are pending, successful and failed"
  value       = heroku_build.build.*.status
}

output "build_user" {
  description = "Heroku account that created a build"
  value       = heroku_build.build.*.user
}
