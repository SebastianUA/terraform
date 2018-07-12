# Work with Google Cloud  Platform (project) via terraform

A terraform module for making google cloud project.
 
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
    #credentials = "${file("/Users/captain/.config/gcloud/creds/captain_creds.json")}"
    credentials = "${file("/Users/captain/.config/gcloud/creds/terraform_creds.json")}"
    #project     = "terraform-2018"
    #region      = "us-east-1"
}
module "project" {
    source                          = "../../modules/project"
    name                            = "project-test"

    #To create folder for your org
    #billing_account                 = "01CD39-CD38F1-EB4117"
    #org_id                          = "185316671747"

    #To spicific folder of your org
    project_id                      = "project-test-2018"
    enable_specific_folder          = true
    org_id                          = "185316671747"

    #
    google_project_services         = ["iam.googleapis.com", "cloudresourcemanager.googleapis.com"]

}
```

Module Input Variables
----------------------
- `name` - The name of the record (`default     = "project-test"`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
