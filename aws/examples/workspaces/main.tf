#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "workspaces" {
    source                                          = "../../modules/workspaces"
    name                                            = "TEST"
    environment                                     = "stage"

    # workspaces directories
    enable_workspaces_directory                     = true
    workspaces_directory_directory_ids              = ["workspaces_directory_id1", "workspaces_directory_id2"]
    workspaces_directory_subnet_ids                 = null
    workspaces_directory_self_service_permissions   = [{
        increase_volume_size    = true
        rebuild_workspace       = true
        change_compute_type     = false
        restart_workspace       = true
        switch_running_mode     = false
    }]

    # workspaces ip group
    enable_workspaces_ip_group                      = true
    workspaces_ip_group_name                        = ""
    workspaces_ip_group_description                 = null
    workspaces_ip_group_rules                       = [{
        source      = "10.0.0.0/16"
        description = "Set 10.0.0.0/16 range"
    }]
}
