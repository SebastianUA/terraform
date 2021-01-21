#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "Set name for Consul namespace if doesnt set namespace's name properly"
  default     = false
}

variable "environment" {
  description = "Set env for Consul namespace if does not set name"
  default     = "dev"
}

#---------------------------------------------------
# Consul prepared query
#---------------------------------------------------
variable "enable_prepared_query" {
  description = "Enable prepared query for Consul usage"
  default     = false
}

variable "prepared_query_name" {
  description = "The name of the prepared query. Used to identify the prepared query during requests. Can be specified as an empty string to configure the query as a catch-all."
  default     = ""
}

variable "prepared_query_service" {
  description = "(Required) The name of the service to query."
  default     = null
}

variable "prepared_query_datacenter" {
  description = "(Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup."
  default     = null
}

variable "prepared_query_token" {
  description = "(Optional) The ACL token to use when saving the prepared query. This overrides the token that the agent provides by default."
  default     = null
}

variable "prepared_query_stored_token" {
  description = "(Optional) The ACL token to store with the prepared query. This token will be used by default whenever the query is executed."
  default     = null
}

variable "prepared_query_session" {
  description = "(Optional) The name of the Consul session to tie this query's lifetime to. This is an advanced parameter that should not be used without a complete understanding of Consul sessions and the implications of their use (it is recommended to leave this blank in nearly all cases). If this parameter is omitted the query will not expire."
  default     = null
}

variable "prepared_query_only_passing" {
  description = "(Optional) When true, the prepared query will only return nodes with passing health checks in the result."
  default     = null
}

variable "prepared_query_connect" {
  description = "(Optional) When true the prepared query will return connect proxy services for a queried service. Conditions such as tags in the prepared query will be matched against the proxy service. Defaults to false."
  default     = null
}

variable "prepared_query_near" {
  description = "(Optional) Allows specifying the name of a node to sort results near using Consul's distance sorting and network coordinates. The magic _agent value can be used to always sort nearest the node servicing the request."
  default     = null
}

variable "prepared_query_ignore_check_ids" {
  description = "(Optional) Specifies a list of check IDs that should be ignored when filtering unhealthy instances. This is mostly useful in an emergency or as a temporary measure when a health check is found to be unreliable. Being able to ignore it in centrally-defined queries can be simpler than de-registering the check as an interim solution until the check can be fixed."
  default     = null
}

variable "prepared_query_node_meta" {
  description = "(Optional) Specifies a list of user-defined key/value pairs that will be used for filtering the query results to nodes with the given metadata values present."
  default     = null
}

variable "prepared_query_template" {
  description = "(Optional) Query templating options. This is used to make a single prepared query respond to many different requests."
  default     = []
}

variable "prepared_query_failover" {
  description = "(Optional) Options for controlling behavior when no healthy nodes are available in the local DC."
  default     = []
}

variable "prepared_query_dns" {
  description = "(Optional) Settings for controlling the DNS response details."
  default     = []
}

variable "prepared_query_tags" {
  description = "(Optional) The list of required and/or disallowed tags. If a tag is in this list it must be present. If the tag is preceded with a '!' then it is disallowed."
  default     = null
}
