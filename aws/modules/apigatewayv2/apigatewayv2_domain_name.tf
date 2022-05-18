#---------------------------------------------------
# AWS API Gateway v2 domain name
#---------------------------------------------------
resource "aws_apigatewayv2_domain_name" "apigatewayv2_domain_name" {
  count = var.enable_apigatewayv2_domain_name ? 1 : 0

  domain_name = var.apigatewayv2_domain_name_domain_name

  dynamic "domain_name_configuration" {
    iterator = domain_name_configuration
    for_each = length(keys(var.apigatewayv2_domain_name_domain_name_configuration)) > 0 ? [var.apigatewayv2_domain_name_domain_name_configuration] : []

    content {
      certificate_arn = lookup(domain_name_configuration.value, "certificate_arn", null)
      endpoint_type   = lookup(domain_name_configuration.value, "endpoint_type", null)
      security_policy = lookup(domain_name_configuration.value, "security_policy", null)

      hosted_zone_id                         = lookup(domain_name_configuration.value, "hosted_zone_id", null)
      ownership_verification_certificate_arn = lookup(domain_name_configuration.value, "ownership_verification_certificate_arn", null)
      target_domain_name                     = lookup(domain_name_configuration.value, "target_domain_name", null)
    }
  }

  dynamic "mutual_tls_authentication" {
    iterator = mutual_tls_authentication
    for_each = length(keys(lookup(var.apigatewayv2_domain_name_mutual_tls_authentication, "mutual_tls_authentication", {}))) > 0 ? [lookup(var.apigatewayv2_domain_name_mutual_tls_authentication, "mutual_tls_authentication", {})] : []

    content {
      truststore_uri = lookup(mutual_tls_authentication.value, "truststore_uri", null)

      truststore_version = lookup(mutual_tls_authentication.value, "truststore_version", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.apigatewayv2_domain_name_timeouts)) > 0 ? [var.apigatewayv2_domain_name_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}