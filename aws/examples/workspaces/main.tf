#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

data "aws_workspaces_bundle" "bundle_windows_10" {
  bundle_id = "wsb-bh8rsxt14" # Value with Windows 10 (English)
}

module "workspaces" {
  source      = "../../modules/workspaces"
  name        = "TEST"
  environment = "stage"

  # workspaces directories
  enable_workspaces_directory        = true
  workspaces_directory_directory_ids = ["workspaces_directory_id1", "workspaces_directory_id2"]
  workspaces_directory_subnet_ids    = null
  workspaces_directory_self_service_permissions = [{
    increase_volume_size = true
    rebuild_workspace    = true
    change_compute_type  = false
    restart_workspace    = true
    switch_running_mode  = false
  }]

  workspaces_directory_workspace_access_properties = [
    {
      device_type_android    = "ALLOW"
      device_type_chromeos   = "ALLOW"
      device_type_ios        = "ALLOW"
      device_type_osx        = "ALLOW"
      device_type_web        = "DENY"
      device_type_windows    = "DENY"
      device_type_zeroclient = "DENY"
    }
  ]

  workspaces_directory_workspace_creation_properties = [
    {
      custom_security_group_id            = ""
      default_ou                          = "OU=AWS,DC=Workgroup,DC=Example,DC=com"
      enable_internet_access              = true
      enable_maintenance_mode             = true
      user_enabled_as_local_administrator = true
    }
  ]

  # workspaces ip group
  enable_workspaces_ip_group      = true
  workspaces_ip_group_name        = ""
  workspaces_ip_group_description = null
  workspaces_ip_group_rules = [{
    source      = "10.0.0.0/16"
    description = "Set 10.0.0.0/16 range"
  }]

  # workspaces workspace
  enable_workspaces_workspace    = true
  workspaces_workspace_name      = "workspace-name"
  workspaces_workspace_bundle_id = data.aws_workspaces_bundle.bundle_windows_10.id
  workspaces_workspace_user_name = "captain.ua"

  workspaces_workspace_root_volume_encryption_enabled = true
  workspaces_workspace_user_volume_encryption_enabled = true
  workspaces_workspace_volume_encryption_key          = "alias/aws/workspaces"

  workspaces_workspace_workspace_properties = [
    {
      compute_type_name                         = "VALUE"
      user_volume_size_gib                      = 10
      root_volume_size_gib                      = 80
      running_mode                              = "AUTO_STOP"
      running_mode_auto_stop_timeout_in_minutes = 60
    }
  ]

  depends_on = [
    data.aws_workspaces_bundle.bundle_windows_10
  ]
}
