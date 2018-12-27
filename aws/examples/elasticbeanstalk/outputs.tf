#-----------------------------------------------------------------
# EB APP
#-----------------------------------------------------------------
output "eb_application_name" {
    description = "Name for elastic_beanstalk_application"
    value       = "${module.elasticbeanstalk.elastic_beanstalk_application_name}"
}
#-----------------------------------------------------------------
# EB ENV
#-----------------------------------------------------------------
output "eb_environment_name" {
    description = "Name of the Elastic Beanstalk Environment."
    value       = "${module.elasticbeanstalk.elastic_beanstalk_environment_name}"
}

output "eb_environment_cname" {
    description = "Fully qualified DNS name for the Environment."
    value       = "${module.elasticbeanstalk.elastic_beanstalk_environment_cname}"
}


