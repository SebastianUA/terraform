# Work with PROMETHEUS via terraform

A terraform module for making PROMETHEUS.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-west-2"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "prometheus" {
  source = "../../modules/prometheus"

  enable_prometheus_workspace = true
  prometheus_workspace_alias  = "prometheus-test"
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_prometheus_workspace` - Enable prometheus workspace usage (`default = False`)
- `prometheus_workspace_alias` - (Optional) The alias of the prometheus workspace. See more in AWS Docs. (`default = null`)

## Module Output Variables
----------------------
- `prometheus_workspace_id` - Identifier of the workspace
- `prometheus_workspace_arn` - Amazon Resource Name (ARN) of the workspace.
- `prometheus_workspace_prometheus_endpoint` - Prometheus endpoint available for this workspace.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
