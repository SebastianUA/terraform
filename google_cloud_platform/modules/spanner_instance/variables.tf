variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "project" {
    description = "(Optional) The ID of the project in which to look for the instance specified. If it is not provided, the provider project is used."
    default     = ""
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "config" {
    description = "(Required) The name of the instance's configuration (similar but not quite the same as a region) which defines defines the geographic placement and replication of your databases in this instance. It determines where your data is stored. Values are typically of the form regional-europe-west1 , us-central etc. In order to obtain a valid list please consult the Configuration section of the docs."
    default     = "nam3"
}

variable "display_name" {
    description = "(Required) The descriptive name for this instance as it appears in UIs. Can be updated, however should be kept globally unique to avoid confusion."
    default     = ""
}

variable "num_nodes" {
    description = "(Optional, Computed) The number of nodes allocated to this instance. Defaults to 1. This can be updated after creation."
    default     = "1"
}

variable "enable_spanner_instance_iam_policy" {
    description = "Enable spanner instance iam policy"
    default     = "false"
}

variable "role" {
    description = "(Required) The role that should be applied. Only one google_spanner_instance_iam_binding can be used per role. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}."
    default     = "roles/editor"
}

variable "members" {
    description = "(Required) Identities that will be granted the privilege in role."
    default     = []
}

variable "instance" {
    description = "(Required) The name of the instance."
    default     = ""
}

variable "enable_spanner_instance_iam_binding" {
    description = "Enable spanner instance iam binding"
    default     = "false"
}

variable "enable_spanner_instance_iam_member" {
    description = "Enable spanner instance iam member"
    default     = "false"
}

variable "enable_spanner_database" {
    description = "Enable spanner DB"
    default     = "false"
}

variable "db_name" {
    description = "(Required) The name of the database."
    default     = "db-test"
}

variable "ddl" {
    description = "(Optional) An optional list of DDL statements to run inside the newly created database. Statements can create tables, indexes, etc. These statements execute atomically with the creation of the database: if there is an error in any statement, the database is not created."
    default     = []
}

variable "enable_spanner_database_iam_policy" {
    description = "Enable spanner database iam policy"
    default     = "false"
}

variable "enable_spanner_database_iam_binding" {
    description = "Enable spanner database iam binding"
    default     = "false"
}

variable "enable_spanner_database_iam_member" {
    description = "Enable spanner database iam member"
    default     = "false"
}
