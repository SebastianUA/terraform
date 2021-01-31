#---------------------------------------------------
# Heroku addon
#---------------------------------------------------
output "addon_id" {
  description = "The ID of the add-on"
  value       = heroku_addon.addon.*.id
}

output "addon_name" {
  description = "The add-on name"
  value       = heroku_addon.addon.*.name
}

output "addon_plan" {
  description = "The plan name"
  value       = heroku_addon.addon.*.plan
}

output "addon_provider_id" {
  description = "The ID of the plan provider"
  value       = heroku_addon.addon.*.provider_id
}

output "addon_config_vars" {
  description = "The Configuration variables of the add-ons"
  value       = heroku_addon.addon.*.config_vars
}

#---------------------------------------------------
# Heroku addon attachment
#---------------------------------------------------
output "addon_attachment_id" {
  description = "The unique ID of the add-on attachment"
  value       = heroku_addon_attachment.addon_attachment.*.id
}
