# Work with HEROKU_APP via terraform

A terraform module for making HEROKU_APP.


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

module "heroku_app" {
  source = "../../modules/heroku_app"

  # Heroku app
  enable_app = true
  app_name   = "your-app-here"
  app_region = "us"

  app_buildpacks = [
    "heroku/go"
  ]

  app_config_vars = {
    FOOBAR = "baz"
  }

  app_sensitive_config_vars = {
    FOOBAR2 = "baz2"
  }

  app_organization = [
    {
      name = "my-cool-team"
    }
  ]

  # Heroku app config association
  enable_app_config_association         = false
  app_config_association_vars           = {}
  app_config_association_sensitive_vars = {}

  # Heroku app release
  enable_app_release      = true
  app_release_slug_id     = "01234567-89ab-cdef-0123-456789abcdef"
  app_release_description = ""

  # Heroku app feature
  enable_app_feature = false
  app_feature_app    = "test-app"
  app_feature_name   = "your-feature-app-name"

  # Heroku app webhook
  enable_app_webhook  = true
  app_webhook_level   = "notify"
  app_webhook_url     = "https://example.com/heroku_webhook"
  app_webhook_include = ["api:release"]

  app_webhook_secret        = null
  app_webhook_authorization = null
}

```

## Module Input Variables
----------------------
- `name` - Set name if some variables will be unset for resources (`default = heroku`)
- `environment` - Set Env name (`default = dev`)
- `enable_app` - Enable Heroku app usage (`default = null`)
- `app_name` - (Required) The name of the application. In Heroku, this is also the unique ID, so it must be unique and have a minimum of 3 characters. (`default = null`)
- `app_region` - (Required) The region that the app should be deployed in. (`default = null`)
- `app_stack` - (Optional) The application stack is what platform to run the application in. (`default = null`)
- `app_buildpacks` - (Optional) Buildpack names or URLs for the application. Buildpacks configured externally won't be altered if this is not present. (`default = null`)
- `app_config_vars` - (Optional) Configuration variables for the application. The config variables in this map are not the final set of configuration variables, but rather variables you want present. That is, other configuration variables set externally won't be removed by Terraform if they aren't present in this list. (`default = null`)
- `app_sensitive_config_vars` - (Optional) This argument is the same as config_vars. The main difference between the two is when sensitive_config_vars outputs are displayed on-screen following a terraform apply or terraform refresh, they are redacted, with <sensitive> displayed in place of their value. It is recommended to put private keys, passwords, etc in this argument. (`default = null`)
- `app_space` - (Optional) The name of a private space to create the app in. (`default = null`)
- `app_internal_routing` - (Optional) If true, the application will be routable only internally in a private space. This option is only available for apps that also specify space. (`default = null`)
- `app_organization` - (Optional) A block that can be specified once to define Heroku Team settings for this app.  (`default = []`)
- `app_acm` - (Optional) The flag representing Automated Certificate Management for the app. (`default = null`)
- `enable_app_config_association` - Enable Heroku app config association usage (`default = False`)
- `app_config_association_app_id` - A Heroku app's UUID. Can also be the name of the Heroku app but UUID is preferred as it is idempotent. (`default = ""`)
- `app_config_association_vars` - Map of config vars that can be output in plaintext. (`default = null`)
- `app_config_association_sensitive_vars` - This is the same as vars. The main difference between the two attributes is sensitive_vars outputs are redacted on-screen and replaced by a <sensitive> placeholder, following a terraform plan or apply. It is recommended to put private keys, passwords, etc in this argument. (`default = null`)
- `enable_app_release` - Enable Heroku app release usage (`default = False`)
- `app_release_app` - The name of the application (`default = ""`)
- `app_release_slug_id` - unique identifier of slug (`default = null`)
- `app_release_description` - description of changes in this release (`default = null`)
- `enable_app_feature` - Enable Heroku app feature usage (`default = False`)
- `app_feature_app` - (Required) The Heroku app to link to. (`default = ""`)
- `app_feature_name` - (Required) The name of the App Feature to manage. (`default = ""`)
- `app_feature_enabled` - (Optional) Whether to enable or disable the App Feature. The default value is true. (`default = null`)
- `enable_app_webhook` - Enable Heroku app webhook usage (`default = False`)
- `app_webhook_app_id` - (Required) The Heroku app to add to. (`default = ""`)
- `app_webhook_level` - (Required) The webhook level (either notify or sync) (`default = null`)
- `app_webhook_url` - (Required) Optional plan configuration. (`default = null`)
- `app_webhook_include` - (Required) List of events to deliver to the webhook. (`default = null`)
- `app_webhook_secret` - (Optional) Value used to sign webhook payloads. Once set, this value cannot be fetched from the Heroku API, but it can be updated. (`default = null`)
- `app_webhook_authorization` - (Optional) Values used in Authorization header. Once set, this value cannot be fetched from the Heroku API, but it can be updated. (`default = null`)

## Module Output Variables
----------------------
- `app_id` - The ID of the app. This is also the name of the app.
- `app_name` - The name of the application.
- `app_stack` - The application stack is what platform to run the application in.
- `app_space` - The private space the app should run in.
- `app_internal_routing` - Whether internal routing is enabled the private space app.
- `app_region` - The region that the app should be deployed in.
- `app_git_url` - The Git URL for the application. This is used for deploying new versions of the app.
- `app_web_url` - The web (HTTP) URL that the application can be accessed at by default.
- `app_heroku_hostname` - A hostname for the Heroku application, suitable for pointing DNS records.
- `app_all_config_vars` - A map of all of the configuration variables that exist for the app, containing both those set by Terraform and those set externally. (These are treated as 'sensitive' so that their values are redacted in console output.)
- `app_uuid` - The unique UUID of the Heroku app. NOTE: Use this for null_resource triggers.
- `app_config_association_id` - The ID of the app config association.
- `app_release_id` - The ID of the app release
- `app_feature_id` - The ID of app feature
- `app_webhook_id` - The ID of app webhook


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
