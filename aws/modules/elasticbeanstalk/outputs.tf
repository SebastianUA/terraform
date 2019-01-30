#-----------------------------------------------------------------
# EB APP
#-----------------------------------------------------------------
output "elastic_beanstalk_application_name" {
    description = "Name for elastic_beanstalk_application"
    value       = "${element(concat(aws_elastic_beanstalk_application.elastic_beanstalk_application.*.name, list("")), 0)}"
}

#-----------------------------------------------------------------
# EB ENV
#-----------------------------------------------------------------
output "elastic_beanstalk_environment_id" {
    description = "ID of the Elastic Beanstalk Environment."    
    value       = "${element(concat(aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.id, list("")), 0)}"
}

output "elastic_beanstalk_environment_name" {
    description = "Name of the Elastic Beanstalk Environment."
    value       = "${element(concat(aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.name, list("")), 0)}"
}

output "elastic_beanstalk_environment_tier " {
    description = "The environment tier specified."
    value       = "${element(concat(aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.tier, list("")), 0)}"
}

output "elastic_beanstalk_environment_application" {
    description = "The Elastic Beanstalk Application specified for this environment."
    value       = "${element(concat(aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.application, list("")), 0)}"
}

output "elastic_beanstalk_environment_setting" {
    description = "Settings specifically set for this Environment."
    value       = ["${aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.setting}"]
}

output "elastic_beanstalk_environment_all_settings" {
    description = "List of all option settings configured in the Environment. These are a combination of default settings and their overrides from setting in the configuration."
    value       = ["${aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.all_settings}"]
}

output "elastic_beanstalk_environment_cname" {
    description = "Fully qualified DNS name for the Environment."
    value       = "${element(concat(aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.cname, list("")), 0)}"
}

output "elastic_beanstalk_environment_autoscaling_groups" {
    description = "The autoscaling groups used by this environment."
    value       = ["${aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.autoscaling_groups}"]
}

output "elastic_beanstalk_environment_instances" {
    description = "Instances used by this environment."
    value       = ["${aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.instances}"]
}

output "elastic_beanstalk_environment_launch_configurations" {
    description = "Launch configurations in use by this environment."
    value       = ["${aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.launch_configurations}"]
}

output "elastic_beanstalk_environment_load_balancers" {
    description = "Elastic load balancers in use by this environment."
    value       = ["${aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.load_balancers}"]
}

output "elastic_beanstalk_environment_queues" {
    description = "SQS queues in use by this environment."
    value       = ["${aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.queues}"]
}

output "elastic_beanstalk_environment_triggers" {
    description = "Autoscaling triggers in use by this environment."
    value       = ["${aws_elastic_beanstalk_environment.elastic_beanstalk_environment.*.triggers}"]
}

#-----------------------------------------------------------------
# EB App version
#-----------------------------------------------------------------
output "elastic_beanstalk_application_version_name" {
    description = "The Application Version name."
    value       = "${element(concat(aws_elastic_beanstalk_application_version.elastic_beanstalk_application_version.*.name, list("")), 0)}"
}

output "elastic_beanstalk_application_version_deploy_or_rollback" {
    description = ""
    value       = "${var.deploy_or_rollback}"
}

#-----------------------------------------------------------------
# EB configuration template
#-----------------------------------------------------------------
output "elastic_beanstalk_configuration_template_name" {
    description = "Name for created config-template"
    value       = "${element(concat(aws_elastic_beanstalk_configuration_template.elastic_beanstalk_configuration_template.*.name, list("")), 0)}"
}
