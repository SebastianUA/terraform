# Work with CONSUL_AUTOPILOT_CONFIG via terraform

A terraform module for making CONSUL_AUTOPILOT_CONFIG.


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

module "consul_autopilot_config" {
  source = "../../modules/consul_autopilot_config"

  enable_autopilot_config                 = true
  autopilot_config_cleanup_dead_servers   = false
  autopilot_config_last_contact_threshold = "1s"
  autopilot_config_max_trailing_logs      = 500
}

```

## Module Input Variables
----------------------
- `enable_autopilot_config` - Enable autopilot config for Consul usage (`default = False`)
- `autopilot_config_cleanup_dead_servers` - (Optional) Whether to remove failing servers when a replacement comes online. Defaults to true. (`default = null`)
- `autopilot_config_last_contact_threshold` - (Optional) The time after which a server is considered as unhealthy and will be removed. Defaults to '200ms' (`default = null`)
- `autopilot_config_max_trailing_logs` - (Optional) The maximum number of Raft log entries a server can trail the leader. Defaults to 250. (`default = null`)
- `autopilot_config_datacenter` - (Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup. (`default = null`)
- `autopilot_config_server_stabilization_time` - (Optional) The period to wait for a server to be healthy and stable before being promoted to a full, voting member. Defaults to '10s'. (`default = null`)
- `autopilot_config_redundancy_zone_tag` - (Optional) The redundancy zone tag to use. Consul will try to keep one voting server by zone to take advantage of isolated failure domains. Defaults to an empty string. (`default = null`)
- `autopilot_config_disable_upgrade_migration` - (Optional) Whether to disable upgrade migrations. Defaults to false. (`default = null`)
- `autopilot_config_upgrade_version_tag` - (Optional) The tag to override the version information used during a migration. Defaults to an empty string. (`default = null`)

## Module Output Variables
----------------------
- `consul_autopilot_config_id` - ID of Counsul autopilot config
- `consul_autopilot_config_datacenter` - The datacenter used.
- `consul_autopilot_config_cleanup_dead_servers` - Whether to remove failing servers.
- `consul_autopilot_config_last_contact_threshold` - The time after which a server is considered as unhealthy and will be removed.
- `consul_autopilot_config_max_trailing_logs` - The maximum number of Raft log entries a server can trail the leader.
- `consul_autopilot_config_server_stabilization_time` - The period to wait for a server to be healthy and stable before being promoted to a full, voting member.
- `consul_autopilot_config_redundancy_zone_tag` - The redundancy zone tag used. Consul will try to keep one voting server by zone to take advantage of isolated failure domains.
- `consul_autopilot_config_disable_upgrade_migration` - Whether to disable upgrade migrations.
- `consul_autopilot_config_upgrade_version_tag` - The tag to override the version information used during a migration.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
