#---------------------------------------------------
# Create AWS ALB 
#---------------------------------------------------
resource "aws_lb" "alb" {                      
    #name_prefix        = "${var.name_prefix}-"
    name                = "${lower(var.name)}-alb-${lower(var.environment)}"
    security_groups     = ["${var.security_groups}"]
    subnets             = ["${var.subnets}"]
    internal            = "${var.lb_internal}"

    enable_deletion_protection  = "${var.enable_deletion_protection}"   
    load_balancer_type          = "${var.load_balancer_type}"
    idle_timeout                = "${var.idle_timeout}"
    ip_address_type             = "${var.ip_address_type}"
    
    access_logs         = ["${var.access_logs}"]
   
    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"   
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        create_before_destroy = true
    }

    tags {
        Name            = "${lower(var.name)}-alb-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}
#---------------------------------------------------
# Create AWS LB target group
#---------------------------------------------------
resource "aws_lb_target_group" "alb_target_group" {
    name                 = "${lower(var.name)}-alb-tg-${lower(var.environment)}"
    port                 = "${var.backend_port}"
    protocol             = "${upper(var.backend_protocol)}"
    vpc_id               = "${var.vpc_id}"
    target_type          = "${var.target_type}"
    deregistration_delay = "${var.deregistration_delay}"

    tags {
        Name            = "${lower(var.name)}-alb-tg-${lower(var.environment)}"
        Environment     = "${var.environment}"                      
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    health_check {
        interval            = "${var.health_check_interval}"
        path                = "${var.health_check_path}"
        port                = "${var.health_check_port}"
        healthy_threshold   = "${var.health_check_healthy_threshold}"
        unhealthy_threshold = "${var.health_check_unhealthy_threshold}"
        timeout             = "${var.health_check_timeout}"
        protocol            = "${var.backend_protocol}"
        matcher             = "${var.health_check_matcher}"
    }
    stickiness {
        type            = "lb_cookie"
        cookie_duration = "${var.cookie_duration}"
        enabled         = "${var.cookie_duration != 1 ? true : false}"
    }
}    
#---------------------------------------------------
# Create AWS LB listeners
#---------------------------------------------------
resource "aws_lb_listener" "frontend_http" {                                                
    count               = "${trimspace(element(split(",", var.alb_protocols), 1)) == "HTTP" || trimspace(element(split(",", var.alb_protocols), 2)) == "HTTP" ? 1 : 0}"
        
    load_balancer_arn   = "${aws_lb.alb.arn}"
    port                = "80"
    protocol            = "HTTP"
    
    "default_action" {
        target_group_arn    = "${aws_lb_target_group.alb_target_group.arn}"
        type                = "forward"
    }
    
    depends_on = ["aws_lb.alb","aws_lb_target_group.alb_target_group"]
}
    
resource "aws_lb_listener" "frontend_https" {                                           
    count               = "${trimspace(element(split(",", var.alb_protocols), 1)) == "HTTPS" || trimspace(element(split(",", var.alb_protocols), 2)) == "HTTPS" ? 1 : 0}"
        
    load_balancer_arn   = "${aws_lb.alb.arn}"
    port                = 443
    protocol            = "HTTPS"
    certificate_arn     = "${var.certificate_arn}"
    ssl_policy          = "ELBSecurityPolicy-2016-08"
    default_action {
        target_group_arn    = "${aws_lb_target_group.alb_target_group.arn}"
        type                = "forward"
    }

    depends_on = ["aws_lb.alb","aws_lb_target_group.alb_target_group"]
}
#---------------------------------------------------
# Create AWS LB target group attachment
#---------------------------------------------------
resource "aws_lb_target_group_attachment" "alb_target_group_attachment" {
    count               = "${length(var.target_ids) > 0 ? length(var.target_ids) : 0 }"
                                    
    #availability_zone   = "all"
    target_group_arn    = "${aws_lb_target_group.alb_target_group.arn}"
    target_id           = "${element(var.target_ids, count.index)}"
    port                = "${var.backend_port}"

    depends_on = ["aws_lb.alb","aws_lb_target_group.alb_target_group"]
}

