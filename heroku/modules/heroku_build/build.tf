#---------------------------------------------------
# Heroku build
#---------------------------------------------------
resource "heroku_build" "build" {
  count = var.enable_build ? 1 : 0

  app    = var.build_app
  source = var.build_source

  buildpacks = var.build_buildpacks

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
