#---------------------------------------------------
# AWS elasticsearch domain policy
#---------------------------------------------------
resource "aws_elasticsearch_domain_policy" "elasticsearch_domain_policy" {
  count = var.enable_elasticsearch_domain_policy ? 1 : 0

  domain_name = var.elasticsearch_domain_policy_domain_name != "" ? var.elasticsearch_domain_policy_domain_name : (var.enable_elasticsearch_domain ? aws_elasticsearch_domain.elasticsearch_domain[0].domain_name : null)

  access_policies = var.elasticsearch_domain_policy_access_policies

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elasticsearch_domain.elasticsearch_domain
  ]
}