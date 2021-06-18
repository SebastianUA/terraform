#---------------------------------------------------
# AWS ses receipt filter
#---------------------------------------------------
resource "aws_ses_receipt_filter" "ses_receipt_filter" {
  count = var.enable_ses_receipt_filter ? length(var.ses_receipt_filter_stack) : 0

  name   = lookup(var.ses_receipt_filter_stack[count.index], "name", "${lower(var.name)}-ses-receipt-filter-${lower(var.environment)}-${count.index}")
  cidr   = lookup(var.ses_receipt_filter_stack[count.index], "cidr", null)
  policy = lookup(var.ses_receipt_filter_stack[count.index], "policy", null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}