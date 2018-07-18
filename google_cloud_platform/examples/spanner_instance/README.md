# Work with Google Cloud  Platform (spanner instance) via terraform

A terraform module for making google spanner instance.
 
## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "google" {
    credentials = "${file("/Users/captain/.config/gcloud/creds/terraform_creds.json")}"
    project     = "terraform-2018"
    region      = "us-east1"
}   
module "spanner_instance" {
    source                              = "../../modules/spanner_instance"
    name                                = "TEST"

    num_nodes                           = 1
    
    # spanner instance iam policy
    #enable_spanner_instance_iam_policy  = true
    #instance                            = "test-si-stage"
    #members                             = ["user:solo.metaliSebastian@gmail.com",]
    #role                                = "roles/editor"    
    #
    # spanner instance iam binding
    #enable_spanner_instance_iam_binding = true
    #instance                            = "test-si-stage"
    #members                             = [
    #    "user:solo.metaliSebastian@gmail.com",
    #]
    #role                                = "roles/editor"    
    #
    # spanner instance iam member
    #enable_spanner_instance_iam_member  = true
    #instance                            = "test-si-stage"
    #members                             = [
    #    "user:solo.metaliSebastian@gmail.com",
    #]
    #role                                = "roles/editor"
    #
    # spanner_database
    #enable_spanner_database             = true
    #instance                            = "test-si-stage"
    #db_name                             = "db-test"
    #ddl                                 = [
    #]
    #
    # Create spanner database iam
    #enable_spanner_database_iam_policy  = true
    #instance                            = "test-si-stage"
    #members                             = [
    #    "user:solo.metaliSebastian@gmail.com",
    #]
    #role                                = "roles/editor"
    #
    # spanner_database_iam_binding
    #enable_spanner_database_iam_binding = true
    #instance                            = "test-si-stage"
    #members                             = [
    #    "user:solo.metaliSebastian@gmail.com",
    #]
    #role                                = "roles/editor"
    #
    # spanner_database_iam_member
    #enable_spanner_database_iam_member  = true
    #instance                            = "test-si-stage"
    #members                             = [
    #    "user:solo.metaliSebastian@gmail.com",
    #]
    #role                                = "roles/editor"
} 
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `project` - "(Optional) The ID of the project in which to look for the instance specified. If it is not provided, the provider project is used." (`    default     = ""`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `config` - "(Required) The name of the instance's configuration (similar but not quite the same as a region) which defines defines the geographic placement and replication of your databases in this instance. It determines where your data is stored. Values are typically of the form regional-europe-west1 , us-central etc. In order to obtain a valid list please consult the Configuration section of the docs." (`    default     = "nam3"`)
- `display_name` - "(Required) The descriptive name for this instance as it appears in UIs. Can be updated, however should be kept globally unique to avoid confusion." (`    default     = ""`)
- `num_nodes` - "(Optional, Computed) The number of nodes allocated to this instance. Defaults to 1. This can be updated after creation." (`    default     = "1"`)
- `enable_spanner_instance_iam_policy` - "Enable spanner instance iam policy" (`    default     = "false"`)
- `role` - "(Required) The role that should be applied. Only one google_spanner_instance_iam_binding can be used per role. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}." (`    default     = "roles/editor"`)
- `members` - "(Required) Identities that will be granted the privilege in role." (`    default     = []`)
- `instance` - "(Required) The name of the instance." (`    default     = ""`)
- `enable_spanner_instance_iam_binding` - "Enable spanner instance iam binding" (`    default     = "false"`)
- `enable_spanner_instance_iam_member` - "Enable spanner instance iam member" (`    default     = "false"`)
- `enable_spanner_database` - "Enable spanner DB" (`    default     = "false"`)
- `db_name` - "(Required) The name of the database." (`    default     = "db-test"`)
- `ddl` - "(Optional) An optional list of DDL statements to run inside the newly created database. Statements can create tables, indexes, etc. These statements execute atomically with the creation of the database: if there is an error in any statement, the database is not created." (`    default     = []`)
- `enable_spanner_database_iam_policy` - "Enable spanner database iam policy" (`    default     = "false"`)
- `enable_spanner_database_iam_binding` - "Enable spanner database iam binding" (`    default     = "false"`)
- `enable_spanner_database_iam_member` - "Enable spanner database iam member" (`    default     = "false"`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
