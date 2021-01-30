#---------------------------------------------------
# Heroku pipeline coupling
#---------------------------------------------------
resource "heroku_pipeline_coupling" "pipeline_coupling" {
  count = var.enable_pipeline_coupling ? 1 : 0

  app      = var.pipeline_coupling_app
  pipeline = var.pipeline_coupling_pipeline != "" ? var.pipeline_coupling_pipeline : (var.enable_pipeline ? element(heroku_pipeline.pipeline.*.id, 0) : null)
  stage    = var.pipeline_coupling_stage

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    heroku_pipeline.pipeline
  ]
}