#---------------------------------------------------
# AWS simpledb domain
#---------------------------------------------------
resource "aws_simpledb_domain" "simpledb_domain" {
  count = var.enable_simpledb_domain ? 1 : 0

  name = var.simpledb_domain_name != "" ? lower(var.simpledb_domain_name) : "${lower(var.name)}-simpledb-domain-${lower(var.environment)}"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
