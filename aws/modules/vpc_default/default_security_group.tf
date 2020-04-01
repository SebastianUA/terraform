#---------------------------------------------------
# AWS default security group
#---------------------------------------------------
resource "aws_default_security_group" "default_security_group" {
    count                   = var.enable_default_vpc ? 1 : 0

    vpc_id                  = element(concat(aws_default_vpc.default_vpc.*.id, [""]), 0)

    ingress {
        protocol  = -1
        self      = true
        from_port = 0
        to_port   = 0
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags                    = merge(
        {
            "Name"  = var.default_security_group_name != "" ? lower(var.default_security_group_name) : "default"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = [
        aws_default_vpc.default_vpc
    ]
}
