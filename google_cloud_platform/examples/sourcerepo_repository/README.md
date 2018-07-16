# Work with Google Cloud  Platform (sourcerepo repository) via terraform

A terraform module for making google sourcerepo repository.
 
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
module "sourcerepo_repository" {
    source                              = "../../modules/sourcerepo_repository"
    name                                = "TEST"
    
}

```

Module Input Variables
----------------------
- `name` - "(Required) The name of the repository that will be created." (`    default     = "TEST"`)
- `project` - "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used." (`  default     = ""    `)
- `environment` - "Environment for service" (`    default     = "STAGE"`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
