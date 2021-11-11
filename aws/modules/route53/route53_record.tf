#---------------------------------------------------
# AWS Route53 record
#---------------------------------------------------
resource "aws_route53_record" "route53_record" {
  count = var.enable_route53_record ? 1 : 0

  name    = var.route53_record_name
  zone_id = var.route53_record_parent_zone_id != "" && !var.enable_route53_zone ? var.route53_record_parent_zone_id : element(aws_route53_zone.route53_zone.*.id, 0)
  type    = var.route53_record_type
  ttl     = var.route53_record_ttl
  records = var.route53_record_records

  health_check_id                  = var.route53_record_health_check_id != null && !var.enable_route53_health_check ? var.route53_record_health_check_id : element(concat(aws_route53_health_check.route53_health_check.*.id, [""]), 0)
  multivalue_answer_routing_policy = var.route53_record_multivalue_answer_routing_policy
  allow_overwrite                  = var.route53_record_allow_overwrite

  set_identifier = var.route53_record_set_identifier != null ? lower(var.route53_record_set_identifier) : null

  dynamic "failover_routing_policy" {
    iterator = failover_routing_policy
    for_each = var.route53_record_failover_routing_policy

    content {
      type = lookup(failover_routing_policy.value, "type", null)
    }
  }

  dynamic "geolocation_routing_policy" {
    iterator = geolocation_routing_policy
    for_each = var.route53_record_geolocation_routing_policy

    content {
      continent   = lookup(geolocation_routing_policy.value, "continent", null)
      country     = lookup(geolocation_routing_policy.value, "country", null)
      subdivision = lookup(geolocation_routing_policy.value, "subdivision", null)
    }
  }

  dynamic "latency_routing_policy" {
    iterator = latency_routing_policy
    for_each = var.route53_record_latency_routing_policy

    content {
      region = lookup(latency_routing_policy.value, "region", null)
    }
  }

  dynamic "weighted_routing_policy" {
    iterator = weighted_routing_policy
    for_each = var.route53_record_weighted_routing_policy

    content {
      weight = lookup(weighted_routing_policy.value, "weight", null)
    }
  }

  dynamic "alias" {
    iterator = alias
    for_each = var.route53_record_alias

    content {
      name                   = lookup(alias.value, "name", null)
      zone_id                = lookup(alias.value, "zone_id", null)
      evaluate_target_health = lookup(alias.value, "evaluate_target_health", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route53_zone.route53_zone,
    aws_route53_health_check.route53_health_check
  ]
}
