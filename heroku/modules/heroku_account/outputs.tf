#---------------------------------------------------
# Heroku account feature
#---------------------------------------------------
output "heroku_account_feature_id" {
  description = "Comprised of acount email & feature name"
  value       = heroku_account_feature.account_feature.*.id
}

output "heroku_account_feature_description" {
  description = "Description of account feature"
  value       = heroku_account_feature.account_feature.*.description
}

output "heroku_account_feature_state" {
  description = "State of account feature"
  value       = heroku_account_feature.account_feature.*.state
}
