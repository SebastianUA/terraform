#---------------------------------------------------
# AWS ELB attachment
#---------------------------------------------------
resource "aws_elb_attachment" "elb_attachment" {
  count = var.enable_elb_attachment ? length(var.elb_attachment_instances) : 0

  elb      = var.elb_attachment_elb_id != "" ? var.elb_attachment_elb_id : aws_elb.elb[0].id
  instance = var.elb_attachment_instances[count.index]

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elb.elb
  ]
}
