#---------------------------------------------------
# AWS elastic beanstalk application
#---------------------------------------------------
resource "aws_elastic_beanstalk_application" "elastic_beanstalk_application" {
  count = var.enable_elastic_beanstalk_application ? 1 : 0

  name        = var.elastic_beanstalk_application_name != "" ? var.elastic_beanstalk_application_name : "${lower(var.name)}-eb-app-${lower(var.environment)}"
  description = var.elastic_beanstalk_application_description != "" ? var.elastic_beanstalk_application_description : "Elactic beanstalk application for ${lower(var.name)}-eb-app-${lower(var.environment)}"

  dynamic "appversion_lifecycle" {
    iterator = appversion_lifecycle
    for_each = var.elastic_beanstalk_application_appversion_lifecycle

    content {
      service_role          = lookup(appversion_lifecycle.value, "service_role", null)
      max_count             = lookup(appversion_lifecycle.value, "max_count", null)
      max_age_in_days       = lookup(appversion_lifecycle.value, "max_age_in_days", null)
      delete_source_from_s3 = lookup(appversion_lifecycle.value, "delete_source_from_s3", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
