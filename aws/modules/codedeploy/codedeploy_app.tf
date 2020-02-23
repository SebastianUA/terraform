#---------------------------------------------------
# AWS codedeploy app
#---------------------------------------------------
resource "aws_codedeploy_app" "codedeploy_app" {
    count                   = var.enable_codedeploy_app ? 1 : 0

    name                    = var.codedeploy_app_name != "" ? lower(var.codedeploy_app_name) : "${lower(var.name)}-codedeploy-app-${lower(var.environment)}"
    compute_platform        = var.codedeploy_app_compute_platform

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = []
}