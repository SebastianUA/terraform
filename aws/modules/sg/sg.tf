#---------------------------------------------------
# Create security group
#---------------------------------------------------
resource "aws_security_group" "sg" {
    count               = "${var.enable_sg_creating && length(var.vpc_id) > 0 ? 1 : 0}"

    name                = "${var.name}-sg-${var.environment}"
    description         = "Security Group ${var.name}-sg-${var.environment}"
    vpc_id              = "${var.vpc_id}"
    
    tags {
        Name            = "${var.name}-sg-${var.environment}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
  
    lifecycle {
        create_before_destroy = true,
        ignore_changes = []
    }
}
#---------------------------------------------------
# Add security group rules 
#---------------------------------------------------
resource "aws_security_group_rule" "ingress_ports" {
    count               = "${var.enable_sg_creating && length(var.allowed_ports) > 0 ? length(var.allowed_ports) : 0}"
    
    type                = "ingress"
    security_group_id   = "${aws_security_group.sg.id}"
    from_port           = "${element(var.allowed_ports, count.index)}"
    to_port             = "${element(var.allowed_ports, count.index)}"
    protocol            = "tcp"
    cidr_blocks         = ["${var.allow_cidrs_for_allowed_ports[element(var.allowed_ports, count.index)]}"]
    
    lifecycle {
        create_before_destroy = true,
        ignore_changes = []
    }

    depends_on          = ["aws_security_group.sg"]
}
resource "aws_security_group_rule" "egress_ports" {
    count               = "${var.enable_sg_creating && var.enable_all_egress_ports ? 0 : length(var.allowed_ports)}"

    type                = "egress"
    security_group_id   = "${aws_security_group.sg.id}"
    from_port           = "${element(var.allowed_ports, count.index)}"
    to_port             = "${element(var.allowed_ports, count.index)}"
    protocol            = "tcp"
    cidr_blocks         = ["${var.allow_cidrs_for_allowed_ports[element(var.allowed_ports, count.index)]}"] 

    lifecycle {
        create_before_destroy = true,
        ignore_changes = []
    }

    depends_on          = ["aws_security_group.sg"]
}
resource "aws_security_group_rule" "icmp-self" {
    count             = "${var.enable_sg_creating ? 1 : 0}"

    security_group_id   = "${aws_security_group.sg.id}"
    type                = "ingress"
    protocol            = "icmp"
    from_port           = -1
    to_port             = -1
    self                = true
    
    lifecycle {
        create_before_destroy = true,
        ignore_changes = []
    }

    depends_on          = ["aws_security_group.sg"]
}
resource "aws_security_group_rule" "allow_all_traffic_for_set_sg" {
    count             = "${var.enable_sg_creating ? 1 : 0}"

    type              = "ingress"
    security_group_id = "${aws_security_group.sg.id}"
    from_port         = "1"
    to_port           = "65535"
    protocol          = "all"
    self              = true

    lifecycle {
        create_before_destroy = true,
        ignore_changes = []
    }

    depends_on        = ["aws_security_group.sg"]
}
resource "aws_security_group_rule" "default_egress" {
    count             = "${var.enable_sg_creating && var.enable_all_egress_ports ? 1 : 0}"

    type              = "egress"
    security_group_id = "${aws_security_group.sg.id}"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    
    lifecycle {
        create_before_destroy = true,
        ignore_changes = []
    }

    depends_on        = ["aws_security_group.sg"]
}
resource "aws_security_group_rule" "custom_sg_rule_with_cidr_blocks" {
    count             = "${var.enable_sg_creating && var.enable_custom_sg_rule_with_cidr_blocks && !var.enable_custom_sg_rule_with_self ? 1 : 0}"

    type              = "${var.sg_rule_type}"
    security_group_id = "${aws_security_group.sg.id}"
    from_port         = "${var.sg_rule_from_port}"
    to_port           = "${var.sg_rule_to_port}"
    protocol          = "${var.sg_rule_protocol}"
    cidr_blocks       = ["${var.sg_rule_cidr_blocks}"]

    lifecycle {
        create_before_destroy = true,
        ignore_changes = []
    }
 
    depends_on        = ["aws_security_group.sg"]
}
resource "aws_security_group_rule" "custom_sg_rule_with_self" {
    count             = "${var.enable_sg_creating && !var.enable_custom_sg_rule_with_cidr_blocks && var.enable_custom_sg_rule_with_self ? 1 : 0}"

    type              = "${var.sg_rule_type}"
    security_group_id = "${aws_security_group.sg.id}"
    from_port         = "${var.sg_rule_from_port}"
    to_port           = "${var.sg_rule_to_port}"
    protocol          = "${var.sg_rule_protocol}"
    self              = true

    lifecycle {
        create_before_destroy = true,
        ignore_changes = []
    }

    depends_on        = ["aws_security_group.sg"]
}


