#---------------------------------------------------
# Create AWS NLB
#---------------------------------------------------
resource "aws_lb" "lb" {                      
    #name_prefix        = "${var.name_prefix}-"
    name                = "${lower(var.name)}-nlb-${lower(var.environment)}"
    subnets             = ["${var.subnets}"]
    internal            = "${var.lb_internal}"
                        
    enable_deletion_protection  = "${var.enable_deletion_protection}"   
    load_balancer_type          = "${var.load_balancer_type}"
    idle_timeout                = "${var.idle_timeout}"
    ip_address_type             = "${var.ip_address_type}"
    
    timeouts {
        create  = "${var.timeouts_create}"
        update  = "${var.timeouts_update}"   
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        create_before_destroy = true
    }

    tags {
        Name            = "${lower(var.name)}-nlb-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}
#---------------------------------------------------
# Create AWS LB target group
#---------------------------------------------------
resource "aws_lb_target_group" "lb_target_group" {                                                                              
    name                 = "${lower(var.name)}-nlb-tg-${lower(var.environment)}"
    port                 = "${var.backend_port}"
    protocol             = "${upper(var.backend_protocol)}"
    vpc_id               = "${var.vpc_id}"
    target_type          = "${var.target_type}"
    deregistration_delay = "${var.deregistration_delay}"

    tags {                                                                                                                          
        Name            = "${lower(var.name)}-nlb-tg-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    health_check {
        interval            = "${var.health_check_interval}"
        port                = "${var.health_check_port}"
        healthy_threshold   = "${var.health_check_healthy_threshold}"
        unhealthy_threshold = "${var.health_check_unhealthy_threshold}"
        protocol            = "${var.backend_protocol}"
    }
}    
#---------------------------------------------------
# Create AWS LB listeners
#---------------------------------------------------
resource "aws_lb_listener" "frontend_tcp_80" {
    count               = "${trimspace(element(split(",", var.alb_protocols), 1)) == "TCP" ? 1 : 0}"

    load_balancer_arn   = "${aws_lb.lb.arn}"
    port                = "80"
    protocol            = "TCP"

    "default_action" {
        target_group_arn    = "${aws_lb_target_group.lb_target_group.arn}"
        type                = "forward"
    }

    depends_on = ["aws_lb.lb","aws_lb_target_group.lb_target_group"]
}
resource "aws_lb_listener" "frontend_tcp_443" {
    count               = "${trimspace(element(split(",", var.alb_protocols), 1)) == "TCP" ? 1 : 0}"

    load_balancer_arn   = "${aws_lb.lb.arn}"
    port                = "443"
    protocol            = "TCP"

    "default_action" {
        target_group_arn    = "${aws_lb_target_group.lb_target_group.arn}"
        type                = "forward"
    }

    depends_on = ["aws_lb.lb","aws_lb_target_group.lb_target_group"]
}
#---------------------------------------------------
# Create AWS LB target group attachment
#---------------------------------------------------
resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
    count               = "${length(var.target_ids) > 0 ? length(var.target_ids) : 0}"
                                                    
    #availability_zone   = "all"
    target_id           = "${element(var.target_ids, count.index)}"
    port                = "${var.backend_port}"
    target_group_arn    = "${aws_lb_target_group.lb_target_group.arn}"

    depends_on = ["aws_lb_target_group.lb_target_group"]
}
