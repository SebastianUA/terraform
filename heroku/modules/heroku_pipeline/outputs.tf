#---------------------------------------------------
# Heroku pipeline
#---------------------------------------------------
output "pipeline_id" {
  description = "The UUID of the pipeline."
  value       = heroku_pipeline.pipeline.*.id
}

output "pipeline_name" {
  description = "The name of the pipeline."
  value       = heroku_pipeline.pipeline.*.name
}

#---------------------------------------------------
# Heroku pipeline config var
#---------------------------------------------------
output "pipeline_config_var_id" {
  description = "The UUID of the pipeline."
  value       = heroku_pipeline_config_var.pipeline_config_var.*.id
}

output "pipeline_config_var_all_vars" {
  description = "The all_vars of the pipeline config var"
  value       = heroku_pipeline_config_var.pipeline_config_var.*.all_vars
}

#---------------------------------------------------
# Heroku pipeline coupling
#---------------------------------------------------
output "pipeline_coupling_id" {
  description = "The UUID of this pipeline coupling."
  value       = heroku_pipeline_coupling.pipeline_coupling.*.id
}

output "pipeline_coupling_app" {
  description = "The name of the application."
  value       = heroku_pipeline_coupling.pipeline_coupling.*.app
}

output "pipeline_coupling_app_id" {
  description = "The ID of the application."
  value       = heroku_pipeline_coupling.pipeline_coupling.*.app_id
}

output "pipeline_coupling_pipeline" {
  description = "The UUID of the pipeline."
  value       = heroku_pipeline_coupling.pipeline_coupling.*.pipeline
}

output "pipeline_coupling_stage" {
  description = "The stage for this coupling."
  value       = heroku_pipeline_coupling.pipeline_coupling.*.stage
}
