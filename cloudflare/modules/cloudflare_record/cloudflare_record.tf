#---------------------------------------------------
# Add a record to the domain
#---------------------------------------------------
resource "cloudflare_record" "record" {
    count   = "${var.domain !="" && var.name !="" && var.value !="" ? 1 : 0}"
    
    domain      = "${var.domain}"
    name        = "${var.name}"
    value       = "${var.value}"
    type        = "${var.type}"
    ttl         = "${var.ttl}"
    priority    = "${var.priority}"
    proxied     = "${var.proxied}"
}
