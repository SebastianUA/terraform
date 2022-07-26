# Work with HEROKU_TEAM via terraform

A terraform module for making HEROKU_TEAM.


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

module "team_collaborator" {
  source = "../../modules/heroku_team"

  enable_team_collaborator      = true
  team_collaborator_app         = "your_app_here"
  team_collaborator_email       = "your_email_here"
  team_collaborator_permissions = ["view", "operate", "manage"]
}

module "team_member" {
  source = "../../modules/heroku_team"

  enable_team_member = true
  team_member_team   = ""
  team_member_email  = "your_email_here"
  team_member_role   = "member"
}
```

## Module Input Variables
----------------------
- `name` - Set name if some variables will be unset for resources (`default = heroku`)
- `environment` - Set Env name (`default = dev`)
- `enable_team_collaborator` - Enable Heroku team collaborator usage (`default = False`)
- `team_collaborator_app` - (Required) The name of the team app that the team collaborator will be added to. (`default = null`)
- `team_collaborator_email` - (Required) Email address of the team collaborator (`default = null`)
- `team_collaborator_permissions` - (Required) List of permissions that will be granted to the team collaborator. The order in which individual permissions are set here does not matter. (`default = null`)
- `enable_team_member` - Enable Heroku team member usage (`default = False`)
- `team_member_team` - The name of the Heroku Team. (`default = ""`)
- `team_member_email` - (Required) Email address of the member (`default = null`)
- `team_member_role` - (Required) The role to assign the member. See the API docs for available options. (`default = null`)

## Module Output Variables
----------------------
- `team_collaborator_id` - The ID of the team collaborator
- `team_member_id` - The ID of the team member


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
