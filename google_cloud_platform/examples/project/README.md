# Work with PROJECT via terraform

A terraform module for making PROJECT.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

provider "google" {
  credentials = file("/Users/captain/.config/gcloud/creds/terraform_creds.json")
  #project     = "terraform-2018"
  #region      = "us-east-1"
}

module "project" {
  source = "../../modules/project"
  name   = "project-test"

  #To create folder for your org
  #billing_account                 = "01CD39-CD38F1-EB4117"
  #org_id                          = "185316671747"

  #To spicific folder of your org
  project_id             = "project-test-2018"
  enable_specific_folder = true
  org_id                 = "185316671747"

  #
  google_project_services = ["iam.googleapis.com", "cloudresourcemanager.googleapis.com"]

}

```

## Module Input Variables
----------------------
- `name` -  The name of the project (`default = project`)
- `environment` - Environment for service (`default = STAGE`)
- `orchestration` - Type of orchestration (`default = Terraform`)
- `createdby` - Created by (`default = Vitaliy Natarov`)
- `billing_account` - Billing account (`default = ""`)
- `org_id` - Org ID (`default = ""`)
- `enable_specific_folder` - Enable specific folder under your organization (`default = False`)
- `project_id` - The project ID. Changing this forces a new project to be created. (`default = ""`)
- `skip_delete` - If true, the Terraform resource can be deleted without deleting the Project via the Google API. (`default = False`)
- `auto_create_network` - (Optional) Create the 'default' network automatically. Default true. Note: this might be more accurately described as 'Delete Default Network', since the network is created automatically then deleted before project creation returns, but we choose this name to match the GCP Console UI. Setting this field to false will enable the Compute Engine API which is required to delete the network. (`default = True`)
- `google_project_services` - The list of services that are enabled. Supports update. (`default = []`)
- `disable_on_destroy` - (Optional) If true, disable the service when the terraform resource is destroyed. Defaults to true. May be useful in the event that a project is long-lived but the infrastructure running in that project changes frequently. (`default = True`)
- `enable_organization_iam_policy` - Enable add an organization iam policy (`default = False`)
- `enable_organization_iam_member` - Enable add an organization iam member (`default = False`)
- `enable_organization_iam_custom_role` - Enable add an organization iam custom role (`default = False`)
- `enable_organization_iam_binding` - Enable add an organization iam binding (`default = False`)

## Module Output Variables
----------------------
