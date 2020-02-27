#---------------------------------------------------
# Add LB cookie stickiness policy
#---------------------------------------------------
resource "aws_lb_cookie_stickiness_policy" "lb_cookie_stickiness_policy_http" {
    count                       = var.enable_lb_cookie_stickiness_policy_http ? 1 : 0

    name                        = var.lb_cookie_stickiness_policy_http_name != "" ? var.lb_cookie_stickiness_policy_http_name : "${lower(var.name)}-lb-cookie-stickiness-policy-http-${lower(var.environment)}"
    load_balancer               = var.elb_id != "" ? var.elb_id : element(concat(aws_elb.elb.*.id, [""]), 0)
    lb_port                     = var.http_lb_port
    cookie_expiration_period    = var.cookie_expiration_period

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = [
        aws_elb.elb
    ]
}
resource "aws_lb_cookie_stickiness_policy" "lb_cookie_stickiness_policy_https" {
    count                       = var.enable_lb_cookie_stickiness_policy_http ? 0 : 1

    name                        = var.lb_cookie_stickiness_policy_https_name != "" ? var.lb_cookie_stickiness_policy_https_name : "${lower(var.name)}-lb_cookie-stickiness-policy-https-${lower(var.environment)}"
    load_balancer               = var.elb_id != "" ? var.elb_id : element(concat(aws_elb.elb.*.id, [""]), 0)
    lb_port                     = var.https_lb_port
    cookie_expiration_period    = var.cookie_expiration_period

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = [
        aws_elb.elb
    ]
}
