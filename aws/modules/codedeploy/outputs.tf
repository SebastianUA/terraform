#---------------------------------------------------
# AWS codedeploy app
#---------------------------------------------------
output "codedeploy_app_id" {
    description = "Amazon's assigned ID for the application."
    value       = element(concat(aws_codedeploy_app.codedeploy_app.*.id, [""], ), 0)
}

output "codedeploy_app_name" {
    description = "The application's name."
    value       = element(concat(aws_codedeploy_app.codedeploy_app.*.name, [""], ), 0)
}

#---------------------------------------------------
# AWS codedeploy deployment config
#---------------------------------------------------
output "codedeploy_deployment_config_id" {
    description = "The deployment group's config name."
    value       = element(concat(
        aws_codedeploy_deployment_config.codedeploy_deployment_config_canary.*.id,
        aws_codedeploy_deployment_config.codedeploy_deployment_config_linear.*.id,
        [""], 
        ), 0)
}

output "codedeploy_deployment_config_deployment_config_id" {
    description = "The AWS Assigned deployment config id"
    value       = element(concat(
        aws_codedeploy_deployment_config.codedeploy_deployment_config_canary.*.deployment_config_id,
        aws_codedeploy_deployment_config.codedeploy_deployment_config_linear.*.deployment_config_id,
        [""], 
        ), 0)
}

#---------------------------------------------------
# AWS codedeploy deployment group
#---------------------------------------------------
output "codedeploy_deployment_group_id" {
    description = "Application name and deployment group name."
    value       = element(concat(
        aws_codedeploy_deployment_group.codedeploy_deployment_group.*.id,
        aws_codedeploy_deployment_group.codedeploy_deployment_group_notify.*.id,
        aws_codedeploy_deployment_group.codedeploy_deployment_group_ec2tag.*.id,
        aws_codedeploy_deployment_group.codedeploy_deployment_group_ec2tag.*.id,
        aws_codedeploy_deployment_group.codedeploy_deployment_group_ec2tag_notify.*.id,
        aws_codedeploy_deployment_group.codedeploy_deployment_group_blue_green.*.id,
        [""],
        ),0)
}
