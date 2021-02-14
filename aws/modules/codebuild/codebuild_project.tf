#---------------------------------------------------
# AWS Codebuild project
#---------------------------------------------------
resource "aws_codebuild_project" "codebuild_project" {
  count = var.enable_codebuild_project ? 1 : 0

  name         = var.codebuild_project_name != "" ? lower(var.codebuild_project_name) : "${lower(var.name)}-codebuild-project-${lower(var.environment)}"
  service_role = var.codebuild_project_service_role

  artifacts {
    type = upper(var.codebuild_project_artifacts_type)

    artifact_identifier    = var.codebuild_project_artifacts_artifact_identifier
    encryption_disabled    = var.codebuild_project_artifacts_encryption_disabled
    override_artifact_name = var.codebuild_project_artifacts_override_artifact_name
    location               = var.codebuild_project_artifacts_location
    name                   = var.codebuild_project_artifacts_name
    namespace_type         = var.codebuild_project_artifacts_namespace_type
    packaging              = var.codebuild_project_artifacts_packaging
    path                   = var.codebuild_project_artifacts_path
  }

  source {
    type = upper(var.codebuild_project_source_type)

    auth {
      type     = var.codebuild_project_source_auth_type
      resource = var.codebuild_project_source_auth_resource
    }

    buildspec       = var.codebuild_project_source_buildspec
    git_clone_depth = var.codebuild_project_source_git_clone_depth

    git_submodules_config {
      fetch_submodules = var.codebuild_project_source_git_submodules_config_fetch_submodules
    }

    insecure_ssl        = var.codebuild_project_source_insecure_ssl
    location            = var.codebuild_project_source_location
    report_build_status = var.codebuild_project_source_report_build_status
  }

  environment {
    compute_type = upper(var.codebuild_project_environment_compute_type)
    image        = var.codebuild_project_environment_image
    type         = upper(var.codebuild_project_environment_type)

    image_pull_credentials_type = upper(var.codebuild_project_environment_image_pull_credentials_type)
    privileged_mode             = var.codebuild_project_environment_privileged_mode
    certificate                 = var.codebuild_project_environment_certificate

    dynamic "registry_credential" {
      iterator = regcred
      for_each = var.codebuild_project_environment_registry_credential
      content {
        credential          = lookup(regcred.value, "credential", null)
        credential_provider = lookup(regcred.value, "credential_provider", null)
      }
    }

    dynamic "environment_variable" {
      iterator = envvar
      for_each = var.codebuild_project_environment_variable
      content {
        name  = lookup(envvar.value, "name", null)
        value = lookup(envvar.value, "value", null)
        type  = lookup(envvar.value, "type", null)
      }
    }
  }

  description    = var.codebuild_project_description
  badge_enabled  = var.codebuild_project_badge_enabled
  build_timeout  = var.codebuild_project_build_timeout
  queued_timeout = var.codebuild_project_queued_timeout
  encryption_key = var.codebuild_project_encryption_key
  source_version = var.codebuild_project_source_version

  dynamic "cache" {
    iterator = cache
    for_each = var.codebuild_project_cache
    content {
      type  = lookup(cache.value, "type", null)
      modes = lookup(cache.value, "modes", null)

      location = lookup(cache.value, "location", null)
    }
  }

  dynamic "logs_config" {
    iterator = logsconfig
    for_each = var.codebuild_project_logs_config
    content {
      cloudwatch_logs {
        status      = lookup(logsconfig.value, "cw_status", null)
        group_name  = lookup(logsconfig.value, "cw_group_name", null)
        stream_name = lookup(logsconfig.value, "cw_stream_name", null)
      }

      s3_logs {
        status              = lookup(logsconfig.value, "s3_status", null)
        location            = lookup(logsconfig.value, "s3_location", null)
        encryption_disabled = lookup(logsconfig.value, "s3_status", null)
      }
    }
  }

  dynamic "vpc_config" {
    iterator = vpcconfig
    for_each = var.codebuild_project_vpc_config
    content {
      vpc_id             = lookup(vpcconfig.value, "vpc_id", null)
      security_group_ids = lookup(vpcconfig.value, "security_group_ids", null)
      subnets            = lookup(vpcconfig.value, "subnets", null)
    }
  }

  dynamic "secondary_artifacts" {
    iterator = secondary_artifacts
    for_each = var.codebuild_project_secondary_artifacts
    content {
      type                = lookup(secartifacts.value, "type", null)
      artifact_identifier = lookup(secartifacts.value, "artifact_identifier", null)

      encryption_disabled    = lookup(secartifacts.value, "encryption_disabled", null)
      override_artifact_name = lookup(secartifacts.value, "override_artifact_name", null)
      location               = lookup(secartifacts.value, "location", null)
      name                   = lookup(secartifacts.value, "name", null)
      namespace_type         = lookup(secartifacts.value, "namespace_type", null)
      packaging              = lookup(secartifacts.value, "packaging", null)
      path                   = lookup(secartifacts.value, "path", null)
    }
  }

  dynamic "secondary_sources" {
    iterator = secsources
    for_each = var.codebuild_project_secondary_sources
    content {
      type              = lookup(secsources.value, "type", null)
      source_identifier = lookup(secsources.value, "source_identifier", null)

      buildspec           = lookup(secsources.value, "buildspec", null)
      git_clone_depth     = lookup(secsources.value, "git_clone_depth", null)
      insecure_ssl        = lookup(secsources.value, "insecure_ssl", null)
      location            = lookup(secsources.value, "location", null)
      report_build_status = lookup(secsources.value, "report_build_status", null)

      auth {
        type     = var.codebuild_project_secondary_sources_auth_type
        resource = var.codebuild_project_secondary_sources_auth_resource
      }

      git_submodules_config {
        fetch_submodules = var.codebuild_project_secondary_sources_git_submodules_config_fetch_submodules
      }
    }
  }

  tags = merge(
    {
      Name = var.codebuild_project_name != "" ? lower(var.codebuild_project_name) : "${lower(var.name)}-codebuild-project-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
