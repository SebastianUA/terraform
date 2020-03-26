#---------------------------------------------------
# Create AWS NLB listeners
#---------------------------------------------------
resource "aws_lb_listener" "nlb_listener1" {
    count               = var.enable_nlb_listener1 && trimspace(element(split(",", var.alb_protocols), 1)) == "TCP" ? 1 : 0

    load_balancer_arn   = var.load_balancer_arn != "" ? var.load_balancer_arn : element(concat(aws_lb.nlb.*.arn, [""]), 0)
    port                = var.nlb_listener1_port
    protocol            = upper(var.nlb_listener1_protocol)

    default_action {
        target_group_arn    = var.nlb_listener1_default_action_target_group_arn != "" ? var.nlb_listener1_default_action_target_group_arn : element(aws_lb_target_group.nlb_target_group.*.arn, 0)
        type                = var.nlb_listener1_default_action_type
    }

    #dynamic "default_action" {
    #    for_each = var.nlb_listener1_default_action
    #    content {
    #        target_group_arn    = lookup(nlb_listener1_default_action.value, "target_group_arn", element(aws_lb_target_group.nlb_target_group.*.arn, 0))
    #        type                = lookup(nlb_listener1_default_action.value, "type", "forward")
    #    }
    #}

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_lb.nlb,
        aws_lb_target_group.nlb_target_group
    ]
}

resource "aws_lb_listener" "nlb_listener2" {
    count               = var.enable_nlb_listener2 && trimspace(element(split(",", var.alb_protocols), 1)) == "TCP" ? 1 : 0

    load_balancer_arn   = var.load_balancer_arn != "" ? var.load_balancer_arn : element(concat(aws_lb.nlb.*.arn, [""]), 0)
    port                = var.nlb_listener2_port
    protocol            = upper(var.nlb_listener2_protocol)

    default_action {
        target_group_arn    = var.nlb_listener2_default_action_target_group_arn != "" ? var.nlb_listener2_default_action_target_group_arn : element(aws_lb_target_group.nlb_target_group.*.arn, 0)
        type                = var.nlb_listener2_default_action_type
    }

    #dynamic "default_action" {
    #    for_each = var.nlb_listener2_default_action
    #    content {
    #        target_group_arn    = lookup(nlb_listener2_default_action.value, "target_group_arn", null)
    #        type                = lookup(nlb_listener2_default_action.value, "type",  null)
    #        #target_group_arn    = lookup(nlb_listener2_default_action.value, "target_group_arn", element(concat(aws_lb_target_group.nlb_target_group.*.arn, [""]), 0))
    #        #type                = lookup(nlb_listener2_default_action.value, "type",  "forward")
    #    }
    #}

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_lb.nlb,
        aws_lb_target_group.nlb_target_group
    ]
}
