#---------------------------------------------------
# Heroku pipeline
#---------------------------------------------------
resource "heroku_pipeline" "pipeline" {
  count = var.enable_pipeline ? 1 : 0

  name = var.pipeline_name

  dynamic "owner" {
    iterator = owner
    for_each = var.pipeline_owner
    content {
      id   = lookup(owner.value, "id", null)
      type = lookup(owner.value, "type", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}