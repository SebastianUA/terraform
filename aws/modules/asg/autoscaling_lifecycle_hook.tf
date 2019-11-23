#---------------------------------------------------
# Create AWS autoscaling lifecycle hook
#---------------------------------------------------
resource "aws_autoscaling_lifecycle_hook" "autoscaling_lifecycle_hook" {
    count                   = "${var.enable_autoscaling_lifecycle_hook && !var.enable_asg_azs ? 1 : 0 }"
                                                         
    name                    = "${var.autoscaling_lifecycle_hook_name != "" ? var.autoscaling_lifecycle_hook_name : "${lower(var.name)}-asg-lifecycle-hook-${lower(var.environment)}" }"
    autoscaling_group_name  = "${var.autoscaling_group_name}"

    default_result          = "${var.autoscaling_lifecycle_hook_default_result}"
    heartbeat_timeout       = "${var.autoscaling_lifecycle_hook_heartbeat_timeout}"
    lifecycle_transition    = "${var.autoscaling_lifecycle_hook_lifecycle_transition}"
    
    #notification_metadata   = "${var.autoscaling_lifecycle_hook_notification_metadata}"
    notification_metadata   = "${data.template_file.autoscaling_lifecycle_hook.rendered}"

    notification_target_arn = "${var.autoscaling_lifecycle_hook_notification_target_arn}"
    role_arn                = "${var.autoscaling_lifecycle_hook_role_arn}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on = ["data.template_file.autoscaling_lifecycle_hook"]
}

data "template_file" "autoscaling_lifecycle_hook" {
    template = "${var.autoscaling_lifecycle_hook_notification_metadata}"
}