# Work with HEROKU_SLUG via terraform

A terraform module for making HEROKU_SLUG.


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

module "heroku_slug" {
  source = "../../modules/heroku_slug"

  enable_slug = true
  slug_app    = "your_app_here"
  slug_process_types = {
    web = "ruby server.rb"
  }
  slug_stack                          = "slug-name"
  slug_buildpack_provided_description = "Ruby"
  slug_file_path                      = null
  # Or:
  slug_file_url = "https://example.com/slugs/app-v1.tgzs"
}

```

## Module Input Variables
----------------------
- `name` - Set name if some variables will be unset for resources (`default = heroku`)
- `environment` - Set Env name (`default = dev`)
- `enable_slug` - Enable Heroku slug usage (`default = False`)
- `slug_app` - (Required) The ID of the Heroku app (`default = null`)
- `slug_process_types` - (Required) Map of processes to launch on Heroku Dynos (`default = null`)
- `slug_stack` - Name or ID of the Heroku stack (`default = ""`)
- `slug_buildpack_provided_description` - Description of language or app framework, 'Ruby/Rack'; displayed as the app's language in the Heroku Dashboard (`default = null`)
- `slug_checksum` - Hash of the slug for verifying its integrity, auto-generated from contents of file_path or file_url, SHA256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 (`default = null`)
- `slug_commit` - Identification of the code with your version control system (eg: SHA of the git HEAD), '60883d9e8947a57e04dc9124f25df004866a2051' (`default = null`)
- `slug_commit_description` - Description of the provided commit (`default = null`)
- `slug_file_path` - (Required unless file_url is set) Local path to a slug archive, 'slugs/current.tgz' (`default = null`)
- `slug_file_url` - (Required unless file_path is set) https URL to a slug archive, 'https://example.com/slugs/app-v1.tgz' (`default = null`)

## Module Output Variables
----------------------
- `slug_id` - The ID of the slug
- `slug_app` - The ID or unique name of the Heroku app
- `slug_blob` - Slug archive (compressed tar of executable code)
- `slug_buildpack_provided_description` - Description of language or app framework, 'Ruby/Rack'
- `slug_checksum` - Hash of the slug for verifying its integrity, auto-generated from contents of file_path or file_url
- `slug_commit` - Identification of the code with your version control system (eg: SHA of the git HEAD), '60883d9e8947a57e04dc9124f25df004866a2051'
- `slug_commit_description` - Description of the provided commit
- `slug_process_types` - Map of processes to launch on Heroku Dynos
- `slug_size` - Slug archive filesize in bytes
- `slug_stack` - Heroku stack name
- `slug_stack_id` - Heroku stack ID


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
