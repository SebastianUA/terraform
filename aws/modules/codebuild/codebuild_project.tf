#---------------------------------------------------
# AWS Codebuild project
#---------------------------------------------------
resource "aws_codebuild_project" "codebuild_project" {
  count = var.enable_codebuild_project ? 1 : 0

  name         = var.codebuild_project_name != "" ? lower(var.codebuild_project_name) : "${lower(var.name)}-codebuild-project-${lower(var.environment)}"
  service_role = var.codebuild_project_service_role

  description    = var.codebuild_project_description
  badge_enabled  = var.codebuild_project_badge_enabled
  build_timeout  = var.codebuild_project_build_timeout
  queued_timeout = var.codebuild_project_queued_timeout
  encryption_key = var.codebuild_project_encryption_key
  source_version = var.codebuild_project_source_version

  dynamic "artifacts" {
    iterator = artifacts
    for_each = var.codebuild_project_artifacts

    content {
      type = lookup(artifacts.value, "type", null)

      artifact_identifier    = lookup(artifacts.value, "artifact_identifier", null)
      encryption_disabled    = lookup(artifacts.value, "encryption_disabled", null)
      override_artifact_name = lookup(artifacts.value, "override_artifact_name", null)
      location               = lookup(artifacts.value, "location", null)
      name                   = lookup(artifacts.value, "name", null)
      namespace_type         = lookup(artifacts.value, "namespace_type", null)
      packaging              = lookup(artifacts.value, "packaging", null)
      path                   = lookup(artifacts.value, "path", null)
    }
  }

  dynamic "source" {
    iterator = source
    for_each = length(var.codebuild_project_source) > 0 ? [var.codebuild_project_source] : []

    content {
      type = lookup(source.value, "type", null)

      insecure_ssl        = lookup(source.value, "insecure_ssl", null)
      location            = lookup(source.value, "location", null)
      report_build_status = lookup(source.value, "report_build_status", null)
      buildspec           = lookup(source.value, "buildspec", null)
      git_clone_depth     = lookup(source.value, "git_clone_depth", null)

      dynamic "auth" {
        iterator = auth
        for_each = length(keys(lookup(source.value, "auth", {}))) > 0 ? [lookup(source.value, "auth", {})] : []

        content {
          type     = lookup(auth.value, "type", null)
          resource = lookup(auth.value, "resource", null)
        }
      }

      dynamic "git_submodules_config" {
        iterator = git_submodules_config
        for_each = length(keys(lookup(source.value, "git_submodules_config", {}))) > 0 ? [lookup(source.value, "git_submodules_config", {})] : []

        content {
          fetch_submodules = lookup(git_submodules_config.value, "fetch_submodules", null)
        }
      }
    }
  }

  dynamic "environment" {
    iterator = environment
    for_each = length(var.codebuild_project_environment) > 0 ? [var.codebuild_project_environment] : []

    content {
      compute_type = lookup(environment.value, "compute_type", null)
      image        = lookup(environment.value, "image", null)
      type         = lookup(environment.value, "type", null)

      image_pull_credentials_type = lookup(environment.value, "image_pull_credentials_type", null)
      privileged_mode             = lookup(environment.value, "privileged_mode", null)
      certificate                 = lookup(environment.value, "certificate", null)

      dynamic "registry_credential" {
        iterator = regcred
        for_each = length(keys(lookup(environment.value, "registry_credential", {}))) > 0 ? [lookup(environment.value, "registry_credential", {})] : []

        content {
          credential          = lookup(regcred.value, "credential", null)
          credential_provider = lookup(regcred.value, "credential_provider", null)
        }
      }

      dynamic "environment_variable" {
        iterator = envvar
        for_each = length(keys(lookup(environment.value, "environment_variable", {}))) > 0 ? [lookup(environment.value, "environment_variable", {})] : []

        content {
          name  = lookup(envvar.value, "name", null)
          value = lookup(envvar.value, "value", null)
          type  = lookup(envvar.value, "type", null)
        }
      }
    }
  }

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
      dynamic "cloudwatch_logs" {
        iterator = cloudwatch_logs
        for_each = length(keys(lookup(logsconfig.value, "cloudwatch_logs", {}))) > 0 ? [lookup(logsconfig.value, "cloudwatch_logs", {})] : []

        content {
          status      = lookup(cloudwatch_logs.value, "status", null)
          group_name  = lookup(cloudwatch_logs.value, "group_name", null)
          stream_name = lookup(cloudwatch_logs.value, "stream_name", null)
        }
      }

      dynamic "s3_logs" {
        iterator = s3_logs
        for_each = length(keys(lookup(logsconfig.value, "s3_logs", {}))) > 0 ? [lookup(logsconfig.value, "s3_logs", {})] : []

        content {
          status              = lookup(s3_logs.value, "status", null)
          location            = lookup(s3_logs.value, "location", null)
          encryption_disabled = lookup(s3_logs.value, "status", null)
        }
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
    iterator = secartifacts
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

      dynamic "auth" {
        iterator = auth
        for_each = length(keys(lookup(secsources.value, "auth", {}))) > 0 ? [lookup(secsources.value, "auth", {})] : []

        content {
          type     = lookup(auth.value, "type", null)
          resource = lookup(auth.value, "resource", null)
        }
      }

      dynamic "git_submodules_config" {
        iterator = git_submodules_config
        for_each = length(keys(lookup(secsources.value, "git_submodules_config", {}))) > 0 ? [lookup(secsources.value, "git_submodules_config", {})] : []

        content {
          fetch_submodules = lookup(git_submodules_config.value, "fetch_submodules", null)
        }
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
