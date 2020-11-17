#---------------------------------------------------
# Add a record to the domain
#---------------------------------------------------
resource "cloudflare_record" "record" {
  count = var.enable_record ? 1 : 0

  name    = var.record_name
  zone_id = var.record_zone_id
  type    = var.record_type

  value    = var.record_value
  data     = var.record_data
  ttl      = var.record_ttl
  priority = var.record_priority
  proxied  = var.record_proxied

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
