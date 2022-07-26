# Work with CONSUL_PREPARED_QUERY via terraform

A terraform module for making CONSUL_PREPARED_QUERY.


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

module "consul_prepared_query" {
  source = "../../modules/consul_prepared_query"

  enable_prepared_query  = true
  prepared_query_name    = "prepared-query-name"
  prepared_query_service = "myapp"

  prepared_query_datacenter   = "us-central1"
  prepared_query_token        = "abcd"
  prepared_query_stored_token = "wxyz"
  prepared_query_only_passing = true
  prepared_query_near         = "_agent"

  prepared_query_failover = [
    {
      nearest_n   = 3
      datacenters = ["us-west1", "us-east-2", "asia-east1"]
    }
  ]

  prepared_query_dns = [
    {
      ttl = "30s"
    }
  ]

  prepared_query_template = [
    {
      type   = "name_prefix_match"
      regexp = "^(.*)-near-self$"
    }
  ]

  prepared_query_tags = ["active", "!standby"]
}

```

## Module Input Variables
----------------------
- `name` - Set name for Consul namespace if doesnt set namespace's name properly (`default = False`)
- `environment` - Set env for Consul namespace if does not set name (`default = dev`)
- `enable_prepared_query` - Enable prepared query for Consul usage (`default = False`)
- `prepared_query_name` - The name of the prepared query. Used to identify the prepared query during requests. Can be specified as an empty string to configure the query as a catch-all. (`default = ""`)
- `prepared_query_service` - (Required) The name of the service to query. (`default = null`)
- `prepared_query_datacenter` - (Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup. (`default = null`)
- `prepared_query_token` - (Optional) The ACL token to use when saving the prepared query. This overrides the token that the agent provides by default. (`default = null`)
- `prepared_query_stored_token` - (Optional) The ACL token to store with the prepared query. This token will be used by default whenever the query is executed. (`default = null`)
- `prepared_query_session` - (Optional) The name of the Consul session to tie this query's lifetime to. This is an advanced parameter that should not be used without a complete understanding of Consul sessions and the implications of their use (it is recommended to leave this blank in nearly all cases). If this parameter is omitted the query will not expire. (`default = null`)
- `prepared_query_only_passing` - (Optional) When true, the prepared query will only return nodes with passing health checks in the result. (`default = null`)
- `prepared_query_connect` - (Optional) When true the prepared query will return connect proxy services for a queried service. Conditions such as tags in the prepared query will be matched against the proxy service. Defaults to false. (`default = null`)
- `prepared_query_near` - (Optional) Allows specifying the name of a node to sort results near using Consul's distance sorting and network coordinates. The magic _agent value can be used to always sort nearest the node servicing the request. (`default = null`)
- `prepared_query_ignore_check_ids` - (Optional) Specifies a list of check IDs that should be ignored when filtering unhealthy instances. This is mostly useful in an emergency or as a temporary measure when a health check is found to be unreliable. Being able to ignore it in centrally-defined queries can be simpler than de-registering the check as an interim solution until the check can be fixed. (`default = null`)
- `prepared_query_node_meta` - (Optional) Specifies a list of user-defined key/value pairs that will be used for filtering the query results to nodes with the given metadata values present. (`default = null`)
- `prepared_query_template` - (Optional) Query templating options. This is used to make a single prepared query respond to many different requests. (`default = []`)
- `prepared_query_failover` - (Optional) Options for controlling behavior when no healthy nodes are available in the local DC. (`default = []`)
- `prepared_query_dns` - (Optional) Settings for controlling the DNS response details. (`default = []`)
- `prepared_query_tags` - (Optional) The list of required and/or disallowed tags. If a tag is in this list it must be present. If the tag is preceded with a '!' then it is disallowed. (`default = null`)

## Module Output Variables
----------------------
- `consul_prepared_query_id` - The ID of the prepared query, generated by Consul.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
