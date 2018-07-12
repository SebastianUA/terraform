# Work with Google Cloud  Platform (compute image) via terraform

A terraform module for making google compute_image.
 
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
module "compute_image" {
    source                              = "../../modules/compute_image"
    name                                = "TEST"

    project                             = "terraform-2018"
    raw_disk_source                     = "https://storage.googleapis.com/my-bucket/my-disk-image-tarball.tar.gz"
}


```

Module Input Variables
----------------------
- `name` - A unique name for the resource, required by GCE. Changing this forces a new resource to be created (`default     = "TEST"`).
- `zone` - The zone that the machine should be created in (`default     = "us-east1-b"`).
- `project` - The project in which the resource belongs. If it is not provided, the provider project is used. If you are using a public base image, be sure to specify the correct Image Project (`default     = ""`).
- `environment` -  Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration  (`default     = "Terraform"`).
- `description` - An optional description of this image (`default     = ""`).
- `family` - The family name of the image (`default     = "centos"`).
- `source_disk` - The URL of the source disk used to create this image (`default     = ""`).
- `raw_disk_source` - The full Google Cloud Storage URL where the disk image is stored (`default     = ""`).
- `raw_disk_sha1` - SHA1 checksum of the source tarball that will be used to verify the source before creating the image (`default     = ""`).
- `raw_disk_container_type` - The format used to encode and transmit the block device. TAR is the only supported type and is the default (`default     = "TAR"`).
- `timeouts_create` - Set timeouts for create. Default is 5 minutes (`default     = "5m"`).
- `timeouts_update` - Set timeouts for update. Default is 4 minutes (`default     = "4m"`).
- `timeouts_delete` - Set timeouts for delete. Default is 4 minutes (`default     = "4m"`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
