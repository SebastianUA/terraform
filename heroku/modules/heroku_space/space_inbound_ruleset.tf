#---------------------------------------------------
# Heroku space inbound ruleset
#---------------------------------------------------
resource "heroku_space_inbound_ruleset" "space_inbound_ruleset" {
  count = var.enable_space_inbound_ruleset ? 1 : 0

  space = var.space_inbound_ruleset_space != "" ? var.space_inbound_ruleset_space : (var.enable_space ? element(heroku_space.space.*.id, 0) : null)

  dynamic "rule" {
    iterator = rule
    for_each = var.space_inbound_ruleset_rule

    content {
      action = lookup(rule.value, "action", null)
      source = lookup(rule.value, "source", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    heroku_space.space
  ]
}