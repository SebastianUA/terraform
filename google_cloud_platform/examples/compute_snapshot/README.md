# Work with Google Cloud  Platform (compute snapshot) via terraform

A terraform module for making google compute snapshot.
 
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

module "compute_snapshot" {
    source                          = "../../modules/compute_snapshot"
    name                            = "TEST"

    source_disk                     = "gke-test-cc-stage-70df-pvc-afc95369-90e1-11e8-96dc-42010a8e0109"
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `project` - "The project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `zone` - "(Required) The zone where the source disk is located." (`    default     = "us-east1-b"`)
- `source_disk` - "(Required) The disk which will be used as the source of the snapshot." (`    default     = ""`)
- `source_disk_encryption_key_raw` - "(Optional) A 256-bit customer-supplied encryption key, encoded in RFC 4648 base64 to decrypt the source disk." (`    default     = ""`)
- `snapshot_encryption_key_raw` - "(Optional) A 256-bit customer-supplied encryption key, encoded in RFC 4648 base64 to encrypt this snapshot." (`    default     = ""`)

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
