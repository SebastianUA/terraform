#---------------------------------------------------
# Create AWS ELB
#---------------------------------------------------
resource "aws_elb" "elb" {
    name                = "${lower(var.name)}-elb-${lower(var.environment)}"
    # can be use availability_zones or subnets....
    #availability_zones  = ["${split(",", (lookup(var.availability_zones, var.region)))}"] #["us-east-1a", "us-east-1b"]
    subnets             = ["${var.subnets}"]
    security_groups     = ["${var.security_groups}"]
    internal            = "${var.elb_internal}"
    
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
    
    elb         = "${aws_elb.elb.name}"
    instance    = "${element(var.instances, count.index)}"
    
    depends_on  = ["aws_elb.elb"]
}
#---------------------------------------------------
# Add LB cookie stickiness policy
#---------------------------------------------------
resource "aws_lb_cookie_stickiness_policy" "lb_cookie_stickiness_policy_http" {
    count                       = "${var.enable_lb_cookie_stickiness_policy_http ? 1 : 0}"
    
    name                        = "${lower(var.name)}-lb-cookie-stickiness-policy-http-${lower(var.environment)}"
    load_balancer               = "${aws_elb.elb.id}"
    lb_port                     = "${var.http_lb_port}"
    cookie_expiration_period    = "${var.cookie_expiration_period}"
                                
    depends_on                  = ["aws_elb.elb"]
}
resource "aws_lb_cookie_stickiness_policy" "lb_cookie_stickiness_policy_https" {
    count                       = "${var.enable_lb_cookie_stickiness_policy_http ? 0 : 1}"
    
    name                        = "${lower(var.name)}-lb_cookie-stickiness-policy-https-${lower(var.environment)}"
    load_balancer               = "${aws_elb.elb.id}"
    lb_port                     = "${var.https_lb_port}"
    cookie_expiration_period    = "${var.cookie_expiration_period}"

    depends_on                  = ["aws_elb.elb"]
}
#---------------------------------------------------
#Add APP cookie stickiness policy
#---------------------------------------------------
resource "aws_app_cookie_stickiness_policy" "app_cookie_stickiness_policy_http" {
    count                    = "${var.enable_app_cookie_stickiness_policy_http ? 1 : 0}"
    
    name                     = "${lower(var.name)}-app-cookie-stickiness-policy-http-${lower(var.environment)}"
    load_balancer            = "${aws_elb.elb.id}"
    lb_port                  = "${var.http_lb_port}"
    cookie_name              = "${var.cookie_name}"

    depends_on               = ["aws_elb.elb"]
}
resource "aws_app_cookie_stickiness_policy" "app_cookie_stickiness_policy_https" {
    count                    = "${var.enable_app_cookie_stickiness_policy_http ? 0 : 1}"
    
    name                     = "${lower(var.name)}-app-cookie-stickiness-policy-https-${lower(var.environment)}"
    load_balancer            = "${aws_elb.elb.id}"
    lb_port                  = "${var.https_lb_port}"
    cookie_name              = "${var.cookie_name}"
  
    depends_on               = ["aws_elb.elb"]
}
