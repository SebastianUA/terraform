# Work with CONSUL_CONFIG_ENTRY via terraform

A terraform module for making CONSUL_CONFIG_ENTRY.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"

  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.11.0"
    }
  }
}

provider "consul" {
  address    = "127.0.0.1:8500"
  scheme     = "http"
  datacenter = "dc1"

  ca_file        = null
  ca_pem         = null
  cert_file      = null
  cert_pem       = null
  key_file       = null
  key_pem        = null
  ca_path        = null
  http_auth      = null
  token          = null
  insecure_https = null
}

module "consul_config_entry_global" {
  source = "../../modules/consul_config_entry"

  enable_config_entry = true
  config_entry_name   = "global"
  config_entry_kind   = "proxy-defaults"
  config_entry_config_json = jsonencode({
    Config = {
      local_connect_timeout_ms = 1000
      handshake_timeout_ms     = 10000
    }
  })
}

module "consul_config_entry_web" {
  source = "../../modules/consul_config_entry"

  enable_config_entry = true
  config_entry_name   = "web"
  config_entry_kind   = "proxy-defaults"
  config_entry_config_json = jsonencode({
    Protocol = "http"
  })
}

module "consul_config_entry_admin" {
  source = "../../modules/consul_config_entry"

  enable_config_entry = true
  config_entry_name   = "admin"
  config_entry_kind   = "proxy-defaults"
  config_entry_config_json = jsonencode({
    Protocol = "http"
  })
}

module "consul_config_entry_service_resolver" {
  source = "../../modules/consul_config_entry"

  enable_config_entry = true
  config_entry_name   = module.consul_config_entry_web.consul_config_entry_name
  config_entry_kind   = "service-resolver"
  config_entry_config_json = jsonencode({
    DefaultSubset = "v1"

    Subsets = {
      "v1" = {
        Filter = "Service.Meta.version == v1"
      }
      "v2" = {
        Filter = "Service.Meta.version == v2"
      }
    }
  })

  depends_on = [
    module.consul_config_entry_web
  ]
}

module "consul_config_entry_service_splitter" {
  source = "../../modules/consul_config_entry"

  enable_config_entry = true
  config_entry_name   = module.consul_config_entry_service_resolver.consul_config_entry_name
  config_entry_kind   = "service-splitter"
  config_entry_config_json = jsonencode({
    Splits = [
      {
        Weight        = 90
        ServiceSubset = "v1"
      },
      {
        Weight        = 10
        ServiceSubset = "v2"
      },
    ]
  })

  depends_on = [
    module.consul_config_entry_service_resolver
  ]
}

module "consul_config_entry_service_router" {
  source = "../../modules/consul_config_entry"

  enable_config_entry = true
  config_entry_name   = "web"
  config_entry_kind   = "service-router"
  config_entry_config_json = jsonencode({
    Routes = [
      {
        Match = {
          HTTP = {
            PathPrefix = "/admin"
          }
        }

        Destination = {
          Service = "admin"
        }
      },
      # NOTE: a default catch-all will send unmatched traffic to "web"
    ]
  })

  depends_on = []
}

module "consul_config_entry_ingress_gateway" {
  source = "../../modules/consul_config_entry"

  enable_config_entry = true
  config_entry_name   = "us-east-ingress"
  config_entry_kind   = "ingress-gateway"
  config_entry_config_json = jsonencode({
    TLS = {
      Enabled = true
    }
    Listeners = [{
      Port     = 8000
      Protocol = "http"
      Services = [{ Name = "*" }]
    }]
  })

  depends_on = []
}

module "consul_config_entry_terminating_gateway" {
  source = "../../modules/consul_config_entry"

  enable_config_entry = true
  config_entry_name   = "us-west-gateway"
  config_entry_kind   = "terminating-gateway"
  config_entry_config_json = jsonencode({
    Services = [{ Name = "billing" }]
  })

  depends_on = []
}

module "consul_config_entry_service_intentions" {
  source = "../../modules/consul_config_entry"

  enable_config_entry = true
  config_entry_name   = "api-service"
  config_entry_kind   = "service-intentions"
  config_entry_config_json = jsonencode({
    Sources = [
      {
        Action     = "allow"
        Name       = "frontend-webapp"
        Precedence = 9
        Type       = "consul"
      },
      {
        Action     = "allow"
        Name       = "nightly-cronjob"
        Precedence = 9
        Type       = "consul"
      }
    ]
  })

  depends_on = []
}

module "consul_config_entry_sd" {
  source = "../../modules/consul_config_entry"

  enable_config_entry = true
  config_entry_name   = "fort-knox"
  config_entry_kind   = "service-defaults"
  config_entry_config_json = jsonencode({
    Protocol = "http"
  })

  depends_on = []
}

module "consul_config_entry_service_intentions-fort-knox" {
  source = "../../modules/consul_config_entry"

  enable_config_entry = true
  config_entry_name   = module.consul_config_entry_sd.consul_config_entry_name
  config_entry_kind   = "service-intentions"
  config_entry_config_json = jsonencode({
    Sources = [
      {
        Name = "contractor-webapp"
        Permissions = [
          {
            Action = "allow"
            HTTP = {
              Methods   = ["GET", "HEAD"]
              PathExact = "/healtz"
            }
          }
        ]
        Precedence = 9
        Type       = "consul"
      },
      {
        Name = "admin-dashboard-webapp",
        Permissions = [
          {
            Action = "deny",
            HTTP = {
              PathPrefix = "/debugz"
            }
          },
          {
            Action = "allow"
            HTTP = {
              PathPrefix = "/"
            }
          }
        ],
        Precedence = 9
        Type       = "consul"
      }
    ]
  })

  depends_on = [
    module.consul_config_entry_sd
  ]
}

```

## Module Input Variables
----------------------
- `name` - Set name for Consul namespace if doesnt set config entry's name properly (`default = False`)
- `environment` - Set env for Consul config entry if does not set name (`default = dev`)
- `enable_config_entry` - Enable config entry for Consul usage (`default = False`)
- `config_entry_name` - The name of the configuration entry being registred. (`default = ""`)
- `config_entry_kind` - (Required) The kind of configuration entry to register. (`default = null`)
- `config_entry_config_json` - (Optional) An arbitrary map of configuration values. (`default = null`)

## Module Output Variables
----------------------
- `consul_config_entry_id` - The id of the configuration entry.
- `consul_config_entry_kind` - The kind of the configuration entry.
- `consul_config_entry_name` - The name of the configuration entry.
- `consul_config_entry_config_json` - A map of configuration values.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
