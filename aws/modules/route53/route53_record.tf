#---------------------------------------------------
# Create AWS Route53 record(s)
#---------------------------------------------------
resource "aws_route53_record" "route53_record" {
    count                               = var.enable_route53_record ? 1 : 0

    name                                = var.route53_record_name
    zone_id                             = !var.enable_route53_zone && var.parent_zone_id != "" ? var.parent_zone_id : element(concat(aws_route53_zone.route53_zone.*.id, [""]), 0)
    type                                = var.route53_record_type
    ttl                                 = var.route53_record_ttl
    records                             = var.route53_record_records

    health_check_id                     = var.health_check_id != null && !var.enable_route53_health_check ? var.health_check_id : element(concat(aws_route53_health_check.route53_health_check.*.id, [""]), 0)
    multivalue_answer_routing_policy    = var.multivalue_answer_routing_policy
    allow_overwrite                     = var.allow_overwrite

    dynamic "failover_routing_policy" {
        for_each = var.failover_routing_policy
        content {
            type    = lookup(failover_routing_policy.value, "type",  null)
        }
    }

    dynamic "geolocation_routing_policy" {
        for_each = var.geolocation_routing_policy
        content {
            continent   = lookup(geolocation_routing_policy.value, "continent",  null)
            country     = lookup(geolocation_routing_policy.value, "country",  null)
            subdivision = lookup(geolocation_routing_policy.value, "subdivision",  null)
        }
    }

    dynamic "latency_routing_policy" {
        for_each = var.latency_routing_policy
        content {
            region   = lookup(latency_routing_policy.value, "region",  null)
        }
    }

    dynamic "weighted_routing_policy" {
        for_each = var.weighted_routing_policy
        content {
            weight = lookup(weighted_routing_policy.value, "weight",  null)
        }
    }

    dynamic "alias" {
        for_each = var.route53_record_alias
        content {
            name                   = lookup(route53_record_alias.value, "name",  null)
            zone_id                = lookup(route53_record_alias.value, "zone_id",  null)
            evaluate_target_health = lookup(route53_record_alias.value, "evaluate_target_health",  null)
        }
    }

    set_identifier                      = var.set_identifier != null ? lower(var.set_identifier) : null

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                          = [
        aws_route53_zone.route53_zone,
        aws_route53_health_check.route53_health_check
    ]
}
