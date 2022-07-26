# Work with HEROKU_PIPELINE via terraform

A terraform module for making HEROKU_PIPELINE.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

```

## Module Input Variables
----------------------
- `enable_pipeline` - Enable Heroku pipeline usage (`default = False`)
- `pipeline_name` - (Required) The name of the pipeline. (`default = null`)
- `pipeline_owner` - Required) The owner of the pipeline.  (`default = []`)
- `enable_pipeline_config_var` - Enable Heroku pipeline config var usage (`default = False`)
- `pipeline_config_var_pipeline_id` - The UUID of an existing pipeline. (`default = ""`)
- `pipeline_config_var_pipeline_stage` - (Required) The pipeline's stage. Supported values are test & review. (`default = test`)
- `pipeline_config_var_vars` - Map of config vars that can be output in plaintext. (`default = null`)
- `pipeline_config_var_sensitive_vars` - This is the same as vars. The main difference between the two attributes is sensitive_vars outputs are redacted on-screen and replaced by a <sensitive> placeholder, following a terraform plan or apply. It is recommended to put private keys, passwords, etc in this argument. (`default = null`)
- `enable_pipeline_coupling` - Enable Heroku pipeline coupling usage (`default = False`)
- `pipeline_coupling_app` - (Required) A Heroku app's UUID. Can also be the name of the Heroku app but UUID is preferred as it is idempotent. (`default = null`)
- `pipeline_coupling_pipeline` - The ID of the pipeline to add this app to. (`default = ""`)
- `pipeline_coupling_stage` -  (Required) The stage to couple this app to. Must be one of review, development, staging, or production. (`default = null`)

## Module Output Variables
----------------------
- `pipeline_id` - The UUID of the pipeline.
- `pipeline_name` - The name of the pipeline.
- `pipeline_config_var_id` - The UUID of the pipeline.
- `pipeline_config_var_all_vars` - The all_vars of the pipeline config var
- `pipeline_coupling_id` - The UUID of this pipeline coupling.
- `pipeline_coupling_app` - The name of the application.
- `pipeline_coupling_app_id` - The ID of the application.
- `pipeline_coupling_pipeline` - The UUID of the pipeline.
- `pipeline_coupling_stage` - The stage for this coupling.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
