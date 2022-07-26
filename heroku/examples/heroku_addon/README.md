# Work with HEROKU_ADDON via terraform

A terraform module for making HEROKU_ADDON.


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

module "heroku_addon" {
  source = "../../modules/heroku_addon"

  # Heroku Addon
  enable_addon = true
  addon_name   = "your-addon"
  addon_app    = "your-app-here"
  addon_plan   = "heroku-postgresql:hobby-basic"

  addon_config = {
    url = "http://google.com"
  }

  # Heroku Addon attachment
  enable_addon_attachment    = true
  addon_attachment_name      = "addon-attach"
  addon_attachment_app_id    = "your-app-id-here"
  addon_attachment_namespace = "credential: cred_name_here"
}

```

## Module Input Variables
----------------------
- `enable_addon` - Enable Heroku addon usage (`default = False`)
- `addon_name` - (Optional) Globally unique name of the add-on. (`default = null`)
- `addon_app` - (Required) The Heroku app to add to. (`default = null`)
- `addon_plan` - (Required) The addon to add. (`default = null`)
- `addon_config` - (Optional) Optional plan configuration. (`default = null`)
- `enable_addon_attachment` - Enable Heroku addon attachment usage (`default = False`)
- `addon_attachment_name` - (Optional) A friendly name for the Heroku Addon Attachment. (`default = null`)
- `addon_attachment_app_id` - (Required) The ID of the Heroku App to attach to. (`default = null`)
- `addon_attachment_addon_id` - (Required) The ID of the existing Heroku Addon to attach. (`default = ""`)
- `addon_attachment_namespace` - (Optional) The namespace value for the Heroku Addon Attachment. This can be used to configure the behaviour of the attachment. See Heroku Platform API Reference (`default = null`)

## Module Output Variables
----------------------
- `addon_id` - The ID of the add-on
- `addon_name` - The add-on name
- `addon_plan` - The plan name
- `addon_provider_id` - The ID of the plan provider
- `addon_config_vars` - The Configuration variables of the add-ons
- `addon_attachment_id` - The unique ID of the add-on attachment


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
