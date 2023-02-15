# Work with RDS_PROXY via terraform

A terraform module for making RDS_PROXY.


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
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}


module "rds_proxy" {
  source = "../../modules/rds_proxy"

  name        = "Test"
  environment = "stage"

  // db proxy
  enable_db_proxy         = true
  db_proxy_name           = ""
  db_proxy_engine_family  = ""
  db_proxy_role_arn       = ""
  db_proxy_vpc_subnet_ids = []
  db_proxy_auth = [
    {
      description = null
      username    = null
      auth_scheme = null
      iam_auth    = null
      secret_arn  = null
    }
  ]

  // db proxy default target group
  enable_db_proxy_default_target_group = true
  db_proxy_default_target_group_connection_pool_config = {
    connection_borrow_timeout    = null
    init_query                   = null
    max_connections_percent      = null
    max_idle_connections_percent = null
    session_pinning_filters      = null
  }

  // db proxy target
  enable_db_proxy_target                 = true
  db_proxy_target_db_instance_identifier = null
  db_proxy_target_db_cluster_identifier  = null

  // db proxy endpoint
  enable_db_proxy_endpoint                 = true
  db_proxy_endpoint_db_proxy_endpoint_name = ""
  db_proxy_endpoint_vpc_subnet_ids         = []
  db_proxy_endpoint_vpc_security_group_ids = []
  db_proxy_endpoint_target_role            = null

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST-RDS-PROXY`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_db_proxy` - Enable db proxy usage (`default = False`)
- `db_proxy_name` - The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region. An identifier must begin with a letter and must contain only ASCII letters, digits, and hyphens; it can't end with a hyphen or contain two consecutive hyphens. (`default = ""`)
- `db_proxy_engine_family` - (Required, Forces new resource) The kinds of databases that the proxy can connect to. This value determines which database network protocol the proxy recognizes when it interprets network traffic to and from the database. The engine family applies to MySQL and PostgreSQL for both RDS and Aurora. Valid values are MYSQL and POSTGRESQL (`default = null`)
- `db_proxy_role_arn` - (Required) The Amazon Resource Name (ARN) of the IAM role that the proxy uses to access secrets in AWS Secrets Manager. (`default = null`)
- `db_proxy_vpc_subnet_ids` - (Required) One or more VPC subnet IDs to associate with the new proxy. (`default = []`)
- `db_proxy_auth` - (Required) Configuration block(s) with authorization mechanisms to connect to the associated instances or clusters. (`default = []`)
- `db_proxy_debug_logging` - (Optional) Whether the proxy includes detailed information about SQL statements in its logs. This information helps you to debug issues involving SQL behavior or the performance and scalability of the proxy connections. The debug information includes the text of SQL statements that you submit through the proxy. Thus, only enable this setting when needed for debugging, and only when you have security measures in place to safeguard any sensitive information that appears in the logs. (`default = null`)
- `db_proxy_idle_client_timeout` - (Optional) The number of seconds that a connection to the proxy can be inactive before the proxy disconnects it. You can set this value higher or lower than the connection timeout limit for the associated database. (`default = null`)
- `db_proxy_require_tls` - (Optional) A Boolean parameter that specifies whether Transport Layer Security (TLS) encryption is required for connections to the proxy. By enabling this setting, you can enforce encrypted TLS connections to the proxy. (`default = null`)
- `db_proxy_vpc_security_group_ids` - (Optional) One or more VPC security group IDs to associate with the new proxy. (`default = null`)
- `db_proxy_timeouts` - Set timeouts for DB proxy (`default = {}`)
- `enable_db_proxy_default_target_group` - Enable db proxy default target group usage (`default = False`)
- `db_proxy_default_target_group_db_proxy_name` - Name of the RDS DB Proxy. (`default = ""`)
- `db_proxy_default_target_group_timeouts` - Set timeouts for DB proxy default target group (`default = {}`)
- `enable_db_proxy_target` - Enable db proxy target usage (`default = False`)
- `db_proxy_target_db_proxy_name` - The name of the DB proxy. (`default = ""`)
- `db_proxy_default_target_group_connection_pool_config` - (Optional) The settings that determine the size and behavior of the connection pool for the target group. (`default = {}`)
- `db_proxy_target_target_group_name` - The name of the target group. (`default = ""`)
- `db_proxy_target_db_instance_identifier` - (Optional, Forces new resource) DB instance identifier. (`default = null`)
- `db_proxy_target_db_cluster_identifier` - (Optional, Forces new resource) DB cluster identifier. (`default = null`)
- `enable_db_proxy_endpoint` - Enable db proxy endpoint usage (`default = False`)
- `db_proxy_endpoint_db_proxy_endpoint_name` - The identifier for the proxy endpoint. An identifier must begin with a letter and must contain only ASCII letters, digits, and hyphens; it can't end with a hyphen or contain two consecutive hyphens. (`default = ""`)
- `db_proxy_endpoint_db_proxy_name` - The name of the DB proxy associated with the DB proxy endpoint that you create. (`default = ""`)
- `db_proxy_endpoint_vpc_subnet_ids` - (Required) One or more VPC subnet IDs to associate with the new proxy. (`default = []`)
- `db_proxy_endpoint_vpc_security_group_ids` - (Optional) One or more VPC security group IDs to associate with the new proxy. (`default = []`)
- `db_proxy_endpoint_target_role` - (Optional) Indicates whether the DB proxy endpoint can be used for read/write or read-only operations. The default is READ_WRITE. Valid values are READ_WRITE and READ_ONLY. (`default = null`)
- `db_proxy_endpoint_timeouts` - Set timeouts for db proxy endpoint (`default = {}`)

## Module Output Variables
----------------------
- `db_proxy_id` - The Amazon Resource Name (ARN) for the proxy.
- `db_proxy_arn` - The Amazon Resource Name (ARN) for the proxy.
- `db_proxy_endpoint` - The endpoint that you can use to connect to the proxy. You include the endpoint value in the connection string for a database client application.
- `db_proxy_default_target_group_id` - Name of the RDS DB Proxy.
- `db_proxy_default_target_group_arn` - The Amazon Resource Name (ARN) representing the target group.
- `db_proxy_default_target_group_name` - The name of the default target group.
- `db_proxy_target_id` - Identifier of db_proxy_name, target_group_name, target type (e.g. RDS_INSTANCE or TRACKED_CLUSTER), and resource identifier separated by forward slashes (/).
- `db_proxy_target_endpoint` - Hostname for the target RDS DB Instance. Only returned for RDS_INSTANCE type.
- `db_proxy_target_port` - Port for the target RDS DB Instance or Aurora DB Cluster.
- `db_proxy_target_rds_resource_id` - Identifier representing the DB Instance or DB Cluster target.
- `db_proxy_target_target_arn` - Amazon Resource Name (ARN) for the DB instance or DB cluster. Currently not returned by the RDS API.
- `db_proxy_target_tracked_cluster_id` - DB Cluster identifier for the DB Instance target. Not returned unless manually importing an RDS_INSTANCE target that is part of a DB Cluster.
- `db_proxy_target_type` - Type of target. e.g. RDS_INSTANCE or TRACKED_CLUSTER
- `db_proxy_endpoint_id` - The name of the proxy and proxy endpoint separated by /, DB-PROXY-NAME/DB-PROXY-ENDPOINT-NAME.
- `db_proxy_endpoint_arn` - The Amazon Resource Name (ARN) for the proxy endpoint.
- `db_proxy_endpoint_endpoint` - The endpoint that you can use to connect to the proxy. You include the endpoint value in the connection string for a database client application.
- `db_proxy_endpoint_is_default` - Indicates whether this endpoint is the default endpoint for the associated DB proxy.
- `db_proxy_endpoint_vpc_id` - The VPC ID of the DB proxy endpoint.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
