# Work with Google Cloud  Platform (google dns) via terraform

A terraform module for making google DNS.
 
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
module "google_dns" {
    source                              = "../../modules/google_dns"
    name                                = "TEST"
    # DNS Zone    
    enable_dns_managed_zone             = true
    description                         = "linux-notes.org"
    dns_name                            = "linux-notes.org."
    # DNS record
    enable_dns_record_set               = true
    managed_zone                        = "test-dns-mz-stage"
    rrdatas                             = ["8.8.8.8"]
        
}

```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `enable_dns_managed_zone` - "Enable DNS managed zone" (`    default     = "true"`)
- `description` - "(Optional) A textual description field. Defaults to 'Managed by Terraform'." (`    default     = ""`)
- `project` - "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `dns_name` - "(Required) The fully qualified DNS name of this zone, e.g. terraform.io.." (`    default     = ""`)
- `enable_dns_record_set` - "Enable DNS record set"  (`    default     = "true"`)
- `type` - "(Required) The DNS record set type (Ex: A, CNAME, MX, TXT)" (`    default     = "A"`)
- `ttl` - "(Required) The time-to-live of this record set (seconds)." (`    default     = 300`)
- `managed_zone` - "(Required) The name of the zone in which this record set will reside." (`    default     = ""`)
- `rrdatas` - "(Required) The string data for the records in this record set whose meaning depends on the DNS type. For TXT record, if the string data contains spaces, add surrounding \" if you don't want your string to get split on spaces." (`    default     = []`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
