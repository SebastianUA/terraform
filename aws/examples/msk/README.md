# Work with AWS MSK via terraform
                                
A terraform module for making manages AWS Managed Streaming for Kafka.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```

```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix  (`default     = "TEST-ACM`)
- `region` - The region where to deploy this code (e.g. us-east-1)-  (`default     = "us-east-1`)
- `environment` - Environment for service (`  default     = "STAGE`)

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
