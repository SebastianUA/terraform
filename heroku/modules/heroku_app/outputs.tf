#---------------------------------------------------
# Heroku app
#---------------------------------------------------
output "app_id" {
  description = "The ID of the app. This is also the name of the app."
  value       = heroku_app.app.*.id
}

output "app_name" {
  description = "The name of the application."
  value       = heroku_app.app.*.name
}

output "app_stack" {
  description = "The application stack is what platform to run the application in."
  value       = heroku_app.app.*.stack
}

output "app_space" {
  description = "The private space the app should run in."
  value       = heroku_app.app.*.space
}

output "app_internal_routing" {
  description = "Whether internal routing is enabled the private space app."
  value       = heroku_app.app.*.internal_routing
}

output "app_region" {
  description = "The region that the app should be deployed in."
  value       = heroku_app.app.*.region
}

output "app_git_url" {
  description = "The Git URL for the application. This is used for deploying new versions of the app."
  value       = heroku_app.app.*.git_url
}

output "app_web_url" {
  description = "The web (HTTP) URL that the application can be accessed at by default."
  value       = heroku_app.app.*.web_url
}

output "app_heroku_hostname" {
  description = "A hostname for the Heroku application, suitable for pointing DNS records."
  value       = heroku_app.app.*.heroku_hostname
}

output "app_all_config_vars" {
  description = "A map of all of the configuration variables that exist for the app, containing both those set by Terraform and those set externally. (These are treated as 'sensitive' so that their values are redacted in console output.)"
  value       = heroku_app.app.*.all_config_vars
}

output "app_uuid" {
  description = "The unique UUID of the Heroku app. NOTE: Use this for null_resource triggers."
  value       = heroku_app.app.*.uuid
}

#---------------------------------------------------
# Heroku app config association
#---------------------------------------------------
output "app_config_association_id" {
  description = "The ID of the app config association."
  value       = heroku_app_config_association.app_config_association.*.id
}

#---------------------------------------------------
# Heroku app release
#---------------------------------------------------
output "app_release_id" {
  description = "The ID of the app release"
  value       = heroku_app_release.app_release.*.id
}

#---------------------------------------------------
# Heroku app feature
#---------------------------------------------------
output "app_feature_id" {
  description = "The ID of app feature"
  value       = heroku_app_feature.app_feature.*.id
}

#---------------------------------------------------
# Heroku app webhook
#---------------------------------------------------
output "app_webhook_id" {
  description = "The ID of app webhook"
  value       = heroku_app_webhook.app_webhook.*.id
}
