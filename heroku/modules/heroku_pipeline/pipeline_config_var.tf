#---------------------------------------------------
# Heroku pipeline config var
#---------------------------------------------------
resource "heroku_pipeline_config_var" "pipeline_config_var" {
  count = var.enable_pipeline_config_var ? 1 : 0

  pipeline_id    = var.pipeline_config_var_pipeline_id != "" ? var.pipeline_config_var_pipeline_id : (var.enable_pipeline ? element(heroku_pipeline.pipeline.*.id, 0) : null)
  pipeline_stage = var.pipeline_config_var_pipeline_stage

  vars           = var.pipeline_config_var_vars
  sensitive_vars = var.pipeline_config_var_sensitive_vars

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    heroku_pipeline.pipeline
  ]
}