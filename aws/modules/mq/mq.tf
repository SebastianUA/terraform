#---------------------------------------------------
# Create AWS MQ broker
#---------------------------------------------------
resource "aws_mq_broker" "mq_broker" {
  
    broker_name             = "${lower(var.name)}-mq-broker-${lower(var.environment)}"
    engine_type             = "${var.engine_type}"
    engine_version          = "${var.engine_version}"
    host_instance_type      = "${var.host_instance_type}"
    security_groups         = ["${var.security_group_ids}"]
    subnet_ids              = ["${var.subnet_ids}"]
    
    apply_immediately           = "${var.apply_immediately}"
    auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
    deployment_mode             = "${var.deployment_mode}"
    publicly_accessible         = "${var.publicly_accessible}"

    maintenance_window_start_time {
        day_of_week = "${var.day_of_week}"
        time_of_day = "${var.time_of_day}"
        time_zone   = "${var.time_zone}"
    }

    configuration {
        id          = "${aws_mq_configuration.mq_configuration.id}"
        revision    = "${aws_mq_configuration.mq_configuration.latest_revision}"
    }

    user {
        username        = "${var.mq_broker_username}"
        password        = "${var.mq_broker_password}"
        groups          = ["${var.mq_broker_groups}"]
        console_access  = "${var.mq_broker_console_access}"
    }

    depends_on = ["aws_mq_configuration.mq_configuration"]
}
#---------------------------------------------------
# Create AWS MQ broker configuration
#---------------------------------------------------
resource "aws_mq_configuration" "mq_configuration" {
    name           = "${lower(var.name)}-mq-broker-configuration-${lower(var.environment)}"
    description    = "The Configuration for ${lower(var.name)}-mq-broker-${lower(var.environment)}"
    engine_type    = "${var.engine_type}"
    engine_version = "${var.engine_version}"
    data           = "${data.template_file.mq_configuration_data.rendered}"

    depends_on  = ["data.template_file.mq_configuration_data"]
}
#---------------------------------------------------
# Create data for AWS MQ broker configuration 
#---------------------------------------------------
data "template_file" "mq_configuration_data" {
    template = "${file("${path.module}/data/data.xml.tpl")}"
}
