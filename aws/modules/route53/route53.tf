#---------------------------------------------------
# Create AWS route53 zone(s)
#---------------------------------------------------
resource "aws_route53_zone" "primary_public" {
    count           = "${var.create_primary_public_route53_zone ? signum(length(compact(var.route53_record_names))) : 0}"
    
    name            = "${var.domain_name_for_primary_public_route53_zone}"
    comment         = "Public zone for ${var.domain_name_for_primary_public_route53_zone}"
    
    tags {
        Name            = "${lower(var.name)}-route53_primary_public_zone-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

}
#---------------------------------------------------
# Create AWS Route53 record(s)
#---------------------------------------------------
resource "aws_route53_record" "route53_record" {
    count   = "${length(compact(var.route53_record_names))}"
    
    name    = "${element(compact(var.route53_record_names), count.index)}"
    zone_id = "${var.create_primary_public_route53_zone ? aws_route53_zone.primary_public.zone_id : var.parent_zone_id}"
    type    = "${var.route53_record_type}"
    #ttl     = "${var.route53_record_ttl}"
    #weighted_routing_policy {
    #    weight = 10
    #
    #}
    #set_identifier = "dev"
    #records = ["${var.route53_record_records}"]
    #failover_routing_policy {
    #    type = "PRIMARY"
    #}
    alias {
        name                   = "${var.target_dns_name}" 
        zone_id                = "${var.target_zone_id}" 
        evaluate_target_health = "${var.evaluate_target_health}"
    }
    
    depends_on  = ["aws_route53_zone.primary_public"]
}
#---------------------------------------------------
# Create AWS route53 health check(s)
#---------------------------------------------------
resource "aws_route53_health_check" "http_route53_health_check" {
    count             = "${var.create_http_route53_health_check ? 1 : 0}"
    
    fqdn              = "${var.fqdn_for_http_route53_health_check}"
    port              = "${var.port_for_http_route53_health_check}"
    type              = "${var.type_for_http_route53_health_check}"
    resource_path     = "${var.resource_path_for_http_route53_health_check}"
    failure_threshold = "${var.failure_threshold_for_http_route53_health_check}"
    request_interval  = "${var.request_interval_for_http_route53_health_check}"
    measure_latency   = "${var.measure_latency_for_http_route53_health_check}"

    tags {
        Name            = "${lower(var.name)}-http_route53_health_check-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}
resource "aws_route53_health_check" "https_route53_health_check" {
    count             = "${var.create_https_route53_health_check ? 1 : 0}"

    fqdn              = "${var.fqdn_for_https_route53_health_check}"
    port              = "${var.port_for_https_route53_health_check}"
    type              = "${var.type_for_https_route53_health_check}"
    resource_path     = "${var.resource_path_for_https_route53_health_check}"
    failure_threshold = "${var.failure_threshold_for_https_route53_health_check}"
    request_interval  = "${var.request_interval_for_https_route53_health_check}"
    measure_latency   = "${var.measure_latency_for_https_route53_health_check}"

    tags {
        Name            = "${lower(var.name)}-https_route53_health_check-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}

#---------------------------------------------------
# Create AWS api gateway domain name
#---------------------------------------------------
#resource "aws_api_gateway_domain_name" "example" {
#    domain_name = "api.example.com"
#
#    certificate_name        = "example-api"
#    certificate_body        = "${file("${path.module}/example.com/example.crt")}"
#    certificate_chain       = "${file("${path.module}/example.com/ca.crt")}"
#    certificate_private_key = "${file("${path.module}/example.com/example.key")}"
#}
# Example DNS record using Route53.
# Route53 is not specifically required; any DNS host can be used.
#resource "aws_route53_record" "example" {
#  zone_id = "${aws_route53_zone.example.id}" # See aws_route53_zone for how to create this
#
#  name = "${aws_api_gateway_domain_name.example.domain_name}"
#  type = "A"
#
#  alias {
#    name                   = "${aws_api_gateway_domain_name.example.cloudfront_domain_name}"
#    zone_id                = "${aws_api_gateway_domain_name.example.cloudfront_zone_id}"
#    evaluate_target_health = true
#  }
#}
