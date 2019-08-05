#-----------------------------------------------------------
# Instance Profile
#-----------------------------------------------------------
resource "aws_iam_instance_profile" "iam_instance_profile" {
    count       = "${var.enable_iam_instance_profile ? 1 : 0}"

    name        = "${length(var.iam_instance_profile_name) > 0 ? var.iam_instance_profile_name : "${lower(var.name)}-iam_instance_profile-${lower(var.environment)}" }"
    role        = "${length(var.iam_instance_profile_role) == 0 &&  var.enable_iam_role ? "${aws_iam_role.iam_role.name}" : "${var.iam_instance_profile_role}" }"

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = ["aws_iam_role.iam_role"]
}
