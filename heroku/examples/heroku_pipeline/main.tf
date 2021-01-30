#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"

  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 3.2.0"
    }
  }
}

provider "heroku" {
  email   = null
  api_key = null

  headers = null

  delays {
    post_app_create_delay    = 5
    post_space_create_delay  = 5
    post_domain_create_delay = 5
  }

  timeouts {
    addon_create_timeout = 20
  }
}

module "heroku_pipeline" {
  source = "../../modules/heroku_pipeline"

  # Heroku pipeline
  enable_pipeline = true
  pipeline_name   = "your-app-here"
  pipeline_owner = [
    {
      id   = "16d1c25f-d879-4f4d-ad1b-d807169aaa1c"
      type = "user"
    }
  ]

  # Heroku pipeline 
  enable_pipeline_config_var         = true
  pipeline_config_var_pipeline_stage = "test"
  pipeline_config_var_vars = {
    ENV    = "test"
    TARGET = "develop"
  }

  pipeline_config_var_sensitive_vars = {
    TEST_ACCESS_TOKEN = "some_access token"
  }

  # Heroku pipeline coupling
  enable_pipeline_coupling = true
  pipeline_coupling_app    = "your-app-here"
  pipeline_coupling_stage  = "staging"
}
