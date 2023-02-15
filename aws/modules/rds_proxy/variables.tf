#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-RDS-PROXY"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS DB proxy
#---------------------------------------------------
variable "enable_db_proxy" {
  description = "Enable db proxy usage"
  default     = false
}

variable "db_proxy_name" {
  description = "The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region. An identifier must begin with a letter and must contain only ASCII letters, digits, and hyphens; it can't end with a hyphen or contain two consecutive hyphens."
  default     = ""
}

variable "db_proxy_engine_family" {
  description = "(Required, Forces new resource) The kinds of databases that the proxy can connect to. This value determines which database network protocol the proxy recognizes when it interprets network traffic to and from the database. The engine family applies to MySQL and PostgreSQL for both RDS and Aurora. Valid values are MYSQL and POSTGRESQL"
  default     = null
}

variable "db_proxy_role_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of the IAM role that the proxy uses to access secrets in AWS Secrets Manager."
  default     = null
}

variable "db_proxy_vpc_subnet_ids" {
  description = "(Required) One or more VPC subnet IDs to associate with the new proxy."
  default     = []
}

variable "db_proxy_auth" {
  description = "(Required) Configuration block(s) with authorization mechanisms to connect to the associated instances or clusters."
  default     = []
}

variable "db_proxy_debug_logging" {
  description = "(Optional) Whether the proxy includes detailed information about SQL statements in its logs. This information helps you to debug issues involving SQL behavior or the performance and scalability of the proxy connections. The debug information includes the text of SQL statements that you submit through the proxy. Thus, only enable this setting when needed for debugging, and only when you have security measures in place to safeguard any sensitive information that appears in the logs."
  default     = null
}

variable "db_proxy_idle_client_timeout" {
  description = "(Optional) The number of seconds that a connection to the proxy can be inactive before the proxy disconnects it. You can set this value higher or lower than the connection timeout limit for the associated database."
  default     = null
}

variable "db_proxy_require_tls" {
  description = "(Optional) A Boolean parameter that specifies whether Transport Layer Security (TLS) encryption is required for connections to the proxy. By enabling this setting, you can enforce encrypted TLS connections to the proxy."
  default     = null
}

variable "db_proxy_vpc_security_group_ids" {
  description = "(Optional) One or more VPC security group IDs to associate with the new proxy."
  default     = null
}

variable "db_proxy_timeouts" {
  description = "Set timeouts for DB proxy"
  default     = {}
}

#---------------------------------------------------
# AWS DB proxy default target group
#---------------------------------------------------
variable "enable_db_proxy_default_target_group" {
  description = "Enable db proxy default target group usage"
  default     = false
}

variable "db_proxy_default_target_group_db_proxy_name" {
  description = "Name of the RDS DB Proxy."
  default     = ""
}

variable "db_proxy_default_target_group_timeouts" {
  description = "Set timeouts for DB proxy default target group"
  default     = {}
}

#---------------------------------------------------
# AWS DB proxy target
#---------------------------------------------------
variable "enable_db_proxy_target" {
  description = "Enable db proxy target usage"
  default     = false
}

variable "db_proxy_target_db_proxy_name" {
  description = "The name of the DB proxy."
  default     = ""
}

variable "db_proxy_default_target_group_connection_pool_config" {
  description = "(Optional) The settings that determine the size and behavior of the connection pool for the target group."
  default     = {}
}

variable "db_proxy_target_target_group_name" {
  description = "The name of the target group."
  default     = ""
}

variable "db_proxy_target_db_instance_identifier" {
  description = "(Optional, Forces new resource) DB instance identifier."
  default     = null
}

variable "db_proxy_target_db_cluster_identifier" {
  description = "(Optional, Forces new resource) DB cluster identifier."
  default     = null
}

#---------------------------------------------------
# AWS DB proxy endpoint
#---------------------------------------------------
variable "enable_db_proxy_endpoint" {
  description = "Enable db proxy endpoint usage"
  default     = false
}

variable "db_proxy_endpoint_db_proxy_endpoint_name" {
  description = "The identifier for the proxy endpoint. An identifier must begin with a letter and must contain only ASCII letters, digits, and hyphens; it can't end with a hyphen or contain two consecutive hyphens."
  default     = ""
}

variable "db_proxy_endpoint_db_proxy_name" {
  description = "The name of the DB proxy associated with the DB proxy endpoint that you create."
  default     = ""
}

variable "db_proxy_endpoint_vpc_subnet_ids" {
  description = "(Required) One or more VPC subnet IDs to associate with the new proxy."
  default     = []
}

variable "db_proxy_endpoint_vpc_security_group_ids" {
  description = "(Optional) One or more VPC security group IDs to associate with the new proxy."
  default     = []
}

variable "db_proxy_endpoint_target_role" {
  description = "(Optional) Indicates whether the DB proxy endpoint can be used for read/write or read-only operations. The default is READ_WRITE. Valid values are READ_WRITE and READ_ONLY."
  default     = null
}

variable "db_proxy_endpoint_timeouts" {
  description = "Set timeouts for db proxy endpoint"
  default     = {}
}