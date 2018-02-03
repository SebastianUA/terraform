#---------------------------------------------------
# Create AWS ELB
#---------------------------------------------------
resource "aws_elb" "elb" {
    name                = "${var.name}-elb-${var.environment}"
    #availability_zones  = ["${split(",", (lookup(var.availability_zones, var.region)))}"]
    security_groups     = ["${var.security_groups}"]
    subnets             = ["${var.subnets}"]
    internal            = false #"${var.elb_internal}"
    
    #instances                   = ["${var.instances}"]
    cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
    idle_timeout                = "${var.idle_timeout}"
    connection_draining         = "${var.connection_draining}"
    connection_draining_timeout = "${var.connection_draining_timeout}"

    access_logs                 = ["${var.access_logs}"]
    listener                    = ["${var.listener}"]
    health_check                = ["${var.health_check}"]
    
    tags {
        Name            = "${lower(var.name)}-elb-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}
#---------------------------------------------------
# ELB attachment
#---------------------------------------------------
resource "aws_elb_attachment" "elb_attachment" {
    count       = "${length(var.instances)}"
    
    #elb         = "${var.name}-elb_attachment-${var.environment}"
    elb         = "${aws_elb.elb.name}"
    instance    = "${element(var.instances, count.index)}"
    
    depends_on  = ["aws_elb.elb"]
}
#---------------------------------------------------
# Add LB cookie stickiness policy
#---------------------------------------------------
resource "aws_lb_cookie_stickiness_policy" "lb_cookie_stickiness_policy_http" {
    name                        = "${var.name}-lb-cookie-stickiness-policy-http-${var.environment}"
    load_balancer               = "${aws_elb.elb.id}"
    lb_port                     = 80
    cookie_expiration_period    = 600
        
    depends_on                  = ["aws_elb.elb"]
}
#resource "aws_lb_cookie_stickiness_policy" "lb_cookie_stickiness_policy_https" {
#    name                        = "${var.name}-lb_cookie-stickiness-policy-https-${var.environment}"
#    load_balancer               = "${aws_elb.elb.id}"
#    lb_port                     = 443
#    cookie_expiration_period    = 600
#
#    depends_on                  = ["aws_elb.elb"]
#}
#---------------------------------------------------
#Add APP cookie stickiness policy
#---------------------------------------------------
resource "aws_app_cookie_stickiness_policy" "app_cookie_stickiness_policy_http" {
    name                     = "${var.name}-app-cookie-stickiness-policy-http-${var.environment}"
    load_balancer            = "${aws_elb.elb.id}"
    lb_port                  = 80
    cookie_name              = "JSESSIONID"

    depends_on               = ["aws_elb.elb"]
}
#resource "aws_app_cookie_stickiness_policy" "app_cookie_stickiness_policy_https" {
#    name                     = "${var.name}-app-cookie-stickiness-policy-https-${var.environment}"
#    load_balancer            = "${aws_elb.elb.id}"
#    lb_port                  = 443
#    cookie_name              = "JSESSIONID"
#  
#    depends_on               = ["aws_elb.elb"]
#}
