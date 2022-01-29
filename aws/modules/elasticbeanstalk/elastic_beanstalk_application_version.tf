#---------------------------------------------------
# AWS elastic beanstalk application version
#---------------------------------------------------
resource "aws_elastic_beanstalk_application_version" "elastic_beanstalk_application_version" {
  count = var.enable_elastic_beanstalk_application_version ? 1 : 0

  name        = var.elastic_beanstalk_application_version_name != "" ? var.elastic_beanstalk_application_version_name : "${lower(var.name)}-eb-app-ver-${lower(var.environment)}"
  description = var.elastic_beanstalk_application_version_description != "" ? var.elastic_beanstalk_application_version_description : null

  application  = var.elastic_beanstalk_application_version_application != "" ? var.elastic_beanstalk_application_version_application : (var.enable_elastic_beanstalk_application ? aws_elastic_beanstalk_application.elastic_beanstalk_application.0.name : null)
  bucket       = var.elastic_beanstalk_application_version_bucket
  key          = var.elastic_beanstalk_application_version_key
  force_delete = var.elastic_beanstalk_application_version_force_delete

  tags = merge(
    {
      Name = var.elastic_beanstalk_application_version_name != "" ? var.elastic_beanstalk_application_version_name : "${lower(var.name)}-eb-app-ver-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elastic_beanstalk_application.elastic_beanstalk_application
  ]
}
