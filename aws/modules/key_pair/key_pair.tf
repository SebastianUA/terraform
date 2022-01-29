#---------------------------------------------------
# AWS key pair
#---------------------------------------------------
resource "aws_key_pair" "key_pair" {
  count = var.enable_key_pair ? 1 : 0

  public_key = var.key_pair_public_key

  key_name        = var.key_pair_key_name != null && var.key_pair_key_name_prefix == null ? var.key_pair_key_name : null
  key_name_prefix = var.key_pair_key_name_prefix != null && var.key_pair_key_name == null ? var.key_pair_key_name_prefix : null

  tags = merge(
    {
      Name = var.key_pair_key_name != null && var.key_pair_key_name_prefix == null ? var.key_pair_key_name : var.key_pair_key_name_prefix
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []

}
