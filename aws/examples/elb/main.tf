#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region  = "us-east-1"
}

module "elb" {
    source                      = "../../modules/elb"
    name                        = "TEST"
    region                      = "us-east-1"
    environment                 = "test"

    enable_elb                  = true
    elb_name                    = "my-elb-here"
    security_groups             = []
    subnets                     = []
    availability_zones          = ["us-east-1a", "us-east-1b", "us-east-1c"]

    access_logs                 = []
    listener = [
        {
            instance_port     = "80"
            instance_protocol = "HTTP"
            lb_port           = "80"
            lb_protocol       = "HTTP"
        },
    #    {
    #        instance_port      = 443
    #        instance_protocol  = "https"
    #        lb_port            = 443
    #        lb_protocol        = "https"
    #        ssl_certificate_id = "${var.elb_certificate}"
    #    },
    ]
    health_check = [
        {
            target              = "HTTP:80/"
            interval            = 30
            healthy_threshold   = 2
            unhealthy_threshold = 2
            timeout             = 5
        }
    ]

    # Enable
    enable_lb_cookie_stickiness_policy_http  = true

    # Enable
    enable_app_cookie_stickiness_policy_http = true
}
