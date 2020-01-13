#---------------------------------------------------
# ELB attachment
#---------------------------------------------------
resource "aws_elb_attachment" "elb_attachment" {
    count       = var.enable_elb_attachment ? length(var.instances) : 0

    elb         = var.elb_id != "" ? var.elb_id : element(concat(aws_elb.elb.*.id, [""]), 0)
    instance    = var.instances[count.index]

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
    
    depends_on  = [
        aws_elb.elb
    ]
}