#---------------------------------------------------
# Add a record to the domain
#---------------------------------------------------
resource "cloudflare_record" "record" {
    count           = var.enable_cloudflare_record && !var.enable_cloudflare_record_data ? 1 : 0
    
    zone_id         = "var.zone_id"
    name            = "var.name"
    type            = "var.type"

    value           = "var.value"
    ttl             = var.ttl
    priority        = var.priority
    proxied         = var.proxied
}

resource "cloudflare_record" "record_with_data" {
    count           = var.enable_cloudflare_record && var.enable_cloudflare_record_data ? 1 : 0
    
    zone_id         = "var.zone_id"
    name            = "var.name"
    type            = "var.type"

    data            = var.data
    ttl             = var.ttl
    priority        = var.priority
    proxied         = var.proxied
}
