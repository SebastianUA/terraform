# Work with HEROKU_BUILD via terraform

A terraform module for making HEROKU_BUILD.


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

module "heroku_build" {
  source = "../../modules/heroku_build"

  enable_build     = true
  build_app        = "your-app-here"
  build_buildpacks = ["https://github.com/mars/create-react-app-buildpack"]

  build_source = {
    url     = "https://github.com/mars/cra-example-app/archive/v2.1.1.tar.gz"
    version = "v2.1.1"
  }
}

```

## Module Input Variables
----------------------
- `enable_build` - Enable Heroku build usage (`default = False`)
- `build_app` - (Required) The ID of the Heroku app (`default = null`)
- `build_buildpacks` - List of buildpack GitHub URLs (`default = null`)
- `build_source` - (Required) A block that specifies the source code to build & release (`default = []`)

## Module Output Variables
----------------------
- `build_id` - The ID of the build
- `build_uuid` - The ID of the build
- `build_output_stream_url` - URL that streams the log output from the build
- `build_release_id` - The Heroku app release created with a build's slug
- `build_slug_id` - The Heroku slug created by a build
- `build_stack` - Name or ID of the Heroku stack
- `build_status` - The status of a build. Possible values are pending, successful and failed
- `build_user` - Heroku account that created a build


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
