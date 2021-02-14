#---------------------------------------------------
# AWS default network acl
#---------------------------------------------------
resource "aws_default_network_acl" "default_network_acl" {
  count = var.enable_default_vpc ? 1 : 0

  default_network_acl_id = element(concat(aws_default_vpc.default_vpc.*.default_network_acl_id, [""]), 0)

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = merge(
    {
      Name = var.default_network_acl_name != "" ? lower(var.default_network_acl_name) : "default"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_default_vpc.default_vpc
  ]
}
